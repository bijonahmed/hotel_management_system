import React, { useState, useEffect } from "react";
import { Link } from "react-router-dom";
import axios from "/config/axiosConfig";
import Footer from "../components/Footer";
import Header from "../components/GuestNavbar";
import BookingFilter from "../components/BookingFilter";
import { Helmet } from "react-helmet";

const Room = () => {
  const [name, setName] = useState({});
  const [roomData, setRoomData] = useState([]);
  const [loading, setLoading] = useState(false);

  const fetechActiveRooms = async () => {
    setLoading(true);
    try {
      const response = await axios.get(`/public/activeRooms`);
      console.log("API Response:", response.data); // Log the response
      setRoomData(response.data);
    } catch (error) {
      console.error("Error fetching data", error);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetechActiveRooms();
  }, []);

  return (
    <div>
      <Helmet>
        <title>Room</title>
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
                Room
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
                    Room
                  </li>
                </ol>
              </nav>
            </div>
          </div>
        </div>

        <BookingFilter />

        {/* start */}
        {/* Room Start */}
        <div className="container-xxl py-1">
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
                        className="img-responsive"
                        src={room.roomImage || "/img/room-3.jpg"}
                        alt="Room Image"
                        style={{
                          height: "250px",
                          width: "100%",
                          objectFit: "cover",
                        }}
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
                        {/* {room.roomDescription || ""} */}
                        <div dangerouslySetInnerHTML={{ __html: room.roomDescription }} />
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
        </div>
        <br />
        <br />
        {/* Room End */}

        {/* end */}
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

export default Room;
