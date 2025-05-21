import React, { useState } from "react";
import { Helmet } from "react-helmet";
import GuestNavbar from "../../components/Navbar";
import { Link, useNavigate } from "react-router-dom";
import Footer from "../../components/Footer";
import LeftSideBarComponent from "../../components/LeftSideBarComponent";
import axios from "/config/axiosConfig";
import Swal from "sweetalert2";

const ItemAdd = () => {
  const [errors, setErrors] = useState({});
  const [name, setName] = useState("");
  const [quantity, setQuantity] = useState("");
  const [unit_price, setUnitPrice] = useState("");
  const [notes, setNotes] = useState("");
  const [status, setStatus] = useState(1);

  const navigate = useNavigate();

  const handleNameChange = (e) => setName(e.target.value);
  const handleQuantityChange = (e) => setQuantity(e.target.value);
  const handleUnitPriceChange = (e) => setUnitPrice(e.target.value);
  const handleNotesChange = (e) => setNotes(e.target.value);
  const handleStatusChange = (e) => setStatus(e.target.value);

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      const token = JSON.parse(sessionStorage.getItem("token"));
      const formData = new FormData();
      formData.append("id", "");
      formData.append("name", name);
      formData.append("quantity", quantity);
      formData.append("unit_price", unit_price);
      formData.append("notes", notes);
      formData.append("status", status);

      const response = await axios.post(
        "/setting/itemSave",
        formData,
        {
          headers: {
            Authorization: `Bearer ${token}`,
            "Content-Type": "multipart/form-data",
          },
        }
      );

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
      setName("");
      setQuantity("");
      setUnitPrice("");
      setNotes("");
      setStatus(1);
      setErrors({});
      navigate("/setting/item-list");
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

  const handleAddNewClick = () => {
    navigate("/setting/item-list");
  };

  return (
    <>
      <Helmet>
        <title>Add Booking Type</title>
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
                <div className="breadcrumb-title pe-3">Add Booking Type</div>
                <div className="ps-3">
                  <nav aria-label="breadcrumb">
                    <ol className="breadcrumb mb-0 p-0">
                      <li className="breadcrumb-item">
                        <Link to="/dashboard">
                          <i className="bx bx-home-alt" />
                        </Link>
                      </li>
                      <li
                        className="breadcrumb-item active"
                        aria-current="page"
                      >
                        Add New
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
                <div className="card-body p-4">
                  <form onSubmit={handleSubmit}>
                    {/* Name */}
                    <div className="row mb-3">
                      <label
                        htmlFor="nameInput"
                        className="col-sm-3 col-form-label"
                      >
                        Name <span className="text-danger">*</span>
                      </label>
                      <div className="col-sm-9">
                        <input
                          type="text"
                          className="form-control"
                          id="nameInput"
                          placeholder="Enter Name"
                          value={name}
                          onChange={handleNameChange}
                        />
                        {errors.name && (
                          <div style={{ color: "red" }}>{errors.name[0]}</div>
                        )}
                      </div>
                    </div>

                    {/* Quantity */}
                    <div className="row mb-3">
                      <label
                        htmlFor="quantityInput"
                        className="col-sm-3 col-form-label"
                      >
                        Quantity <span className="text-danger">*</span>
                      </label>
                      <div className="col-sm-9">
                        <input
                          type="text"
                          className="form-control"
                          id="quantityInput"
                          placeholder="Enter Quantity"
                          value={quantity}
                          onChange={handleQuantityChange}
                        />
                        {errors.quantity && (
                          <div style={{ color: "red" }}>
                            {errors.quantity[0]}
                          </div>
                        )}
                      </div>
                    </div>

                    {/* Unit Price */}
                    <div className="row mb-3">
                      <label
                        htmlFor="unitPriceInput"
                        className="col-sm-3 col-form-label"
                      >
                        Unit Price <span className="text-danger">*</span>
                      </label>
                      <div className="col-sm-9">
                        <input
                          type="text"
                          className="form-control"
                          id="unitPriceInput"
                          placeholder="Enter Unit Price"
                          value={unit_price}
                          onChange={handleUnitPriceChange}
                        />
                        {errors.unit_price && (
                          <div style={{ color: "red" }}>
                            {errors.unit_price[0]}
                          </div>
                        )}
                      </div>
                    </div>

                    {/* Notes */}
                    <div className="row mb-3">
                      <label
                        htmlFor="notesInput"
                        className="col-sm-3 col-form-label"
                      >
                        Notes
                      </label>
                      <div className="col-sm-9">
                        <input
                          type="text"
                          className="form-control"
                          id="notesInput"
                          placeholder="Enter Notes"
                          value={notes}
                          onChange={handleNotesChange}
                        />
                        {errors.notes && (
                          <div style={{ color: "red" }}>{errors.notes[0]}</div>
                        )}
                      </div>
                    </div>

                    {/* Status */}
                    <div className="row mb-3">
                      <label
                        htmlFor="statusInput"
                        className="col-sm-3 col-form-label"
                      >
                        Status <span className="text-danger">*</span>
                      </label>
                      <div className="col-sm-9">
                        <select
                          className="form-select"
                          id="statusInput"
                          value={status}
                          onChange={handleStatusChange}
                        >
                          <option value="">Select Status</option>
                          <option value={1}>Active</option>
                          <option value={0}>Inactive</option>
                        </select>
                        {errors.status && (
                          <div style={{ color: "red" }}>{errors.status[0]}</div>
                        )}
                      </div>
                    </div>

                    {/* Submit Button */}
                    <div className="row">
                      <div className="col-sm-3" />
                      <div className="col-sm-9">
                        <button type="submit" className="btn btn-primary px-4">
                          Submit
                        </button>
                      </div>
                    </div>
                  </form>
                </div>
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

export default ItemAdd;
