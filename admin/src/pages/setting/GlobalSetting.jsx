import React, { useState, useEffect } from "react";
import { Helmet } from "react-helmet";
import GuestNavbar from "../../components/Navbar";
import { Link } from "react-router-dom";
import Footer from "../../components/Footer";
import LeftSideBarComponent from "../../components/LeftSideBarComponent";
import axios from "/config/axiosConfig";
import { useNavigate } from "react-router-dom";
import Swal from "sweetalert2";

const GlobalSetting = () => {
  const [errors, setErrors] = useState({});
  const [name, setName] = useState("");
  const [status, setStatus] = useState("");
  const [whatsApp, setWhatsApp] = useState("");
  const [email, setEmail] = useState("");
  const [address, setAddress] = useState("");
  const [fblink, setFacebookPagesLink] = useState("");
  const [youtubelink, setYoutubeChaneelLink] = useState("");
  const [about_us, setAboutus] = useState("");
  const rawToken = sessionStorage.getItem("token");
  const token = rawToken?.replace(/^"(.*)"$/, "$1");

  const handleConfigCompanyName = (e) => {
    setName(e.target.value);
  };

  const handleConfigWhatsAppNum = (e) => {
    setWhatsApp(e.target.value);
  };

  const handleConfigEmail = (e) => {
    setEmail(e.target.value);
  };

  const handleConfigAddress = (e) => {
    setAddress(e.target.value);
  };

  const handleConfigFacebook = (e) => {
    setFacebookPagesLink(e.target.value);
  };

  const handleConfigYtChaneelName = (e) => {
    setYoutubeChaneelLink(e.target.value);
  };

  const handleConfigAboutUs = (e) => {
    setAboutus(e.target.value);
  };


 const defaultFetch = async () => {
    try {
      const response = await axios.get(`/setting/settingrowSystem`, {
        headers: {
          Authorization: `Bearer ${token}`,
        },
      });
      const userData = response.data.data;
      //console.log("API response data:", userData); // Debugging: Check API response
      setName(userData.name || "");
      setEmail(userData.email || "");
      setAddress(userData.address || "");
      setWhatsApp(userData.whatsApp || "");
      setFacebookPagesLink(userData.fblink || "");
      setYoutubeChaneelLink(userData.youtubelink || "");
      setAboutus(userData.about_us || "");
     
    } catch (error) {
      console.error("Error fetching user data:", error);
    }
  };

  
  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      const token = JSON.parse(sessionStorage.getItem("token"));
      const formData = new FormData();
      formData.append("name", name);
      formData.append("email", email);
      formData.append("address", address);
      formData.append("about_us", about_us);
      formData.append("whatsApp", whatsApp);
      formData.append("fblink", fblink);
      formData.append("youtubelink", youtubelink);

      const response = await axios.post("/setting/saveSetting", formData, {
        headers: {
          Authorization: `Bearer ${token}`,
          "Content-Type": "multipart/form-data",
        },
      });
      //console.log(response.data);
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

      // Reset form fields and errors
      
      //console.log(response.data.message);
      navigate("/setting/global-setting");
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

  const navigate = useNavigate();
  const handleAddNewClick = () => {
    navigate("/wallet/global-wallet-address-list");
  };

  useEffect(() => {
    defaultFetch();
  }, []);

  return (
    <>
      <Helmet>
        <title>Add Global Setting</title>
      </Helmet>
      <div>
        <div className="wrapper">
          <LeftSideBarComponent />
          <header>
            <GuestNavbar />
          </header>

          <div className="page-wrapper">
            <div className="page-content">
              <div className="page-breadcrumb d-none d-sm-flex align-items-center mb-3">
                <div className="breadcrumb-title pe-3">Global Setting</div>
                <div className="ps-3">
                  <nav aria-label="breadcrumb">
                    <ol className="breadcrumb mb-0 p-0">
                      <li className="breadcrumb-item">
                        <Link to="/dashboard">
                          <i className="bx bx-home-alt" />
                        </Link>
                      </li>
                    </ol>
                  </nav>
                </div>
                <div className="ms-auto">
                  <button
                    type="button"
                    className="btn btn-black"
                    onClick={handleAddNewClick}
                  >
                    Back
                  </button>
                </div>
              </div>

              <div className="card radius-10">
                {/* Start */}
                <div className="card-body p-4">
                  <form onSubmit={handleSubmit}>
                    <div className="row mb-3">
                      <label
                        htmlFor="input42"
                        className="col-sm-3 col-form-label">
                        Company Name
                      </label>
                      <div className="col-sm-9">
                        <div className="position-relative">
                          <input
                            type="text"
                            className="form-control"
                            placeholder="Company Name"
                            value={name}
                            onChange={handleConfigCompanyName}
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
                        className="col-sm-3 col-form-label">
                        WhatsApp Number
                      </label>
                      <div className="col-sm-9">
                        <div className="position-relative">
                          <input
                            type="text"
                            className="form-control"
                            placeholder="WhatsApp Number"
                            value={whatsApp}
                            onChange={handleConfigWhatsAppNum}
                          />
                          {errors.whatsApp && (
                            <div style={{ color: "red" }}>
                              {errors.whatsApp[0]}
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
                        Email
                      </label>
                      <div className="col-sm-9">
                        <div className="position-relative">
                          <input
                            type="text"
                            className="form-control"
                            placeholder="Email"
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
                        Address
                      </label>
                      <div className="col-sm-9">
                        <div className="position-relative">
                          <input
                            type="text"
                            className="form-control"
                            placeholder="Address"
                            value={address}
                            onChange={handleConfigAddress}
                          />
                          {errors.address && (
                            <div style={{ color: "red" }}>
                              {errors.address[0]}
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
                        Facebook Page Link
                      </label>
                      <div className="col-sm-9">
                        <div className="position-relative">
                          <input
                            type="text"
                            className="form-control"
                            placeholder="Facebook Page Link"
                            value={fblink}
                            onChange={handleConfigFacebook}
                          />
                          {errors.fblink && (
                            <div style={{ color: "red" }}>
                              {errors.fblink[0]}
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
                        Youtube Channel Link
                      </label>
                      <div className="col-sm-9">
                        <div className="position-relative">
                          <input
                            type="text"
                            className="form-control"
                            placeholder="Youtube Channel Link"
                            value={youtubelink}
                            onChange={handleConfigYtChaneelName}
                          />
                          {errors.youtubelink && (
                            <div style={{ color: "red" }}>
                              {errors.youtubelink[0]}
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
                        About us 
                      </label>
                      <div className="col-sm-9">
                        <div className="position-relative">
                        <textarea
                          className="form-control"
                          placeholder="Write your business about information...."
                          rows={6}
                          cols={50}
                          value={about_us}
                          onChange={handleConfigAboutUs}
                        />
                          {errors.about_us && (
                            <div style={{ color: "red" }}>
                              {errors.about_us[0]}
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
                            {" "}
                            Submit{" "}
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

          <div className="overlay toggle-icon" />
          <Link to="#" className="back-to-top">
            <i className="bx bxs-up-arrow-alt" />
          </Link>
          <Footer />
        </div>
      </div>
    </>
  );
};

export default GlobalSetting;
