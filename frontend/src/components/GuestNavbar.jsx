// src/Navbar.js
import React, { useState, useEffect } from "react";
import { Link } from "react-router-dom";
import { useNavigate } from "react-router-dom";
import AuthUser from "../components/AuthUser";
import Footer from "../components/Footer";
import axios from "/config/axiosConfig";
import $ from "jquery";

const Navbar = () => {
  const navigate = useNavigate();
  const [name, setName] = useState("");
  const { getToken, token, logout } = AuthUser();

  const fetechGlobalData = async () => {
    try {
      const response = await axios.get(`/public/getGlobalData`);
      // console.log("Navbar API Response:", response.data); // Log the response
      setName(response.data);
    } catch (error) {
      console.error("Error fetching data", error);
    }
  };

  const logoutUser = async () => {
    if (token) {
      await logout();
      navigate("/login");
    }
  };

  useEffect(() => {
    fetechGlobalData();
  }, []);

  return (
    <>
      {/* header  */}
      <div className="container-fluid bg-dark px-0">
        <div className="row gx-0">
          <div className="col-lg-3 bg-dark d-none d-lg-block">
            <Link
              to="/"
              className="navbar-brand w-100 h-100 m-0 p-0 d-flex align-items-center justify-content-center"
            >
              <h1 className="m-0 text-primary text-uppercase">{name.name}</h1>
            </Link>
          </div>
          <div className="col-lg-9">
            <div className="row gx-0 bg-white d-none d-lg-flex">
             
            </div>
            <nav className="navbar navbar-expand-lg bg-dark navbar-dark p-3 p-lg-0">
              <Link to="/" className="navbar-brand d-block d-lg-none">
                <h1 className="m-0 text-primary text-uppercase">Moon Nest</h1>
              </Link>
              <button
                type="button"
                className="navbar-toggler"
                data-bs-toggle="collapse"
                data-bs-target="#navbarCollapse"
              >
                <span className="navbar-toggler-icon" />
              </button>
              <div
                className="collapse navbar-collapse justify-content-between"
                id="navbarCollapse"
              >
                <div className="navbar-nav mr-auto py-0">
                  <Link to="/" className="nav-item nav-link active">
                    Home
                  </Link>
                  <Link to="/service" className="nav-item nav-link">
                    Services
                  </Link>
                  <Link to="/room" className="nav-item nav-link">
                    Rooms
                  </Link>

                  {token ? (
                    <>
                      <Link to="/dashboard" className="nav-item nav-link">
                        My Dashbaord
                      </Link>
                      <div className="nav-item dropdown">
                        <a
                          href="#"
                          className="nav-link dropdown-toggle"
                          data-bs-toggle="dropdown">
                          My Profile
                        </a>
                        <div className="dropdown-menu rounded-0 m-0">
                          <Link to="/user/profile" className="dropdown-item">
                            Profile
                          </Link>
                          <Link to="/user/change-password" className="dropdown-item">
                            Change Password
                          </Link>
                          <a href="#" onClick={logoutUser} className="dropdown-item">
                            Logout
                          </a>
                        </div>
                      </div>
                      <Link
                        to="#"
                        className="nav-item nav-link"
                        onClick={logoutUser}
                      >
                        Logout
                      </Link>
                    </>
                  ) : (
                    <>
                      <Link to="/login" className="nav-item nav-link">
                        Login
                      </Link>
                      <Link to="/register" className="nav-item nav-link">
                        Register
                      </Link>
                    </>
                  )}

                  <Link to="/contact" className="nav-item nav-link">
                    Contact
                  </Link>
                </div>
              </div>
            </nav>
          </div>
        </div>
      </div>

      {/* ------------- Header end ----------------  */}
    </>
  );
};

export default Navbar;
