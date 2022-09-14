import 'package:shop/Network/Models/change_favourites_model.dart';
import 'package:shop/Network/Models/login_model.dart';

abstract class ShopStates{}

class ShopInitialState extends ShopStates{}

class ShopLoadingHomeDataState extends ShopStates{}

class ShopSuccessHomeDataState extends ShopStates{}

class ShopErrorHomeDataState extends ShopStates{
  final String error;
  ShopErrorHomeDataState(this.error);
}

class ShopSuccessCategoriesState extends ShopStates{}

class ShopErrorCategoriesState extends ShopStates{
  final String error;

  ShopErrorCategoriesState(this.error);
}

class ChangeBottomNavState extends ShopStates{}

class ShopSuccessChangeFavoritesState extends ShopStates{

  final ChangeFavoritesModel model;

  ShopSuccessChangeFavoritesState(this.model);
}

class ShopChangeFavoritesState extends ShopStates{}



class ShopErrorChangeFavoritesState extends ShopStates{
  final String error;
  ShopErrorChangeFavoritesState(this.error);
}


class ShopSuccessGetFavoritesState extends ShopStates{}

class ShopErrorGetFavoritesState extends ShopStates{

}
class ShopLoadingGetFavoritesState extends ShopStates{}

class ShopLoadingUserDataState extends ShopStates{}

class ShopSuccessUserDataState extends ShopStates{

  final LoginModel loginModel;

  ShopSuccessUserDataState(this.loginModel);
}

class ShopErrorUserDataState extends ShopStates{
  final String error;
  ShopErrorUserDataState(this.error);
}

class ShopLoadingUpdateUserState extends ShopStates{}

class ShopSuccessUpdateUserState extends ShopStates{
  final LoginModel loginModel;

  ShopSuccessUpdateUserState(this.loginModel);

}

class ShopErrorUpdateUserState extends ShopStates{
  final String error;
  ShopErrorUpdateUserState(this.error);
}