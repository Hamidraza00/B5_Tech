import 'package:get/get.dart';
//import 'package:order_booking_shop/Models/OrderModels/OrderMasterModel.dart';
//import '../../Models/OrderModels/OrderMasterModel.dart';
import '../../Models/ProductsModel.dart';
import '../../Repositories/OrderRepository/OrderMasterRepository.dart';
import '../../Repositories/OrderRepository/ProductsRepository.dart';

class ProductsViewModel extends GetxController {
  var allProducts = <ProductsModel>[].obs;
  Rx<ProductsModel?> selectedProduct = Rx<ProductsModel?>(null); // Track selected product

  ProductsRepository productsRepository = ProductsRepository();

  @override
  void onInit() {
    super.onInit();
    fetchAllProductsModel();
  }

  fetchAllProductsModel() async {
    var products = await productsRepository.getProductsModel();
    allProducts.value = products;
  }

  // Add a method to set the selected product
  void setSelectedProduct(ProductsModel? product) {
    selectedProduct.value = product;
  }

  addProductAll(ProductsModel productsModel) {
    productsRepository.add(productsModel);
    fetchAllProductsModel();
  }

  updateProductAll(ProductsModel productsModel) {
    productsRepository.update(productsModel);
    fetchAllProductsModel();
  }

  deleteProductsAll(int id) {
    productsRepository.delete(id);
    fetchAllProductsModel();
  }
}
