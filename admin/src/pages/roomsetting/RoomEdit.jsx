import React, { useState, useEffect } from "react";
import { Helmet } from "react-helmet";
import GuestNavbar from "../../components/Navbar";
import EditorComponent from "../../components/EditorComponent";
import { Link, useParams, useNavigate } from "react-router-dom";
import Footer from "../../components/Footer";
import LeftSideBarComponent from "../../components/LeftSideBarComponent";
import axios from "/config/axiosConfig";
import Swal from "sweetalert2";

const RoomEdit = () => {
  const navigate = useNavigate();
  const [errors, setErrors] = useState({});
  const [name, setName] = useState("");
  const [status, setStatus] = useState(1);
  const { id } = useParams();
  const rawToken = sessionStorage.getItem("token");
  const token = rawToken?.replace(/^"(.*)"$/, "$1");
  const [roomsize, setRoomSize] = useState([]);
  const [bedtypes, setBedTypes] = useState([]);
  const [preview, setPreview] = useState(null);
  const [previewImages, setPreviewImages] = useState([]);
  const [uploadedImages, setUploadedImages] = useState([]); // for new uploads
  const [savedImages, setSavedImages] = useState([]); // from API/database
  const [formData, setFormData] = useState({
    roomType: "",
    capacity: "",
    extraCapacity: "",
    roomPrice: "",
    bedCharge: "",
    roomSize: "",
    bedNumber: "",
    bedType: "",
    roomImages: [],
    roomDescription: "",
    reserveCondition: "",
    status: "1", // Default value
  });

  // Handle input change
  const handleFormSubmitRoomImage = async (e) => {
      e.preventDefault();
    try {
      const token = JSON.parse(sessionStorage.getItem("token"));
      const formPayload = new FormData();

      formPayload.append("id", "");
      formPayload.append("room_id", id);
      formPayload.append("roomImgDescription", formData.roomImgDescription);
      formPayload.append("status", 1);

      // ✅ Append all images
      if (formData.roomImages && formData.roomImages.length > 0) {
        formData.roomImages.forEach((file) => {
          formPayload.append("roomImage[]", file);
        });
      } else {
        console.log("No images to upload");
      }

      const response = await axios.post(
        "/roomsetting/roomImagesSaveMultiple",
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
        title: "Your data has been successfully saved.",
      });

      getRoomImages();
      navigate("/roomsetting/room-list");
      // ✅ Reset form state
      setFormData({
        room_id: "",
        roomImgDescription: "",
        roomImages: [],
      });
      setPreviewImages([]);
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
        console.error("Error uploading images:", error);
      }
    }
  };

  const handleRemoveUploadedImage = (index) => {
    setUploadedImages((prev) => prev.filter((_, i) => i !== index));
    setFormData((prev) => ({
      ...prev,
      roomImages: prev.roomImages.filter((_, i) => i !== index),
    }));
  };

  const handleRemoveSavedImage = async (imageid) => {
    try {
      const response = await axios.get(`/roomsetting/delteRoomImages`, {
        headers: { Authorization: `Bearer ${token}` },
        params: { id: imageid },
      });
      getRoomImages();
    } catch (error) {
      console.error("Error fetching room images:", error);
    }
  };

  const getRoomImages = async () => {
    try {
      const response = await axios.get(`/roomsetting/getsRoomImagesrows`, {
        headers: { Authorization: `Bearer ${token}` },
        params: { id: id },
      });
      const imagesData = response.data.map((img) => ({
        id: img.id,
        roomImage: img.roomImage,
      }));
      // const imagesData = response.data.map((img) => img.roomImage); // Adjust if image URL is in another key
      setSavedImages(imagesData); // set saved images separately
    } catch (error) {
      console.error("Error fetching room images:", error);
    }
  };

  // ✅ Handle Image Upload
  const handleImageChange = (e) => {
    const files = Array.from(e.target.files);
    const validImages = [];

    files.forEach((file) => {
      if (!file.type.startsWith("image/")) {
        alert("Please upload valid image files.");
        return;
      }
      if (file.size > 2 * 1024 * 1024) {
        alert("Each image must be less than 2MB.");
        return;
      }
      validImages.push(file);
    });

    setFormData((prev) => ({
      ...prev,
      roomImages: validImages,
    }));

    // Generate preview for uploaded files
    validImages.forEach((file) => {
      const reader = new FileReader();
      reader.onloadend = () => {
        setUploadedImages((prev) => [...prev, reader.result]);
      };
      reader.readAsDataURL(file);
    });
  };

  const handleChange = (eOrValue, name) => {
    if (typeof eOrValue === "object" && eOrValue.target) {
      const { name, value } = eOrValue.target;
      setFormData((prev) => ({
        ...prev,
        [name]: value,
      }));
    } else {
      // For EditorComponent or other custom components
      setFormData((prev) => ({
        ...prev,
        [name]: eOrValue,
      }));
    }
  };

  const handleNumericChange = (e) => {
    const { name, value } = e.target;
    setFormData({ ...formData, [name]: value.replace(/\D/, "") });
  };

  const handleFormSubmit = (e) => {
    e.preventDefault();
    handleSubmit(formData);
  };

  const getRoomSize = async () => {
    try {
      const response = await axios.get(`/roomsetting/getsRoomSize`, {
        headers: {
          Authorization: `Bearer ${token}`,
        },
      });
      const data = response.data;
      setRoomSize(data);
    } catch (error) {
      console.error("Error fetching user data:", error);
    }
  };

  const getBedTypes = async () => {
    try {
      const response = await axios.get(`/roomsetting/getsBetType`, {
        headers: {
          Authorization: `Bearer ${token}`,
        },
      });
      const data = response.data;
      setBedTypes(data);
    } catch (error) {
      console.error("Error fetching user data:", error);
    }
  };

  const defaultFetch = async () => {
    try {
      const response = await axios.get(`/roomsetting/checkRoomRow`, {
        headers: {
          Authorization: `Bearer ${token}`,
        },
        params: { id: id }, // or simply { userId } using shorthand
      });
      const userData = response.data;
      setFormData((prev) => ({
        ...prev,
        ...userData, // Assuming userData has the same structure
      }));
    } catch (error) {
      console.error("Error fetching user data:", error);
    }
  };

  // From

  //END

  const handleSubmit = async (formData) => {
    try {
      const token = JSON.parse(sessionStorage.getItem("token"));
      const formPayload = new FormData();
      formPayload.append("id", formData.id);
      formPayload.append("roomType", formData.roomType);
      formPayload.append("capacity", formData.capacity);
      formPayload.append("extraCapacity", formData.extraCapacity);
      formPayload.append("roomPrice", formData.roomPrice);
      formPayload.append("bedCharge", formData.bedCharge);
      formPayload.append("roomSize", formData.roomSize);
      formPayload.append("bedNumber", formData.bedNumber);
      formPayload.append("bedType", formData.bedType);
      formPayload.append("roomDescription", formData.roomDescription);
      formPayload.append("reserveCondition", formData.reserveCondition);
      formPayload.append("status", formData.status);

      const response = await axios.post("/roomsetting/roomSave", formPayload, {
        headers: {
          Authorization: `Bearer ${token}`,
          "Content-Type": "multipart/form-data",
        },
      });

      Swal.fire({
        icon: "success",
        title: "Your data has been successful saved.",
      });

      setFormData({}); // Reset form data
      navigate("/roomsetting/room-list");
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
    navigate("/roomsetting/room-list");
  };

  useEffect(() => {
    defaultFetch();
    getRoomSize();
    getBedTypes();
    getRoomImages();
  }, []);

  return (
    <>
      <Helmet>
        <title>Edit Room</title>
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
                <div className="breadcrumb-title pe-3">Edit Room</div>
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
                        Edit Room
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
                  <div>
                    <ul className="nav nav-tabs" id="myTab" role="tablist">
                      <li className="nav-item" role="presentation">
                        <button
                          className="nav-link active"
                          id="home-tab"
                          data-bs-toggle="tab"
                          data-bs-target="#home"
                          type="button"
                          role="tab"
                          aria-controls="home"
                          aria-selected="true"
                        >
                          Room
                        </button>
                      </li>
                      <li className="nav-item" role="presentation">
                        <button
                          className="nav-link"
                          id="profile-tab"
                          data-bs-toggle="tab"
                          data-bs-target="#profile"
                          type="button"
                          role="tab"
                          aria-controls="profile"
                          aria-selected="false"
                        >
                          Images
                        </button>
                      </li>
                    </ul>
                    <div className="tab-content" id="myTabContent">
                      <div
                        className="tab-pane fade show active"
                        id="home"
                        role="tabpanel"
                        aria-labelledby="home-tab"
                      >
                        <br />
                        {/* Start */}
                        <form onSubmit={handleFormSubmit}>
                          <div className="row mb-3">
                            <label className="col-sm-3 col-form-label">
                              Room Type <span className="text-danger">*</span>
                            </label>
                            <div className="col-sm-9">
                              <input
                                type="text"
                                className="form-control"
                                name="roomType"
                                placeholder="Room Type"
                                value={formData.roomType}
                                onChange={handleChange}
                              />
                              {errors.roomType && (
                                <div style={{ color: "red" }}>
                                  {errors.roomType}
                                </div>
                              )}
                            </div>
                          </div>

                          <div className="row mb-3">
                            <label className="col-sm-3 col-form-label">
                              Capacity <span className="text-danger">*</span>
                            </label>
                            <div className="col-sm-9">
                              <input
                                type="text"
                                className="form-control"
                                name="capacity"
                                placeholder="5"
                                value={formData.capacity}
                                onChange={handleNumericChange}
                              />
                              {errors.capacity && (
                                <div style={{ color: "red" }}>
                                  {errors.capacity}
                                </div>
                              )}
                            </div>
                          </div>

                          <div className="row mb-3 d-none">
                            <label className="col-sm-3 col-form-label">
                              Extra Capability
                            </label>
                            <div className="col-sm-9">
                              <input
                                type="text"
                                className="form-control"
                                name="extraCapacity"
                                placeholder="5"
                                value={formData.extraCapacity}
                                onChange={handleChange}
                              />
                              {errors.extraCapacity && (
                                <div style={{ color: "red" }}>
                                  {errors.extraCapacity}
                                </div>
                              )}
                            </div>
                          </div>

                          <div className="row mb-3">
                            <label className="col-sm-3 col-form-label">
                              Room Price <span className="text-danger">*</span>
                            </label>
                            <div className="col-sm-9">
                              <input
                                type="text"
                                className="form-control"
                                name="roomPrice"
                                placeholder="0"
                                value={formData.roomPrice}
                                onChange={handleNumericChange}
                              />
                              {errors.roomPrice && (
                                <div style={{ color: "red" }}>
                                  {errors.roomPrice}
                                </div>
                              )}
                            </div>
                          </div>

                          <div className="row mb-3 d-none">
                            <label className="col-sm-3 col-form-label">
                              Bed Charge <span className="text-danger">*</span>
                            </label>
                            <div className="col-sm-9">
                              <input
                                type="text"
                                className="form-control"
                                name="bedCharge"
                                placeholder="0"
                                value={formData.bedCharge}
                                onChange={handleNumericChange}
                              />
                              {errors.bedCharge && (
                                <div style={{ color: "red" }}>
                                  {errors.bedCharge}
                                </div>
                              )}
                            </div>
                          </div>

                          <div className="row mb-3 d-none">
                            <label className="col-sm-3 col-form-label">
                              Room Size <span className="text-danger">*</span>
                            </label>
                            <div className="col-sm-9">
                              <select
                                className="form-control"
                                name="roomSize"
                                value={formData.roomSize}
                                onChange={handleChange}
                              >
                                <option value="">Select Room Size</option>
                                {roomsize.map((size, index) => (
                                  <option key={index} value={size.id}>
                                    {size.name}
                                  </option>
                                ))}
                              </select>
                              {errors.roomSize && (
                                <div style={{ color: "red" }}>
                                  {errors.roomSize}
                                </div>
                              )}
                            </div>
                          </div>

                          <div className="row mb-3 d-none">
                            <label className="col-sm-3 col-form-label">
                              Bed Number <span className="text-danger">*</span>
                            </label>
                            <div className="col-sm-9">
                              <input
                                type="text"
                                className="form-control"
                                name="bedNumber"
                                placeholder="5"
                                value={formData.bedNumber}
                                onChange={handleNumericChange}
                              />
                              {errors.capacity && (
                                <div style={{ color: "red" }}>
                                  {errors.bedNumber}
                                </div>
                              )}
                            </div>
                          </div>

                          <div className="row mb-3">
                            <label className="col-sm-3 col-form-label">
                              Bed Type <span className="text-danger">*</span>
                            </label>
                            <div className="col-sm-9">
                              <select
                                className="form-control"
                                name="bedType"
                                value={formData.bedType}
                                onChange={handleChange}
                              >
                                <option value="">Select Bed Type</option>
                                {bedtypes.map((bedtype, index) => (
                                  <option key={index} value={bedtype.id}>
                                    {bedtype.name}
                                  </option>
                                ))}
                              </select>
                              {errors.bedType && (
                                <div style={{ color: "red" }}>
                                  {errors.bedType}
                                </div>
                              )}
                            </div>
                          </div>

                          <div className="row mb-3">
                            <label className="col-sm-3 col-form-label">
                              Room Description{" "}
                              <span className="text-danger">*</span>
                            </label>
                            <div className="col-sm-9">
                              {/* <textarea
                          className="form-control"
                          name="roomDescription"
                          value={formData.roomDescription}
                          onChange={handleChange}
                          rows="2"
                        ></textarea> */}

                              <EditorComponent
                                className="form-control"
                                value={formData.roomDescription}
                                name="roomDescription"
                                onChange={(value) =>
                                  handleChange(value, "roomDescription")
                                }
                              />

                              {errors.roomDescription && (
                                <div style={{ color: "red" }}>
                                  {errors.roomDescription}
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
                                <div style={{ color: "red" }}>
                                  {errors.status}
                                </div>
                              )}
                            </div>
                          </div>

                          <div className="row">
                            <div className="col-sm-9 offset-sm-3">
                              <button
                                type="submit"
                                className="btn btn-primary px-4"
                              >
                                Submit
                              </button>
                            </div>
                          </div>
                        </form>
                        {/* END */}
                      </div>
                      <div
                        className="tab-pane fade"
                        id="profile"
                        role="tabpanel"
                        aria-labelledby="profile-tab"
                      >
                        <br />
                        {/* Start Room Image  */}
                        <form onSubmit={handleFormSubmitRoomImage}>
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
                                multiple
                              />
                              <div className="mt-3 d-flex flex-wrap">
                                {/* 🟢 Uploaded images preview (not saved yet) */}
                                {uploadedImages.map((img, index) => (
                                  <div
                                    key={`uploaded-${index}`}
                                    className="position-relative me-2 mb-2"
                                    style={{ width: "100px", height: "100px" }}
                                  >
                                    <img
                                      src={img}
                                      alt={`Uploaded Preview ${index}`}
                                      className="img-thumbnail"
                                      style={{
                                        width: "100%",
                                        height: "100%",
                                        objectFit: "cover",
                                      }}
                                    />
                                    <button
                                      type="button"
                                      className="btn-close position-absolute top-0 end-0"
                                      aria-label="Close"
                                      onClick={() =>
                                        handleRemoveUploadedImage(index)
                                      }
                                      style={{ backgroundColor: "white" }}
                                    ></button>
                                  </div>
                                ))}

                                {/* 🔵 Saved images preview (from DB) */}
                                {savedImages.map((img, index) => (
                                  <div
                                    key={`saved-${img.id}`}
                                    className="position-relative me-2 mb-2"
                                    style={{ width: "100px", height: "100px" }}
                                  >
                                    <img
                                      src={img.roomImage}
                                      alt={`Saved Preview ${index}`}
                                      className="img-thumbnail"
                                      style={{
                                        width: "100%",
                                        height: "100%",
                                        objectFit: "cover",
                                      }}
                                    />
                                    <button
                                      type="button"
                                      className="btn-close position-absolute top-0 end-0"
                                      aria-label="Close"
                                      onClick={() =>
                                        handleRemoveSavedImage(img.id)
                                      }
                                      style={{ backgroundColor: "white" }}
                                    ></button>
                                  </div>
                                ))}
                              </div>

                              {errors.roomImage && (
                                <div style={{ color: "red" }}>
                                  {errors.roomImage}
                                </div>
                              )}
                            </div>
                          </div>

                          <div className="row">
                            <div className="col-sm-9 offset-sm-3">
                              <button
                                type="submit"
                                className="btn btn-primary px-4"
                              >
                                Submit
                              </button>
                            </div>
                          </div>
                        </form>
                        {/* END Room Image submit */}
                      </div>
                    </div>
                  </div>
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

export default RoomEdit;
