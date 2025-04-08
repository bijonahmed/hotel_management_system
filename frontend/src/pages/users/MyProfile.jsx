// src/pages/Index.js
import React, { useState, useEffect, useContext } from "react";
import { Helmet } from "react-helmet";
import { Link } from "react-router-dom";
import axios from "/config/axiosConfig";
import { useNavigate } from "react-router-dom";
import Footer from "../../components/Footer";
import Header from "../../components/GuestNavbar";
import AuthUser from "../../components/AuthUser";
import BookingFilter from "../../components/BookingFilter";
import Swal from "sweetalert2";

const MyProfile = () => {
const navigate = useNavigate();
  const { getToken, token, logout } = AuthUser();
  const [errors, setErrors] = useState({});
  const [name, setName] = useState("");
  const [email, setEmail] = useState("");
  const [phone, setPhone] = useState("");
  const [company, setCompany] = useState("");
  const [username, setUsername] = useState("");
  const [rule_id, setRuleId] = useState("");
  const [password, setPassword] = useState("");
  const [confirmPass, setConfirmPassword] = useState("");
  const [roles, setRuleData] = useState([]);

  const fetchRuleData = async () => {
    try {
      if (!token) {
        throw new Error("Token not found in sessionStorage");
      }
      const response = await axios.get(`/user/getRoles`, {
        headers: {
          Authorization: `Bearer ${token}`,
        },
      });
      if (response.data.data) {
        setRuleData(response.data.data);
      }
    } catch (error) {
      console.error("Error fetching data:", error);
    }
  };
  // Fetch user data from the API and update state user/getUserRow
  const defaultFetch = async () => {
    try {
      const response = await axios.get(`booking/getUserRow`, {
        headers: {
          Authorization: `Bearer ${token}`,
        },
      });
      const userData = response.data.data;
      console.log("API response data:", userData.name); // Debugging: Check API response

      // Update state with fetched user data
      setName(userData.name || "");
      setEmail(userData.email || "");
      setPhone(userData.phone || "");
      setCompany(userData.company_name || "");
      setUsername(userData.username || "");
      setRuleId(userData.role_id || "");
      //setStatus(userData.status === 1 || userData.status === 0 ? userData.status : "");
    } catch (error) {
      console.error("Error fetching user data:", error);
    }
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      const formData = new FormData();
      //formData.append("id", user.id);
      formData.append("name", name);
      formData.append("email", email);
      formData.append("phone", phone);
      formData.append("company", company);
      formData.append("username", username);
      formData.append("rule_id", rule_id);
      formData.append("password", password);
      formData.append("status", 1);

      const response = await axios.post("/user/updateBookingUser", formData, {
        headers: {
          Authorization: `Bearer ${token}`,
          "Content-Type": "multipart/form-data",
        },
      });
      console.log(response.data);
      const Toast = Swal.mixin({
        toast: true,
        position: "top-end",
        showConfirmButton: false,
        timer: 3000,
        timerProgressBar: true,
        didOpen: (toast) => {
          toast.onmouseenter = Swal.stopTimer;
          toast.onmouseleave = Swal.resumeTimer;
        },
      });
      Toast.fire({
        icon: "success",
        title: "Your data has been successfully saved.",
      });

      //console.log(response.data.message);
      navigate("/dashboard");
    } catch (error) {
      if (error.response && error.response.status === 422) {
        Swal.fire({
          icon: "error",
          title: "Validation Errors",
          html: Object.values(error.response.data.errors)
            .map((err) => `<div>${err.join("<br>")}</div>`)
            .join(""),
        });
        console.error("Validation errors:", error.response.data.errors);
        setErrors(error.response.data.errors);
      } else {
        console.error("Error updating user:", error);
      }
    }
  };

  const handleConfigName = (e) => {
    setName(e.target.value);
  };
  const handleConfigEmail = (e) => {
    setEmail(e.target.value);
  };
  const handleConfigPhone = (e) => {
    setPhone(e.target.value);
  };
  const handleConfigCompany = (e) => {
    setCompany(e.target.value);
  };
  const handleConfigUsername = (e) => {
    setUsername(e.target.value);
  };
  const handleConfigRuleId = (e) => {
    setRuleId(e.target.value);
  };
  const handleConfigPassword = (e) => {
    setPassword(e.target.value);
  };
  const handleConfirmPassword = (e) => {
    setConfirmPassword(e.target.value);
  };

  useEffect(() => {
    defaultFetch();
    fetchRuleData();
    if (!token) {
      navigate("/login");
    }
  }, []);

  return (
    <div>
      <Helmet>
        <title>Change Password</title>
      </Helmet>
      {/* Start */}

      <div>
        <Helmet>
          <title>Change Password</title>
        </Helmet>
        <div className="bg-white p-0">
          <Header />
          {/* Page Header */}
          <div
            className="container-fluid page-header mb-5 p-0"
            style={{ backgroundImage: "url(/img/carousel-1.jpg)" }}
          >
            <div className="container-fluid page-header-inner py-5">
              <div className="container text-center pb-5">
                <h1 className="display-3 text-white mb-3 animated slideInDown">
                  Change Password
                </h1>
                <nav aria-label="breadcrumb">
                  <ol className="breadcrumb justify-content-center text-uppercase">
                    <li className="breadcrumb-item">
                      <Link to="/">Home</Link>
                    </li>

                    <li
                      className="breadcrumb-item text-white active"
                      aria-current="page"
                    >
                      Change Password
                    </li>
                  </ol>
                </nav>
              </div>
            </div>
          </div>

          <BookingFilter />

          {/* start */}
          {/* Room Start */}
          <div className="container-xxl py-1">
            <div className="container">
              <div className="card radius-10">
                {/* Start */}
                <div className="card-body p-4">
                  <form onSubmit={handleSubmit}>
                    <div className="row mb-3">
                      <label
                        htmlFor="input42"
                        className="col-sm-3 col-form-label"
                      >
                        Name
                      </label>
                      <div className="col-sm-9">
                        <div className="position-relative">
                          <input
                            type="text"
                            className="form-control"
                            id="input42"
                            placeholder="Enter Name"
                            value={name}
                            onChange={handleConfigName}
                          />
                          {errors.name && (
                            <div style={{ color: "red" }}>{errors.name[0]}</div>
                          )}
                        </div>
                      </div>
                    </div>

                    <div className="row mb-3">
                      <label
                        htmlFor="input42"
                        className="col-sm-3 col-form-label"
                      >
                        Email
                      </label>
                      <div className="col-sm-9">
                        <div className="position-relative">
                          <input
                            type="text"
                            className="form-control"
                            id="input42"
                            placeholder="Enter Email"
                            value={email}
                            onChange={handleConfigEmail}
                          />
                          {errors.email && (
                            <div style={{ color: "red" }}>
                              {errors.email[0]}
                            </div>
                          )}
                        </div>
                      </div>
                    </div>

                    <div className="row mb-3">
                      <label
                        htmlFor="input42"
                        className="col-sm-3 col-form-label"
                      >
                        Phone
                      </label>
                      <div className="col-sm-9">
                        <div className="position-relative">
                          <input
                            type="text"
                            className="form-control"
                            id="input42"
                            placeholder="Enter Phone"
                            value={phone}
                            onChange={handleConfigPhone}
                          />
                          {errors.phone && (
                            <div style={{ color: "red" }}>
                              {errors.phone[0]}
                            </div>
                          )}
                        </div>
                      </div>
                    </div>

                    <div className="row mb-3">
                      <label
                        htmlFor="input42"
                        className="col-sm-3 col-form-label"
                      >
                        Username
                      </label>
                      <div className="col-sm-9">
                        <div className="position-relative">
                          <input
                            type="text"
                            className="form-control"
                            id="input42"
                            placeholder="Username"
                            value={username}
                            onChange={handleConfigUsername}
                          />
                          {errors.username && (
                            <div style={{ color: "red" }}>
                              {errors.username[0]}
                            </div>
                          )}
                        </div>
                      </div>
                    </div>

                    <div className="row">
                      <label className="col-sm-3 col-form-label" />
                      <div className="col-sm-9">
                        <div className="d-md-flex d-grid align-items-center gap-3">
                          <button
                            type="submit"
                            className="btn btn-primary px-4"
                          >
                            Submit
                          </button>
                        </div>
                      </div>
                    </div>
                  </form>
                </div>

                {/* END */}
              </div>
            </div>
          </div>

          <br />
          <br />

          <Footer />

          <a
            href="#"
            className="btn btn-lg btn-primary btn-lg-square back-to-top"
          >
            <i className="bi bi-arrow-up" />
          </a>
        </div>
      </div>

      {/* END */}
    </div>
  );
};

export default MyProfile;