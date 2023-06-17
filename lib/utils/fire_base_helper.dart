import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin_side/screens/addProduct/modal/add_product_modal.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../screens/addProduct/controller/addProductController.dart';
import '../screens/addedProductPreviewScree/modal/added_product_preview_modal.dart';

class FireBaseHelper {
  static FireBaseHelper fireBaseHelper = FireBaseHelper._();
  FireBaseHelper._();


  // ToDo SignIn
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<bool?> createAccount({required email, required password}) async {
    return await firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then(
      (value) {
        return true;
      },
    ).catchError((e) {
      print("===============================");
      print(e);
      return false;
    });
  }

  bool storeLogin() {
    User? user = firebaseAuth.currentUser;
    return user != null;
  }

  Future<bool?> signOut() async {
    bool? check;
    await firebaseAuth.signOut().then((value) => check = true);
    await GoogleSignIn().signOut().then((value) => check = true);
    return check;
  }

  sinhInThroughGoogle() async {
    bool? msg;
    GoogleSignInAccount? user = await GoogleSignIn().signIn();

    GoogleSignInAuthentication? googleAuth = await user?.authentication;

    var crd = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    await firebaseAuth
        .signInWithCredential(crd)
        .then((value) => msg = true)
        .catchError((e) => msg = false);
    return msg;
  }

  Future<bool?> read({required email, required password}) async {
    bool? msg;
    await firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password)
        .then(
      (value) {
        msg = true;
      },
    ).catchError(
      (e) {
        msg = false;
      },
    );

    return msg;
  }

  // Todo Fire Base operations

  Future<void> delete(id) async {
    FirebaseFirestore inse = FirebaseFirestore.instance;
    await inse.collection("Product").doc("$id").delete();
  }

  Future<bool> addProduct(AddProductModal productDetails) async {
    FirebaseFirestore inse = FirebaseFirestore.instance;
    User? admin = await firebaseAuth.currentUser;
    // print("====================== ${productDetails.productName}");
     return inse.collection('Product').add(
      {
        "Name":productDetails.productName,
        "Price":productDetails.productPrice,
        "Discount":productDetails.productDiscount,
        "Discounted Price":productDetails.productDiscountedPrice,
        "Catedory":productDetails.productCategory,
        "Company":productDetails.productCompany,
        "Quantity":productDetails.productQuantity,
        "Description":productDetails.productDescription,
        "Uid": admin!.uid,
        "image": productDetails.image
      },
    ).then((value) {return true;});
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> readAdminAddedData() {
    FirebaseFirestore inse = FirebaseFirestore.instance;
    // User? user = firebaseAuth.currentUser;
    // print("Done ================================");
    return inse.collection('Product').snapshots();
  }
  
  Future<void> updateData(AddProductPreviewModal data) {
    FirebaseFirestore inse = FirebaseFirestore.instance;
    print("id ======================================${data.productId}");
     return inse.collection('Product').doc("${data.productId}").set({
       "Catedory":data.productCategory,
       "Company":data.productCompany,
       "Description":data.productDescription,
       "Discount":data.productDiscount,
       "Discounted Price":data.productDiscountedPrice,
       "Name":data.productName,
       "Price":data.productPrice,
       "Quantity":data.productQuantity,
       "Uid":data.productId,
       "image":data.productImage,
     });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> readUserData() {
    FirebaseFirestore inse = FirebaseFirestore.instance;
    return inse.collection("User").snapshots();
  }


  // todo category operations
  Future<QuerySnapshot<Map<String, dynamic>>> readCategoryData()
  {
    FirebaseFirestore inse = FirebaseFirestore.instance;
    return inse.collection("Category").get();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> readCategoryDataToDisplay()
  {
    FirebaseFirestore inse = FirebaseFirestore.instance;
    return inse.collection("Category").snapshots();
  }

   Future<bool> editCategory({String? category,required list})
  {
    AddProductController getx = Get.put(AddProductController());
    getx.checkAddCategory.value = false;
    List newCate = list;
    if(category != null)
      {
        print("Process");
        newCate.add(category);
      }
    FirebaseFirestore inse = FirebaseFirestore.instance;
     return inse.collection('Category').doc(getx.id).set({
      "data":newCate,
    }).then((value) {
       getx.checkAddCategory.value = true;
      return getx.checkAddCategory.value;
     });
  }

void addAdmin()
{
  User? user = firebaseAuth.currentUser;
  FirebaseFirestore inse = FirebaseFirestore.instance;
  inse.collection("Admin").add({
    "uid":"${user!.uid}"
  });
}
}
