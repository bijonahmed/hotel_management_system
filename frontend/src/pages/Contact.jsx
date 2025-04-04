import React, { useState, useEffect } from "react";
import { Link } from "react-router-dom";
import axios from "/config/axiosConfig";
import Footer from "../components/Footer";
import Header from "../components/GuestNavbar";
import BookingFilter from "../components/BookingFilter";
import { Helmet } from "react-helmet";

const Contact = () => {
  const [name, setName] = useState({});
  const [formData, setFormData] = useState({
    name: "",
    email: "",
    subject: "",
    message: "",
  });
  const [showModal, setShowModal] = useState(false);

  const fetchGlobalData = async () => {
    try {
      const response = await axios.get(`/public/getGlobalData`);
      setName(response.data);
    } catch (error) {
      console.error("Error fetching data", error);
    }
  };

  useEffect(() => {
    fetchGlobalData();
  }, []);

  const handleChange = (e) => {
    setFormData({
      ...formData,
      [e.target.id]: e.target.value,
    });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      const response = await axios.post(`/public/sendContact`, formData); // Laravel endpoint
      if (response.status === 200) {
        setShowModal(true);
        setFormData({ name: "", email: "", subject: "", message: "" });
      } else {
        alert("Something went wrong!");
      }
    } catch (error) {
      console.error("Submission error:", error);
      alert("Submission failed. Try again.");
    }
  };

  const closeModal = () => setShowModal(false);

  return (
    <div>
      <Helmet>
              <title>Contact</title>
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
                Contact
              </h1>
              <nav aria-label="breadcrumb">
                <ol className="breadcrumb justify-content-center text-uppercase">
                  <li className="breadcrumb-item">
                    <Link to="/">Home</Link>
                  </li>
                  <li className="breadcrumb-item">
                    <a href="#">Pages</a>
                  </li>
                  <li
                    className="breadcrumb-item text-white active"
                    aria-current="page"
                  >
                    Contact
                  </li>
                </ol>
              </nav>
            </div>
          </div>
        </div>

        <BookingFilter />

        {/* Contact Section */}
        <div className="container-xxl py-5">
          <div className="container">
            <div className="text-center wow fadeInUp" data-wow-delay="0.1s">
              <h6 className="section-title text-center text-primary text-uppercase">
                Contact Us
              </h6>
              <h1 className="mb-5">
                <span className="text-primary text-uppercase">Contact</span> For
                Any Query
              </h1>
            </div>

            <div className="row g-4">
              <div className="col-12">
                <div className="row gy-4">
                  <div className="col-md-4">
                    <h6 className="section-title text-start text-primary text-uppercase">
                      Booking
                    </h6>
                    <p>
                      <i className="fa fa-envelope-open text-primary me-2" />
                      {name.email}
                    </p>
                  </div>
                  <div className="col-md-4">
                    <h6 className="section-title text-start text-primary text-uppercase">
                      Whatsapp
                    </h6>

                    <p>
                    <i className="fab fa-whatsapp" />
                      {name.whatsApp}
                    </p>
                     
                    
                  </div>
                  <div className="col-md-4">
                    <h6 className="section-title text-start text-primary text-uppercase">
                      Address
                    </h6>
                    <p>
                      <i className="fa fa-map-marker-alt text-primary me-2" />
                      {name.address}
                    </p>
                  </div>
                </div>
              </div>

              {/* Map */}
              <div className="col-md-6 wow fadeIn" data-wow-delay="0.1s">
                <iframe
                  className="w-100 rounded"
                  style={{ height: "350px", border: 0 }}
                  src="https://maps.google.com/maps?width=600&height=400&hl=en&q=Pechardwip%2C%20Cox%27s%20Bazar%2C%20Bangladesh%2C%204630&t=&z=14&ie=UTF8&iwloc=B&output=embed"
                  allowFullScreen
                />
              </div>

              {/* Contact Form */}
              <div className="col-md-6">
                <form onSubmit={handleSubmit}>
                  <div className="row g-3">
                    <div className="col-md-6">
                      <div className="form-floating">
                        <input
                          type="text"
                          className="form-control"
                          id="name"
                          placeholder="Your Name"
                          value={formData.name}
                          onChange={handleChange}
                          required
                        />
                        <label htmlFor="name">Your Name</label>
                      </div>
                    </div>
                    <div className="col-md-6">
                      <div className="form-floating">
                        <input
                          type="email"
                          className="form-control"
                          id="email"
                          placeholder="Your Email"
                          value={formData.email}
                          onChange={handleChange}
                          required
                        />
                        <label htmlFor="email">Your Email</label>
                      </div>
                    </div>
                    <div className="col-12">
                      <div className="form-floating">
                        <input
                          type="text"
                          className="form-control"
                          id="subject"
                          placeholder="Subject"
                          value={formData.subject}
                          onChange={handleChange}
                        />
                        <label htmlFor="subject">Subject</label>
                      </div>
                    </div>
                    <div className="col-12">
                      <div className="form-floating">
                        <textarea
                          className="form-control"
                          id="message"
                          placeholder="Leave a message here"
                          style={{ height: 150 }}
                          value={formData.message}
                          onChange={handleChange}
                        />
                        <label htmlFor="message">Message</label>
                      </div>
                    </div>
                    <div className="col-12">
                      <button className="btn btn-primary w-100 py-3" type="submit">
                        Send Message
                      </button>
                    </div>
                  </div>
                </form>
              </div>
            </div>

            {/* Modal */}
            {showModal && (
              <div
                className="modal fade show"
                tabIndex="-1"
                style={{ display: "block", background: "rgba(0,0,0,0.5)" }}
              >
                <div className="modal-dialog modal-dialog-centered">
                  <div className="modal-content">
                    <div className="modal-header">
                      <h5 className="modal-title">Thank You!</h5>
                      <button type="button" className="btn-close" onClick={closeModal}></button>
                    </div>
                    <div className="modal-body">
                      <p>Thanks for contacting us. We’ll get back to you soon.</p>
                    </div>
                    <div className="modal-footer">
                      <button className="btn btn-secondary" onClick={closeModal}>
                        Close
                      </button>
                    </div>
                  </div>
                </div>
              </div>
            )}
          </div>
        </div>

        {/* Footer */}
        <Footer />

        <a href="#" className="btn btn-lg btn-primary btn-lg-square back-to-top">
          <i className="bi bi-arrow-up" />
        </a>
      </div>
    </div>
  );
};

export default Contact;