import React, { useState, useEffect } from "react";
import axios from "/config/axiosConfig";
import { useNavigate } from "react-router-dom";
import { Helmet } from "react-helmet";
import Footer from "../components/Footer";
import Header from "../components/GuestNavbar";
import { Link } from "react-router-dom";

const Register = () => {
  const navigate = useNavigate();
  const [name, setBrandName] = useState("");
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [errors, setErrors] = useState({}); // Define errors state

  const handleBrandNameChange = (e) => {
    setBrandName(e.target.value);
  };

  const handleEmailChange = (e) => {
    setEmail(e.target.value);
  };

  const handlePasswordChange = (e) => {
    setPassword(e.target.value);
  };

  const handleSubmit = async (e) => {
    e.preventDefault();

    try {
      const response = await axios.post("/auth/register", {
        name,
        email,
        password,
      });
      console.log(response.data.message);
      navigate("/login");
    } catch (error) {
      if (error.response && error.response.status === 422) {
        console.error("Validation errors:", error.response.data.errors);
        setErrors(error.response.data.errors);
      } else {
        console.error("Error adding brand:", error);
      }
    }
  };

  return (
    <div>
      <Helmet>
        <title>Register</title>
      </Helmet>
      <div className="bg-light p-0">
        <Header />
        <div
          className="d-flex align-items-center justify-content-center"
          style={{ minHeight: "100vh", backgroundColor: "#f8f9fa" }}
        >
        <div className="container col-md-6 col-lg-4">
          <div className="row mt-5">
            <div className="col-12 text-center">
              <h2 className="fw-bold mb-3">Create an Account</h2>
              <p className="text-muted">Sign up to access the customer portal</p>
            </div>
          </div>

          <form onSubmit={handleSubmit}>
            <div className="mb-3">
              <label htmlFor="name" className="form-label">Name:</label>
              <input
                className="form-control"
                type="text"
                id="name"
                value={name}
                onChange={handleBrandNameChange}
                placeholder="Enter your full name"
              />
              {errors.name && (
                <div className="error text-danger mt-2">
                  {errors.name[0]}
                </div>
              )}
            </div>

            <div className="mb-3">
              <label htmlFor="email" className="form-label">Email:</label>
              <input
                className="form-control"
                type="email"
                id="email"
                value={email}
                onChange={handleEmailChange}
                placeholder="Enter your email"
              />
              {errors.email && (
                <div className="error text-danger mt-2">
                  {errors.email[0]}
                </div>
              )}
            </div>

            <div className="mb-3">
              <label htmlFor="password" className="form-label">Password:</label>
              <input
                className="form-control"
                type="password"
                id="password"
                value={password}
                onChange={handlePasswordChange}
                placeholder="Create a password"
              />
              {errors.password && (
                <div className="error text-danger mt-2">
                  {errors.password[0]}
                </div>
              )}
            </div>

            <div className="mt-4">
              <button type="submit" className="btn btn-primary w-100">
                Register
              </button>
            </div>
          </form>

          <div className="text-center mt-3">
            <p>Already have an account? <Link to="/login" className="text-primary">Sign In</Link></p>
          </div>
        </div>
        </div>
      </div>
      <Footer />
    </div>
  );
};

export default Register;
