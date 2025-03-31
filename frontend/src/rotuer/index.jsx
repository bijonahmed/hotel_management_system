// src/Router.js
import React, { Fragment } from "react";
import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
//Frontend
import Index from "../pages/Index.jsx";
import Signup from "../pages/Signup.jsx";
import Forgetpassword from "../pages/Forgetpassword.jsx";
import Register from "../pages/Register";
import Login from "../pages/Login";
import UserLogin from "../pages/UserLogin.jsx";
import ChangePassword from "../pages/users/ChangePassword.jsx";
//For Admin Panel 
import Dashboard from "../pages/Dashboard";

import MyProfile from "../pages/users/MyProfile.jsx";
import MerchantList from "../pages/users/MerchantList.jsx";
import RoleList from "../pages/users/RoleList.jsx";
import RoleAdd from "../pages/users/Addrole.jsx";
import BulkAddress from "../pages/configration/address/BulkAddress.jsx";
import DepositReport from "../pages/report/DepositReport.jsx";
import CheckLogAPI from "../pages/report/CheckLogAPI.jsx";




import RoleEdit from "../pages/users/EditRole.jsx";
import UserEdit from "../pages/users/EditUser.jsx";
import SuperAdminList from "../pages/users/SuperAdminList.jsx";
import AdminList from "../pages/users/AdminList.jsx";
import UserAdd from "../pages/users/UserAdd.jsx";
import PostCategoryList from "../pages/category/PostCategoryList.jsx";
import PostCategoryAdd from "../pages/category/PostCategoryAdd.jsx";
import PostCategoryEdit from "../pages/category/PostCategoryEdit.jsx";
import PostList from "../pages/post/PostList.jsx";
import PostAdd from "../pages/post/PostAdd.jsx";
import PostEdit from "../pages/post/PostEdit.jsx";
import GeneralCategoryList from "../pages/category/GeneralCategoryList.jsx";
import GeneralCategoryAdd from "../pages/category/GeneralCategoryAdd.jsx";
import GeneralCategoryEdit from "../pages/category/GeneralCategoryEdit.jsx";
import GlobalWalletAddressList from "../pages/wallet/GlobalWalletAddressList.jsx";
import GlobalWalletAddressAdd from "../pages/wallet/GlobalWalletAddressAdd.jsx";
import GlobalWalletAddressEdit from "../pages/wallet/GlobalWalletAddressEdit.jsx"
import ConfigrrationApiKeyList from "../pages/configration/ConfigrrationAPikeyList.jsx";
import ConfigrrationApiKeyAdd from "../pages/configration/ConfigrationApiKeyAdd.jsx";
import ConfigrrationApiKeyEdit from "../pages/configration/ConfigrationApiKeyEdit.jsx";
import StatusEdit from "../pages/report/StatusEdit.jsx";
import CheckTronScanAPI from "../pages/report/CheckTronScanAPI.jsx";

const AppRouter = () => {
  return (
    <Routes>
      {/* <Route path="/" element={<Index />} /> general-categoryAdd*/}
      <Route path="/" element={<Index />} />
      <Route path="/register" element={<Register />} />
      <Route path="/login" element={<Login />} />
      <Route path="/user-login" element={<UserLogin />} />
      <Route path="/signup" element={<Signup />} />
      <Route path="/forget-password" element={<Forgetpassword />} />
      <Route path="/user/profile" element={<MyProfile />} />
      <Route path="/user/role-list" element={<RoleList />} />
      <Route path="/user/role-add" element={<RoleAdd />} />
      <Route path="/user/user-add" element={<UserAdd />} />
      <Route path="/user/role-edit/:id" element={<RoleEdit />} />
      <Route path="/user/user-edit/:id" element={<UserEdit />} />
      <Route path="/user/merchant-list" element={<MerchantList />} />
      <Route path="/user/superadmin-list" element={<SuperAdminList />} />
      <Route path="/user/admin-list" element={<AdminList />} />
      <Route path="/report/deposit-report" element={<DepositReport />} />
      <Route path="/user/change-password" element={<ChangePassword />} />
      <Route path="/category/post-category-list" element={<PostCategoryList />} />
      <Route path="/category/post-categoryAdd" element={<PostCategoryAdd />} />
      <Route path="/category/post-category-edit/:id" element={<PostCategoryEdit />} />
      <Route path="/category/general-category-edit/:id" element={<GeneralCategoryEdit />} />
      <Route path="/report/status-edit/:id" element={<StatusEdit />} />
      <Route path="/category/global-category-list" element={<GeneralCategoryList />} />
      <Route path="/post/post-list" element={<PostList />} />
      <Route path="/post/post-add" element={<PostAdd />} />
      <Route path="/post/post-edit/:id" element={<PostEdit />} />
      <Route path="/category/general-category-add" element={<GeneralCategoryAdd />} />
      <Route path="/wallet/global-wallet-address-list" element={<GlobalWalletAddressList />} />
      <Route path="/wallet/global-wallet-address-add" element={<GlobalWalletAddressAdd />} />
      <Route path="/configration/config-api-key-list" element={<ConfigrrationApiKeyList />} />
      <Route path="/configration/config-api-key-add" element={<ConfigrrationApiKeyAdd />} />
      <Route path="/configration/config-api-key-edit/:id" element={<ConfigrrationApiKeyEdit />} />
      <Route path="/configration/address/merchant-address/:id" element={<BulkAddress />} />
      <Route path="/wallet/global-wallet-edit/:id" element={<GlobalWalletAddressEdit />} />
      <Route path="/report/tronscan-api" element={<CheckTronScanAPI />} />
      <Route path="/report/check-api-log" element={<CheckLogAPI />} />
      <Route path="/dashboard" element={<Dashboard />} />
    </Routes>
  );
};

export default AppRouter;
