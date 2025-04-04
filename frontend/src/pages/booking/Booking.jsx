import React, { useState, useEffect } from "react";
import { Link, useParams, useNavigate } from "react-router-dom";
import axios from "/config/axiosConfig";
import Footer from "../../components/Footer";
import Header from "../../components/GuestNavbar";
import BookingFilter from "../../components/BookingFilter";
import Swal from "sweetalert2";

const Booking = () => {
  const baseURL = axios.defaults.baseURL;
  const [errors, setErrors] = useState({});
  const [roomData, setRoomData] = useState([]);
  const [adult, setAdult] = useState("");
  const [child, setChild] = useState("");
  const [facilitiesData, setRoomParticular] = useState("");
  const [roomimages, setRoomImages] = useState([]);
  const [loading, setLoading] = useState(false);
  const [facilData, setSelectedFacilitiesData] = useState([]);
  const { slug } = useParams();

  const fetechActiveRooms = async () => {
    setLoading(true);
    try {
      const response = await axios.get(`/public/activeRooms`);
      //console.log("API Response:", response.data); // Log the response
      setRoomData(response.data);
    } catch (error) {
      console.error("Error fetching data", error);
    } finally {
      setLoading(false);
    }
  };

  const getRoomDetails = async () => {
    try {
      const response = await axios.get(`/public/getRoomDetails`, {
        params: { slug: slug }, // Send as query param
      });
      console.log("API Response:", response.data.roomParticular.id);
      setRoomImages(response.data.activeRoomImg);
      setRoomParticular(response.data.roomParticular);
      checkSelectedFacilities(response.data.roomParticular.id);
    } catch (error) {
      console.error("Error fetching data", error);
    }
  };

  const checkSelectedFacilities = async (id) => {
    try {
      const response = await axios.get(`/public/checkselectedfacilities`, {
        params: { id: id }, // or simply { userId } using shorthand
      });
      const userData = response.data;
      setSelectedFacilitiesData(userData);
    } catch (error) {
      console.error("Error fetching user data:", error);
    }
  };

  useEffect(() => {
    fetechActiveRooms();
    getRoomDetails();
  }, [slug]);

  return (
    <div>
      <div className="bg-white p-0">
        <Header />
        {/* Start */}
        {/* Page Header Start */}
        <div
          className="container-fluid page-header mb-5 p-0"
          style={{ backgroundImage: "url(/img/carousel-1.jpg)" }}
        >
          <div className="container-fluid page-header-inner py-5">
            <div className="container text-center pb-5">
              <h1 className="display-3 text-white mb-3 animated slideInDown">
                {facilitiesData.name}
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
                    Booking
                  </li>
                </ol>
              </nav>
            </div>
          </div>
        </div>
        {/* Page Header End */}
        {/* Booking Start */}
        <BookingFilter />
        {/* Booking End */}

        {/* Booking Start */}
        {loading ? (
                        <div className="d-flex justify-content-center mt-3">
                          <div className="spinner-border" role="status">
                            <span className="visually-hidden">Loading...</span>
                          </div>
                        </div>
                      ) : (
        <div className="container-xxl">
          <div className="container">
            {/* Section Heading */}
            <div className="text-center wow fadeInUp" data-wow-delay="0.1s">
              <h6 className="section-title text-uppercase text-primary fw-bold">
                Room Booking
              </h6>
              <h1 className="mb-5">
                Book A{" "}
                <span className="text-primary text-uppercase fw-bold">
                  {facilitiesData.name}
                </span>
              </h1>
            </div>

            {/* Room Image Carousel */}
            <div
              id="roomCarousel"
              className="carousel slide shadow-lg rounded"
              data-bs-ride="carousel"
            >
              <div className="carousel-inner">
                {roomimages.map((image, index) => (
                  <div
                    className={`carousel-item ${index === 0 ? "active" : ""}`}
                    key={index}
                  >
                    <img
                      src={image.roomImage}
                      className="d-block w-100 rounded-3"
                      alt="Room"
                      style={{
                        height: "500px",
                        objectFit: "cover",
                        filter: "brightness(90%)",
                      }}
                    />
                  </div>
                ))}
              </div>
              {/* Carousel Controls */}
              <button
                className="carousel-control-prev"
                type="button"
                data-bs-target="#roomCarousel"
                data-bs-slide="prev"
              >
                <span className="carousel-control-prev-icon"></span>
              </button>
              <button
                className="carousel-control-next"
                type="button"
                data-bs-target="#roomCarousel"
                data-bs-slide="next"
              >
                <span className="carousel-control-next-icon"></span>
              </button>
            </div>

            {/* Booking Information & Form */}
            <div className="row g-5 mt-1">
              {/* Booking Preview */}
              <div className="col-lg-6">
                <div className="p-4 rounded-3 shadow-sm">
                  <div className="booking-details">
                    {[
                      { label: "Room Type", value: facilitiesData.roomType },
                      { label: "Bed Type", value: facilitiesData.bed_name },
                      {
                        label: "Price",
                        value: `${facilitiesData.roomPrice} BDT / Night`,
                        isPrice: true,
                      },
                    ].map((item, index) => (
                      <div
                        key={index}
                        style={{
                          display: "flex",
                          justifyContent: "space-between",
                          alignItems: "center",
                          padding: "14px 0",
                          borderBottom: "1px solid #eee",
                          fontFamily: "Segoe UI, sans-serif",
                        }}
                      >
                        <span
                          style={{
                            fontSize: "15px",
                            color: "#555",
                            fontWeight: "500",
                          }}
                        >
                          {item.label}:
                        </span>
                        <span
                          style={{
                            fontSize: item.isPrice ? "20px" : "16px",
                            fontWeight: item.isPrice ? "700" : "600",
                            color: item.isPrice ? "#28a745" : "#333",
                          }}
                        >
                          {item.value}
                        </span>
                      </div>
                    ))}
                  </div>
                </div>

                <br />
                <div style={{ textAlign: "justify" }}>
                  <strong>Room Description :</strong>{" "}
                  {facilitiesData.roomDescription}
                </div>
                <br />
                <div className="table-responsive">
                  <table className="table table-sm">
                    <tbody>
                      {facilData.length > 0 ? (
                        <>
                          {/* Display a heading row for Facilities */}
                          <tr>
                            <td colSpan="3">
                              <strong>Facilities:</strong>
                            </td>
                          </tr>

                          {facilData.reduce((acc, data, index, array) => {
                            const isFirstOccurrence =
                              index === 0 ||
                              data.facility_group_name !==
                              array[index - 1].facility_group_name;

                            acc.push(
                              <tr key={data.id}>
                                <td></td>

                                {/* Show Group Name only for the first row of each group */}
                                {isFirstOccurrence ? (
                                  <td
                                    rowSpan={
                                      array.filter(
                                        (item) =>
                                          item.facility_group_name ===
                                          data.facility_group_name
                                      ).length
                                    }
                                  >
                                    <strong>{data.facility_group_name}</strong>
                                  </td>
                                ) : null}

                                <td>
                                  <span
                                    style={{
                                      display: "flex",
                                      alignItems: "center",
                                      gap: "8px",
                                    }}
                                  >
                                    <i className="fas fa-check-square text-primary"></i>
                                    {data.facilities_name}
                                  </span>
                                </td>
                              </tr>
                            );

                            return acc;
                          }, [])}
                        </>
                      ) : (
                        <tr>
                          <td colSpan="3" className="text-center">
                            No facilities found.
                          </td>
                        </tr>
                      )}
                    </tbody>
                  </table>
                </div>
              </div>


              {/* Add Loader */}

              {/* END Loader */}

              {/* Booking Form */}
              <div className="col-lg-6">
                <div className="p-4 bg-white rounded-3 shadow-lg">
                  <h5 className="mb-3 text-primary fw-bold">
                    Complete Your Booking
                  </h5>
                  <form>
                    <div className="row g-3">
                      <div className="col-md-6">
                        <div className="form-floating">
                          <input
                            type="text"
                            className="form-control"
                            id="name"
                            placeholder="Your Name"
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
                          />
                          <label htmlFor="email">Your Email</label>
                        </div>
                      </div>
                      <div className="col-md-6">
                        <div className="form-floating">
                          <input
                            type="date"
                            className="form-control"
                            id="checkin"
                          />
                          <label htmlFor="checkin">Check In</label>
                        </div>
                      </div>
                      <div className="col-md-6">
                        <div className="form-floating">
                          <input
                            type="date"
                            className="form-control"
                            id="checkout"
                          />
                          <label htmlFor="checkout">Check Out</label>
                        </div>
                      </div>
                      <div className="col-md-6">
                        <div className="form-floating">
                          <select className="form-select" id="selectAdult">
                            <option value={1}>1 Adult</option>
                            <option value={2}>2 Adults</option>
                            <option value={3}>3 Adults</option>
                          </select>
                          <label htmlFor="selectAdult">Adults</label>
                        </div>
                      </div>
                      <div className="col-md-6">
                        <div className="form-floating">
                          <select className="form-select" id="selectChild">
                            <option value={0}>No Child</option>
                            <option value={1}>1 Child</option>
                            <option value={2}>2 Children</option>
                          </select>
                          <label htmlFor="selectChild">Children</label>
                        </div>
                      </div>
                      <div className="col-12">
                        <div className="form-floating">
                          <select className="form-select" id="selectRoom">
                            <option value={1}>Standard Room</option>
                            <option value={2}>Deluxe Room</option>
                            <option value={3}>Suite</option>
                          </select>
                          <label htmlFor="selectRoom">Room Type</label>
                        </div>
                      </div>
                      <div className="col-12">
                        <div className="form-floating">
                          <textarea
                            className="form-control"
                            placeholder="Special Request"
                            id="message"
                            style={{ height: 100 }}
                          ></textarea>
                          <label htmlFor="message">Special Request</label>
                        </div>
                      </div>
                      <div className="col-12">
                        <button
                          className="btn btn-primary w-100 py-3 shadow"
                          type="submit"
                        >
                          Book Now
                        </button>
                      </div>
                    </div>
                  </form>
                </div>
              </div>
            </div>
          </div>

          <div className="container">
            <div className="text-center wow fadeInUp" data-wow-delay="0.1s">
              <h6 className="section-title text-center text-primary text-uppercase">
                Our Rooms
              </h6>
              <h1 className="mb-5">
                Explore Our{" "}
                <span className="text-primary text-uppercase">Rooms</span>
              </h1>
            </div>
            <div className="row g-4">
              {roomData.map((room, index) => (
                <div
                  key={index}
                  className="col-lg-4 col-md-6 wow fadeInUp"
                  data-wow-delay="0.6s"
                >
                  <div className="room-item shadow rounded overflow-hidden">
                    <div className="position-relative">
                      <img
                        className="img-fluid"
                        src={room.roomImage || "/img/room-3.jpg"}
                        alt="Room Image"
                      />
                      <small className="position-absolute start-0 top-100 translate-middle-y bg-primary text-white rounded py-1 px-3 ms-4">
                        BDT.&nbsp;{room.roomPrice}/Night
                      </small>
                    </div>
                    <div className="p-4 mt-2">
                      <div className="d-flex justify-content-between mb-3">
                        <h5 className="mb-0">{room.name || "Super Deluxe"}</h5>
                        <div className="ps-2">
                          <small className="fa fa-star text-primary" />
                          <small className="fa fa-star text-primary" />
                          <small className="fa fa-star text-primary" />
                          <small className="fa fa-star text-primary" />
                          <small className="fa fa-star text-primary" />
                        </div>
                      </div>
                      <div className="d-flex mb-3">
                        <small className="border-end me-3 pe-3">
                          <i className="fa fa-bed text-primary me-2" />{" "}
                          {room.bed_name}
                        </small>
                        {/* <small className="border-end me-3 pe-3">
                                   <i className="fa fa-bath text-primary me-2" /> 2 Bath
                                 </small>
                                 <small>
                                   <i className="fa fa-wifi text-primary me-2" /> Wifi
                                 </small> */}
                      </div>
                      <p className="text-body mb-3">
                        {room.roomDescription || ""}
                      </p>
                      <div className="d-flex justify-content-between">
                        <Link
                          to={`/booking-details/${room.slug}`}
                          className="btn btn-sm btn-primary rounded py-2 px-4"
                        >
                          View Detail
                        </Link>
                        <Link
                          to={`/booking-details/${room.slug}`}
                          className="btn btn-sm btn-dark rounded py-2 px-4"
                        >
                          Book Now
                        </Link>
                      </div>
                    </div>
                  </div>
                </div>
              ))}
            </div>
          </div>

          <br />
        </div>
      )}




        {/* Booking End */}

        {/* END */}
        <Footer />

        <a
          href="#"
          className="btn btn-lg btn-primary btn-lg-square back-to-top"
        >
          <i className="bi bi-arrow-up" />
        </a>
      </div>
    </div>
  );
};
export default Booking;
