abstract class Routes {
  static const splash = "splash";
  static const login = "login";
  static const layout = "layout";
  static const updateAppointment = "updateAppointment";
  static const editPersonal = "editPersonal";
  static const order = "order";
  static const shop = "shop";
  static const serviceCategory = "service-category";
  static const addresses = "addresses";
  static const auth = "auth";
  static const register = "register";
  static const forgetPassword = "forget-password";
  static const successMessage = "success-message";
  static const resetPassword = "resetPassword";
  static const resetPasswordSuccess = "resetPasswordSuccess";

  /// Removed the home route to prevent conflicts with the home route in the app.
  // static const home = "home";
  static const menu = "menu";
  static const category = "category";
  static const subCategory = "subCategory";
  static const wishlist = "wishlist";
  static const division = "division";
  static const size = "size";
  static const newProducts = "newProducts";
  static const price = "price";
  static const itemRate = "itemRate";
  static const appointmentDetails = "appointmentDetails";
  static const payment = "payment";
  static const paymentSuccess = "paymentSuccess";
  static const extraDetails = "extraDetails";
  static const address = "address";
  static const newUserAddress = "newUserAddress";
  static const addCartShipmentAddress = "addCartShipmentAddress";
  static const orderStatus = "orderStatus";
  static const orderDetails = "orderDetails";
  static const orderReturn = "orderReturn";
  static const contact = "contact";
  static const timeSlots = "timeSlots";
  static const addTimeSlots = "addTimeSlots";
  static const account = "account";
  static const changePassword = "changePassword";
  static const onlinePayment = "onlinePayment";
  static const paymentFailure = "paymentFailure";
  static const updateAddress = "updateAddress";
  static const search = "search";
  static const onboarding = "onboarding";
  static const fulfillmentCenters = "fulfillmentCenters";
  static const doctorDetails = "productDetails";
  static const chooseLanguage = "chooseLanguage";
}

extension RemoveSlash on String {
  String get removeSlash {
    try {
      if (startsWith("/")) {
        return substring(1);
      } else {
        return this;
      }
    } catch (e) {
      return this;
    }
  }
}

extension AddSlash on String {
  String get withSlash {
    try {
      if (startsWith("/")) {
        return this;
      } else {
        return "/$this";
      }
    } catch (e) {
      return this;
    }
  }
}
