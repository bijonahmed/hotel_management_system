import React, { useState, useEffect, useContext } from "react";
import { Link } from "react-router-dom";
import { LanguageContext } from "../context/LanguageContext";
import axios from "/config/axiosConfig";
const Footer = () => {
  const { content } = useContext(LanguageContext);
  const [name, setName] = useState("");
  const [serviceData, setServiceData] = useState([]);
  const fetechGlobalData = async () => {
    try {
      const response = await axios.get(`/public/getGlobalData`);
      //console.log("Navbar API Response:", response.data); // Log the response
      setName(response.data);
    } catch (error) {
      console.error("Error fetching data", error);
    }
  };

  const fetechActiveService = async () => {
   
    try {
      const response = await axios.get(`/public/getServiceList`);
      //console.log("Service:", response.data); // Log the response
      setServiceData(response.data);
    } catch (error) {
      console.error("Error fetching data", error);
    }
  };

  useEffect(() => {
    fetechGlobalData();
    fetechActiveService();
  }, []);

  return (
    <>
      <div
        className="container-fluid bg-dark text-light footer wow fadeIn mt-1"
        data-wow-delay="0.1s"
      >
        <div className="container">
          <div className="row g-5">
            <div className="col-md-6 col-lg-4">
              <div className="bg-primary rounded p-4">
                <Link to="/">
                  <h1 className="text-white text-uppercase mb-3">
                    {name.name}
                  </h1>
                </Link>
                <p className="text-white mb-0">
                  Download{" "}
                  <a className="text-dark fw-medium" href="#">
                    🌙 {name.name} – Download our customer app for Android today
                    and enjoy seamless access to all our services on the go! 📱
                  </a>
                </p>
              </div>
            </div>
            <div className="col-md-6 col-lg-3">
              <h6 className="section-title text-start text-primary text-uppercase mb-4">
                Contact
              </h6>
              <p className="mb-2">
                <i className="fa fa-map-marker-alt me-3" />
                {name.address}
              </p>
              <p className="mb-2">
                <i className="fa fa-phone-alt me-3" />
                <a
                  href={`https://wa.me/${name.whatsApp}`}
                  target="_blank"
                  rel="noopener noreferrer"
                >
                  {name.whatsApp}
                </a>
              </p>
              <p className="mb-2">
                <i className="fa fa-envelope me-3" />
                {name.email}
              </p>
              <div className="d-flex pt-2">
                {/* <a className="btn btn-outline-light btn-social" href="#"><i className="fab fa-twitter" /></a> */}
                <a
                  className="btn btn-outline-light btn-social"
                  href={name.fblink}
                  target="_blank"
                >
                  <i className="fab fa-facebook-f" />
                </a>
                <a
                  className="btn btn-outline-light btn-social"
                  href={name.youtubelink}
                >
                  <i className="fab fa-youtube" />
                </a>
                {/* <a className="btn btn-outline-light btn-social" href="#"><i className="fab fa-linkedin-in" /></a> */}
              </div>
            </div>
            <div className="col-lg-5 col-md-12">
              <div className="row gy-5 g-4">
                <div className="col-md-6">
                  <h6 className="section-title text-start text-primary text-uppercase mb-4">
                    Company
                  </h6>
                  <Link className="btn btn-link" to="/">
                    Home
                  </Link>
                  <Link className="btn btn-link" to="/contact">
                    Contact Us
                  </Link>
                  <Link className="btn btn-link" to="/service">
                    Service
                  </Link>
                  <Link className="btn btn-link" to="/room">
                    Room
                  </Link>
                  <Link className="btn btn-link" to="/contact">
                    Support
                  </Link>
                </div>
                <div className="col-md-6">
                  <h6 className="section-title text-start text-primary text-uppercase mb-4">
                    Services
                  </h6>

                  {serviceData?.map((service, index) => (
                    <a className="btn btn-link" href="#"  key={service.id}>
                      {service.name}
                    </a>
                  ))}
                </div>
              </div>
            </div>
          </div>
        </div>
        <div className="container">
          <div className="copyright">
            <div className="row">
              <div className="col-md-6 text-center text-md-start mb-3 mb-md-0">
                © All Right Reserved.
                {/*/*** This template is free as long as you keep the footer author’s credit link/attribution link/backlink. If you'd like to use the template without the footer author’s credit link/attribution link/backlink, you can purchase the Credit Removal License from "https://htmlcodex.com/credit-removal". Thank you for your support. *** /*/}
                Designed By{" "}
                <a className="border-bottom" href="/">
                {name.name}
                </a>
              </div>
              <div className="col-md-6 text-center text-md-end">
                <div className="footer-menu">
                  <Link to="/">Home</Link>
                  <Link to="/contact">Help</Link>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </>
  );
};

export default Footer;
