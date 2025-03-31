import React, { useState, useEffect } from "react";
import { Helmet } from "react-helmet";
import GuestNavbar from "../../components/Navbar";
import { Link } from "react-router-dom";
import { useNavigate } from "react-router-dom";
import Footer from "../../components/Footer";
import LeftSideBarComponent from "../../components/LeftSideBarComponent";
import Pagination from "../../components/Pagination";
import axios from "/config/axiosConfig";
import "../../components/css/modal.css";
import Swal from "sweetalert2";

const RoomImagesList = () => {
  const [data, setData] = useState([]);
  const [searchQuery, setSearchQuery] = useState("");
  const [selectedFilter, setSelectedFilter] = useState(1);

  const [currentPage, setCurrentPage] = useState(1);
  const [pageSize, setPageSize] = useState(10);
  const [totalPages, setTotalPages] = useState(0);
  const [loading, setLoading] = useState(false);
  const navigate = useNavigate();
  const [sortOrder, setSortOrder] = useState("asc");
  const [showModal, setShowModal] = useState(false);
  const [roomsize, setRoomSize] = useState([]);
  const token = JSON.parse(sessionStorage.getItem("token"));

  const [formData, setFormData] = useState({
    room_size_id: "",
    roomImgDescription: "",
    status: 1,
    roomImage: null,
  });

  const getRoomSize = async () => {
    try {
      const response = await axios.get(`/roomsetting/getsRoomSize`, {
        headers: {
          Authorization: `Bearer ${token}`,
        },
      });
      const data = response.data;
      //console.log("API response data:", data); // Debugging: Check API response
      setRoomSize(data);
    } catch (error) {
      console.error("Error fetching user data:", error);
    }
  };

  const [errors, setErrors] = useState({});
  const [preview, setPreview] = useState(null);

  // Handle input change
  const handleChange = (e) => {
    setFormData({ ...formData, [e.target.name]: e.target.value });
  };

  // ✅ Handle Image Upload
  const handleImageChange = (e) => {
    const file = e.target.files[0];
    if (file) {
      if (!file.type.startsWith("image/")) {
        alert("Please upload a valid image file.");
        return;
      }
      if (file.size > 2 * 1024 * 1024) {
        alert("Image size must be less than 2MB.");
        return;
      }
      setFormData({ ...formData, roomImage: file });

      // Generate Image Preview
      const reader = new FileReader();
      reader.onloadend = () => {
        setPreview(reader.result);
      };
      reader.readAsDataURL(file);
    }
  };

  // ✅ Handle Form Submission
  const handleFormSubmit = (e) => {
    e.preventDefault();
    handleSubmit(formData);
  };

  const handleSubmit = async (formData) => {
    try {
      console.log("checking.....");
      const token = JSON.parse(sessionStorage.getItem("token"));
      const formPayload = new FormData();
      formPayload.append("id", "");
      formPayload.append("room_size_id", formData.room_size_id);
      formPayload.append("roomImgDescription", formData.roomImgDescription);
      formPayload.append("status", formData.status);

      // ✅ Append Image File
      if (formData.roomImage) {
        formPayload.append("roomImage", formData.roomImage);
      }

      const response = await axios.post(
        "/roomsetting/roomImagesSave",
        formPayload,
        {
          headers: {
            Authorization: `Bearer ${token}`,
            "Content-Type": "multipart/form-data",
          },
        }
      );

      Swal.fire({
        icon: "success",
        title: "Your data has been successful saved.",
      });

      setFormData({}); // Reset form data
      navigate("/roomsetting/room-images-list");
    } catch (error) {
      if (error.response && error.response.status === 422) {
        Swal.fire({
          icon: "error",
          title: "Validation Errors",
          html: Object.values(error.response.data.errors)
            .map((err) => `<div>${err.join("<br>")}</div>`)
            .join(""),
        });
        setErrors(error.response.data.errors);
      } else {
        console.error("Error updating user:", error);
      }
    }
  };

  const handleAddNewClick = () => {
    setShowModal(true); // Open modal on button click
  };

  // Correctly closed useEffect hook
  useEffect(() => {
    getRoomSize();
  }, []);

  return (
    <>
      <Helmet>
        <title>Room Images List</title>
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
                <div className="breadcrumb-title pe-3">Room Images List</div>
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
                        List
                      </li>
                    </ol>
                  </nav>
                </div>

                <div className="ms-auto">
                  <button
                    type="button"
                    className="btn btn-primary"
                    onClick={handleAddNewClick}
                  >
                    Add New
                  </button>
                </div>
              </div>

              <div className="card radius-10">
                <div className="card-body">
                  <div className="container-fluid">
                    ===================================
                  </div>
                </div>
              </div>
            </div>
          </div>

          {/* Bootstrap Modal */}
          {/* Right Sidebar Modal */}
          <div className={`custom-modal ${showModal ? "open" : ""}`}>
            <div className="modal-dialog modal-xl modal-dialog-end">
              <div className="modal-content">
                <div className="modal-header">
                  <h5 className="modal-title">Add New Room Images</h5>
                  <button
                    className="btn-close"
                    onClick={() => setShowModal(false)}
                  ></button>
                </div>
                <div className="modal-body">
                  <form onSubmit={handleFormSubmit}>
                    <div className="row mb-3 mt-3">
                      <label className="col-sm-3 col-form-label">
                        Room Size <span className="text-danger">*</span>
                      </label>
                      <div className="col-sm-9">
                        <select
                          className="form-control"
                          name="room_size_id"
                          value={formData.room_size_id}
                          onChange={handleChange}
                        >
                          <option value="">Select Room Size</option>
                          {roomsize.map((size, index) => (
                            <option key={index} value={size.id}>
                              {size.name}
                            </option>
                          ))}
                        </select>
                        {errors.room_size_id && (
                          <div style={{ color: "red" }}>
                            {errors.room_size_id}
                          </div>
                        )}
                      </div>
                    </div>

                    {/* Image Upload */}

                    <div className="row mb-3">
                      <label className="col-sm-3 col-form-label">
                        Room Image <span className="text-danger">*</span>
                      </label>
                      <div className="col-sm-9">
                        <input
                          type="file"
                          className="form-control"
                          onChange={handleImageChange}
                        />
                        {preview && (
                          <div className="mt-2">
                            <img
                              src={preview}
                              alt="Preview"
                              className="img-thumbnail"
                              width="150px"
                            />
                          </div>
                        )}
                        {errors.roomImage && (
                          <div style={{ color: "red" }}>{errors.roomImage}</div>
                        )}
                      </div>
                    </div>


                    <div className="row mb-3">
                      <label className="col-sm-3 col-form-label">
                        Room Description
                      </label>
                      <div className="col-sm-9">
                        <textarea
                          className="form-control"
                          name="roomDescription"
                          value={formData.roomImgDescription}
                          onChange={handleChange}
                          rows="2"
                        ></textarea>
                        {errors.roomImgDescription && (
                          <div style={{ color: "red" }}>
                            {errors.roomImgDescription}
                          </div>
                        )}
                      </div>
                    </div>


                    <div className="row mb-3">
                      <label className="col-sm-3 col-form-label">
                        Status <span className="text-danger">*</span>
                      </label>
                      <div className="col-sm-9">
                        <select
                          className="form-select"
                          name="status"
                          value={formData.status}
                          onChange={handleChange}
                        >
                          <option value="">Select Status</option>
                          <option value="1">Active</option>
                          <option value="0">Inactive</option>
                        </select>
                        {errors.status && (
                          <div style={{ color: "red" }}>{errors.status}</div>
                        )}
                      </div>
                    </div>

                    <div className="row">
                      <div className="col-sm-9 offset-sm-3">
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

          {/* Modal Backdrop (Needed for Bootstrap) */}
          {showModal && <div className="modal-backdrop fade show"></div>}

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

export default RoomImagesList;
