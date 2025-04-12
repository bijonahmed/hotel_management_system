import React, { useState, useEffect } from "react";
import { Helmet } from "react-helmet";
import GuestNavbar from "../../components/Navbar";
import { Link } from "react-router-dom";
import { useNavigate } from "react-router-dom";
import Footer from "../../components/Footer";
import LeftSideBarComponent from "../../components/LeftSideBarComponent";
import Pagination from "../../components/Pagination";
import axios from "/config/axiosConfig";

const RoomStatusList = () => {
  const [data, setData] = useState([]);
  const [searchQuery, setSearchQuery] = useState("");
  const [selectedFilter, setSelectedFilter] = useState(1);

  const [currentPage, setCurrentPage] = useState(1);
  const [bookingrooms, setBookingRooms] = useState([]);
  const [availableRooms, setAvailableRooms] = useState([]);
  const [totalPages, setTotalPages] = useState(0);
  const [loading, setLoading] = useState(false);
  const navigate = useNavigate();
  const [sortOrder, setSortOrder] = useState("asc");

  const apiUrl = "/booking/checkroomBookingStatus";
  const handleSort = () => {
    const sortedData = [...data].sort((a, b) => {
      if (a.name.toLowerCase() < b.name.toLowerCase()) {
        return sortOrder === "asc" ? -1 : 1;
      }
      if (a.name.toLowerCase() > b.name.toLowerCase()) {
        return sortOrder === "asc" ? 1 : -1;
      }
      return 0;
    });

    setData(sortedData);
    setSortOrder(sortOrder === "asc" ? "desc" : "asc");
  };

  const fetchData = async () => {
    setLoading(true);
    try {
      const rawToken = sessionStorage.getItem("token");
      const token = rawToken?.replace(/^"(.*)"$/, "$1");

      if (!token) {
        throw new Error("Token not found in sessionStorage");
      }
      const response = await axios.get(apiUrl, {
        headers: {
          Authorization: `Bearer ${token}`,
        },
      });

      setBookingRooms(response.data.booking_rooms);
      setAvailableRooms(response.data.available_rooms);
    } catch (error) {
      console.error("Error fetching data:", error);
    } finally {
      setLoading(false);
    }
  };

  const handlePageChange = (page) => {
    setCurrentPage(page);
  };

  const handleAddNewClick = () => {
    navigate("/roomsetting/add-room");
  };

  // Correctly closed useEffect hook
  useEffect(() => {
    fetchData();
  }, []);

  return (
    <>
      <Helmet>
        <title>Room Status List</title>
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
                <div className="breadcrumb-title pe-3">Room Status List</div>
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

                <div className="ms-auto d-none">
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
                    <div className="search-pagination-container">
                      {loading ? (
                        <div className="d-flex justify-content-center mt-3">
                          <div className="spinner-border" role="status">
                            <span className="visually-hidden">Loading...</span>
                          </div>
                        </div>
                      ) : (
                        <div className="table-responsive">
                          <div className="card mt-4">
                            <div className="card-header text-center">
                              <h4>Booking Rooms List</h4>
                            </div>
                            <div className="card-body p-0">
                              <table className="table table-striped table-bordered mb-0">
                                <thead className="thead-dark">
                                  <tr>
                                    <th className="text-center">ID</th>
                                    <th
                                      className="text-center"
                                      style={{ cursor: "pointer" }}
                                    >
                                      Room Name
                                    </th>
                                    <th className="text-center">
                                      Check IN/Out
                                    </th>
                                    <th className="text-center">Days</th>
                                    <th className="text-center">Status</th>
                                  </tr>
                                </thead>
                                <tbody>
                                  {bookingrooms.length > 0 ? (
                                    bookingrooms.map((item) => (
                                      <tr key={item.id}>
                                        <td className="text-center">
                                          {item.id}
                                        </td>
                                        <td className="text-center">
                                          {item.roomType}
                                        </td>
                                        <td className="text-center">
                                          {item.checkin} <br /> {item.checkout}
                                        </td>
                                        <td className="text-center">
                                          {item.total_booking_days}
                                        </td>
                                        <td className="text-center text-success font-weight-bold">
                                        <span style={{ color: 'red', fontWeight: 'bold' }}>Booking</span> 
                                        </td>
                                      </tr>
                                    ))
                                  ) : (
                                    <tr>
                                      <td
                                        colSpan="5"
                                        className="text-center text-muted"
                                      >
                                        No data found
                                      </td>
                                    </tr>
                                  )}
                                </tbody>
                              </table>
                            </div>
                          </div>
                        </div>


                        
                      )}

                      
                    </div>


                    <div className="search-pagination-container">
                      {loading ? (
                        <div className="d-flex justify-content-center mt-3">
                          <div className="spinner-border" role="status">
                            <span className="visually-hidden">Loading...</span>
                          </div>
                        </div>
                      ) : (
                        <div className="table-responsive">
                          <div className="card mt-4">
                            <div className="card-header text-center">
                              <h4>Available Rooms List</h4>
                            </div>
                            <div className="card-body p-0">
                              <table className="table table-striped table-bordered mb-0">
                                <thead className="thead-dark">
                                  <tr>
                                    <th className="text-center">ID</th>
                                    <th
                                      className="text-center"
                                      style={{ cursor: "pointer" }}
                                    >
                                      Room Name
                                    </th>
                                    <th className="text-center">
                                      Check IN/Out
                                    </th>
                                    <th className="text-center">Days</th>
                                    <th className="text-center">Status</th>
                                  </tr>
                                </thead>
                                <tbody>
                                  {availableRooms.length > 0 ? (
                                    availableRooms.map((item) => (
                                      <tr key={item.id}>
                                        <td className="text-center">
                                          {item.id}
                                        </td>
                                        <td className="text-center">
                                          {item.roomType}
                                        </td>
                                        <td className="text-center">
                                          {item.checkin} <br /> {item.checkout}
                                        </td>
                                        <td className="text-center">
                                          {item.total_booking_days}
                                        </td>
                                        <td className="text-center text-success font-weight-bold">
                                        <span style={{ color: 'green', fontWeight: 'bold' }}>Available</span>
                                        </td>
                                      </tr>
                                    ))
                                  ) : (
                                    <tr>
                                      <td
                                        colSpan="5"
                                        className="text-center text-muted"
                                      >
                                        No data found
                                      </td>
                                    </tr>
                                  )}
                                </tbody>
                              </table>
                            </div>
                          </div>
                        </div>
                        

                        
                      )}

                      
                    </div>
                  </div>
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

export default RoomStatusList;
