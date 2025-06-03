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

const Sendmail = () => {
  const [errors, setErrors] = useState({});
  const [customerEmail, setCustomerData] = useState([]);
  const navigate = useNavigate();
  const [loader, setLoader] = useState(false);
  const token = sessionStorage.getItem("token")?.replace(/^"(.*)"$/, "$1");

  const [formData, setFormData] = useState({
    emails: "",
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
      const response = await axios.post("/getway/send-bulk-email", formData, {
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
        title: response.data.message || "SMS sent successfully!",
      });

      // Reset form
      setFormData({
        emails: "",
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

  const fetchCustomerData = async () => {
    try {
      if (!token) {
        throw new Error("Token not found in sessionStorage");
      }
      const response = await axios.get(`/user/getOnlyMerchantList`, {
        headers: {
          Authorization: `Bearer ${token}`,
        },
      });
      if (response.data.data) {
        const customerList = response.data.data;

        // ✅ Extract unique emails
        const uniqueEmails = [
          ...new Set(
            customerList.map((customer) => customer.email).filter(Boolean)
          ),
        ];

        // ✅ Comma-separated string of emails
        const emailList = uniqueEmails.join(",");

        // ✅ Set emails into formData
        setFormData((prevFormData) => ({
          ...prevFormData,
          emails: emailList,
        }));

        // Optional: store emailList in state if needed
        setCustomerData(emailList); // only emails, not full objects
      }
    } catch (error) {
      console.error("Error fetching data:", error);
    }
  };

  useEffect(() => {
    fetchCustomerData();
  }, []);

  return (
    <>
      <Helmet>
        <title>Send Mail</title>
      </Helmet>
      <div className="wrapper">
        <LeftSideBarComponent />
        <header>
          <GuestNavbar />
        </header>

        <div className="page-wrapper">
          <div className="page-content">
            <div className="page-breadcrumb d-none d-sm-flex align-items-center mb-3">
              <div className="breadcrumb-title pe-3">Send Mail</div>
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
                    <label>Recipient Emails (comma-separated)</label>
                    <textarea
                      className="form-control"
                      rows={1}
                      name="emails"
                      value={formData.emails}
                      onChange={handleChange}
                      placeholder="e.g. abcd@gmail.com, xyz@gmail.com, hello@example.com"
                    />
                  </div>
                  <div className="mb-3">
                    <label>Message</label>
                    <EditorComponent
                      name="message"
                      className="form-control"
                      value={formData.message}
                      onChange={(value) => handleMsgChange(value, "message")} // Pass value and name
                    />
                    {/* <textarea
                      className="form-control"
                      rows={10}
                      name="message"
                      value={formData.message}
                      onChange={handleChange}
                    ></textarea> */}
                  </div>
                  <div className="row">
                    <div className="text-end">
                      <button
                        type="submit"
                        className="btn btn-primary text-end"
                        disabled={loader}
                      >
                        {loader ? (
                          <>
                            <i className="fas fa-spinner fa-spin me-2"></i>{" "}
                            Sending...
                          </>
                        ) : (
                          <>
                            <i className="fas fa-paper-plane me-2"></i> Send
                          </>
                        )}
                      </button>
                    </div>
                  </div>
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

export default Sendmail;
