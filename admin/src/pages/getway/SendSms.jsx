import React, { useState, useEffect } from "react";
import { Helmet } from "react-helmet";
import GuestNavbar from "../../components/Navbar";
import Loader from "../../components/DarkNessLoader";
import { Link, useNavigate } from "react-router-dom";
import Footer from "../../components/Footer";
import LeftSideBarComponent from "../../components/LeftSideBarComponent";
import axios from "/config/axiosConfig";
import Swal from "sweetalert2";
import EditorComponent from "../../components/EditorComponent";

const SendSms = () => {
  const [errors, setErrors] = useState({});
  const navigate = useNavigate();
  const [loader, setLoader] = useState(false);
  const token = sessionStorage.getItem("token")?.replace(/^"(.*)"$/, "$1");

  const [formData, setFormData] = useState({
    phone_number: "",
    subject: "",
    message: "",
  });

  const handleChange = (e) => {
    if (!e || !e.target) return; // Optional: Prevent error
    setFormData({ ...formData, [e.target.name]: e.target.value });
  };
  const handleSubmit = async (e) => {
    e.preventDefault();
    setLoader(true); // ✅ Show loader

    try {
      const response = await axios.post("/getway/send-bulk-sms", formData, {
        headers: {
          Authorization: `Bearer ${token}`,
          "Content-Type": "application/json",
        },
      });

      // SweetAlert Toast Success Message
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
        title: response.data.message || "Emails sent successfully!",
      });

      // Reset form
      setFormData({
        phone_number: "",
        subject: "",
        message: "",
      });
    } catch (error) {
      if (error.response && error.response.status === 422) {
        Swal.fire({
          icon: "error",
          title: "Validation Errors",
          html: Object.values(error.response.data.errors)
            .map((err) => `<div>${err.join("<br>")}</div>`)
            .join(""),
        });
      } else {
        Swal.fire({
          icon: "error",
          title: "Error sending emails",
          text: error.message || "Something went wrong.",
        });
      }

      console.error("Error:", error);
    } finally {
      setLoader(false); // ✅ Hide loader no matter success or fail
    }
  };

  const handleMsgChange = (value, name = "message") => {
    setFormData((prev) => ({
      ...prev,
      [name]: value,
    }));
  };

  useEffect(() => {}, []);

  return (
    <>
      <Helmet>
        <title>Send SMS</title>
      </Helmet>
      <div className="wrapper">
        <LeftSideBarComponent />
        <header>
          <GuestNavbar />
        </header>

        <div className="page-wrapper">
          <div className="page-content">
            <div className="page-breadcrumb d-none d-sm-flex align-items-center mb-3">
              <div className="breadcrumb-title pe-3">Send SMS</div>
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
            </div>

            <center>{loader && <Loader />}</center>
            <div className="card radius-10">
              <div className="card-body p-4">
                <form onSubmit={handleSubmit}>
                  <div className="mb-3">
                    <label>Subject</label>
                    <input
                      type="text"
                      className="form-control"
                      name="subject"
                      value={formData.subject}
                      onChange={handleChange}
                    />
                  </div>

                  <div className="mb-3">
                    <label>Recipient Number (comma-separated)</label>
                    <textarea
                      className="form-control"
                      rows={1}
                      placeholder="+880191000000,+8801878788"
                      name="phone_number"
                      value={formData.phone_number}
                      onChange={handleChange}
                    />
                  </div>

                  <div className="mb-3">
                    <label>Message</label>

                    <textarea
                      className="form-control"
                      rows={10}
                      name="message"
                      value={formData.message}
                      onChange={handleChange}
                    ></textarea>
                  </div>

                  <button
                    type="submit"
                    className="btn btn-primary"
                    disabled={loader}
                  >
                    {loader ? "Sending..." : "Send Bulk Email"}
                  </button>
                </form>
              </div>
            </div>
          </div>

          <Footer />
        </div>
      </div>
    </>
  );
};

export default SendSms;
