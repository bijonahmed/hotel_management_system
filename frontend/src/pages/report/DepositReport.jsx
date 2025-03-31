import React, { useState, useEffect } from "react";
import { Helmet } from "react-helmet";
import GuestNavbar from "../../components/Navbar";
import { Link } from "react-router-dom";
import { useNavigate } from "react-router-dom";
import Footer from "../../components/Footer";
import LeftSideBarComponent from "../../components/LeftSideBarComponent";
import Pagination from "../../components/Pagination";
import axios from "/config/axiosConfig";
import "../../components/css/RoleList.css";

const DepositReport = () => {
  const [merchantdata, setMerchantData] = useState([]);
  const [data, setData] = useState([]);
  const [searchQuery, setSearchQuery] = useState("");
  const [searchQueryDepositid, setSearchDepositIdQuery] = useState("");
  const [datevalue, filterDate] = useState("");
  const [selectedFilter, setSelectedFilter] = useState("");

  const [currentPage, setCurrentPage] = useState(1);
  const [pageSize, setPageSize] = useState(100);
  const [searchMerchant, setMerchant] = useState("");
  const [merchantId, setMerchantId] = useState("");

  const [totalPages, setTotalPages] = useState(0);
  const [loading, setLoading] = useState(false);
  const navigate = useNavigate();
  const [sortOrder, setSortOrder] = useState("asc");

  const rawToken = sessionStorage.getItem("token");
  const token = rawToken?.replace(/^"(.*)"$/, "$1");
  const apiUrl = "/deposit/getDepositReport";

  const fetchMerchantData = async () => {
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
        setMerchantData(response.data.data);
      }
    } catch (error) {
      console.error("Error fetching data:", error);
    }
  };

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
      if (!token) {
        throw new Error("Token not found in sessionStorage");
      }
      const response = await axios.get(apiUrl, {
        headers: {
          Authorization: `Bearer ${token}`,
        },
        params: {
          searchQuery,
          selectedFilter,
          searchMerchant,
          searchQueryDepositid,
          datevalue,
          page: currentPage,
          pageSize,
        },
      });

      if (response.data.data) {
        setData(response.data.data);
        setTotalPages(response.data.total_pages);
      }
    } catch (error) {
      console.error("Error fetching data:", error);
    } finally {
      setLoading(false);
    }
  };

  const handlePageChange = (page) => {
    setCurrentPage(page);
  };

  const handlePageSizeChange = (e) => {
    setPageSize(Number(e.target.value));
  };

  const handleMerchant = (e) => {
    setMerchant(Number(e.target.value));
  };
  const [tooltipMessage, setTooltipMessage] = useState("Click to copy");
  const copyWalletAddress = (fulladd) => {
    setLoading(true);
    navigator.clipboard
      .writeText(fulladd)
      .then(() => {
        setTooltipMessage(fulladd);
        console.log("Address copied to clipboard!");
        // Optionally, show a success message (like updating a tooltip or state)
      })
      .catch((err) => {
        console.error("Failed to copy address: ", err);
      })
      .finally(() => {
        // Code to execute after the promise is settled (success or failure)
        setLoading(false); // Stop the loader
      });
  };

  const handleEdit = (id) => {
    navigate(`/report/status-edit/${id}`);
  };

  // Calculate the total deposit amount
  const totalDepositAmount = data.reduce(
    (sum, item) => sum + parseFloat(item.deposit_amount || 0),
    0
  );
  // Correctly closed useEffect hook
  useEffect(() => {
    fetchData();
    fetchMerchantData();
  }, [searchQuery, selectedFilter, searchMerchant, currentPage, pageSize]);

  return (
    <>
      <Helmet>
        <title>Deposit Report</title>
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
                <div className="breadcrumb-title pe-3">Deposit </div>
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
                        Report
                      </li>
                    </ol>
                  </nav>
                </div>
              </div>

              <div className="card radius-10">
                <div className="card-body">
                  <div className="container-fluid">
                    <div className="search-pagination-container">
                      <div className="row align-items-center mb-3">
                        <div className="col-12 col-md-4 mb-2 mb-md-0">
                          <div className="searchbar">
                            <input
                              type="text"
                              placeholder="Search wallet address..."
                              className="form-control"
                              value={searchQuery}
                              onChange={(e) => setSearchQuery(e.target.value)}
                            />
                          </div>
                        </div>

                        <div className="col-12 col-md-4 mb-2 mb-md-0">
                          <div className="searchbar">
                            <input
                              type="text"
                              placeholder="Search deposit ID..."
                              className="form-control"
                              value={searchQueryDepositid}
                              onChange={(e) =>
                                setSearchDepositIdQuery(e.target.value)
                              }
                            />
                          </div>
                        </div>

                        <div className="col-12 col-md-4 mb-2 mb-md-0">
                          <select
                            className="form-select"
                            value={searchMerchant}
                            onChange={handleMerchant}
                            id="input46"
                          >
                            <option value="">All Merchant</option>
                            {merchantdata.map((user) => (
                              <option key={user.id} value={user.id}>
                                {user.company_name} | {user.name} | {user.phone}
                              </option>
                            ))}
                          </select>
                        </div>

                        <div className="col-12 col-md-4 mb-2 mb-md-0 mt-3">
                          <div className="searchbar">
                            <select
                              className="form-select"
                              value={pageSize}
                              onChange={handlePageSizeChange}
                            >
                              <option value="100">Numer of rows 100</option>
                              <option value="200">Numer of rows 200</option>
                              <option value="300">Numer of rows 300</option>
                              <option value="400">Numer of rows 400</option>
                              <option value="500">Numer of rows 500</option>
                              <option value="600">Numer of rows 600</option>
                              <option value="700">Numer of rows 700</option>
                            </select>
                          </div>
                        </div>

                        <div className="col-12 col-md-4 mb-2 mb-md-0 mt-3">
                          <div className="searchbar">
                            <input
                              type="date"
                              placeholder="Search deposit ID..."
                              className="form-control"
                              value={datevalue}
                              onChange={(e) => filterDate(e.target.value)}
                            />
                          </div>
                        </div>

                        <div className="col-12 col-md-4  mt-3 d-flex justify-content-between align-items-center gap-1">
                          <select
                            className="form-select"
                            value={selectedFilter}
                            onChange={(e) => setSelectedFilter(e.target.value)}
                          >
                            <option value="">All Status</option>
                            <option value="1">Active</option>
                            <option value="0">Pending</option>
                          </select>
                          <button
                            type="button"
                            className="btn btn-primary"
                            onClick={fetchData}
                          >
                            Filter
                          </button>
                        </div>
                      </div>

                      {loading ? (
                        <div className="d-flex justify-content-center mt-3">
                          <div className="spinner-border" role="status">
                            <span className="visually-hidden">Loading...</span>
                          </div>
                        </div>
                      ) : (
                        <div className="table-responsive">
                          <table className="table align-middle mb-0 table-hover">
                            <thead className="table-light">
                              <tr>
                                <th
                                  className="text-left"
                                  onClick={handleSort}
                                  style={{ cursor: "pointer" }}
                                >
                                  Merchant Name
                                  {sortOrder === "asc" ? (
                                    <span
                                      style={{
                                        marginLeft: "5px",
                                        fontSize: "14px",
                                      }}
                                    >
                                      ↑
                                    </span>
                                  ) : (
                                    <span
                                      style={{
                                        marginLeft: "5px",
                                        fontSize: "14px",
                                      }}
                                    >
                                      ↓
                                    </span>
                                  )}
                                </th>
                                <th className="text-center">Deposit ID</th>
                                <th className="text-center">Username[ID]</th>
                                <th className="text-center">Amount</th>
                                <th className="text-center">Created At</th>
                                <th className="text-center">Status</th>
                                <th className="text-center">Wallet</th>
                                <th className="text-center">Action</th>
                              </tr>
                            </thead>
                            <tbody>
                              {data.length > 0 ? (
                                data.map((item) => (
                                  <tr key={item.id}>
                                    <td>
                                      <small>
                                        {item.company_name}({item.name})
                                      </small>
                                    </td>
                                    <td className="text-center">
                                      <small>
                                        {item.depositID}{" "}
                                        <a href="#">
                                          <i
                                            className="fadeIn animated bx bx-copy"
                                            onClick={() =>
                                              copyWalletAddress(
                                                item.fulldepositID
                                              )
                                            }
                                            data-bs-toggle="tooltip"
                                            title={tooltipMessage}
                                          ></i>
                                        </a>
                                      </small>
                                    </td>
                                    <td className="text-center">
                                      <small>
                                        {item.username}[{item.user_id}]
                                      </small>
                                    </td>
                                    <td className="text-center">
                                      <small>${item.deposit_amount}</small>
                                    </td>
                                    <td className="text-center">
                                      <small>{item.created_at}</small>
                                    </td>
                                    <td className="text-center">
                                      <small>
                                        <span
                                          className={`badge ${
                                            item.status == 0
                                              ? "bg-gradient-blooker"
                                              : item.status == 1
                                              ? "bg-gradient-quepal"
                                              : item.status == 2
                                              ? "bg-gradient-bloody"
                                              : ""
                                          } text-white shadow-sm w-100`}
                                        >
                                          {item.status == 0
                                            ? "Pending"
                                            : item.status == 1
                                            ? "Active"
                                            : item.status == 2
                                            ? "Rejected"
                                            : ""}
                                        </span>
                                      </small>
                                    </td>

                                    <td className="text-center">
                                      {item.towallet}{" "}
                                      <a href="#">
                                        <i
                                          className="fadeIn animated bx bx-copy"
                                          onClick={() =>
                                            copyWalletAddress(item.fulladd)
                                          }
                                          data-bs-toggle="tooltip"
                                          title={tooltipMessage}
                                        ></i>
                                      </a>
                                    </td>

                                    <td className="text-center">
                                      <a
                                        href="#"
                                        onClick={() => handleEdit(item.id)}
                                      >
                                        <small>
                                          <i className="lni lni-pencil-alt"></i>
                                          &nbsp;Edit
                                        </small>
                                      </a>
                                    </td>
                                  </tr>
                                ))
                              ) : (
                                <tr>
                                  <td colSpan="9" className="text-center">
                                    No data found
                                  </td>
                                </tr>
                              )}
                            </tbody>
                          </table>
                        </div>
                      )}

                      <div className="text-end mt-3">
                        <strong>Total Deposit Amount: </strong>$
                        {totalDepositAmount.toFixed(2)}
                      </div>

                      <div className="d-flex justify-content-center mt-3 gap-1">
                        <Pagination
                          totalPages={totalPages}
                          apiUrl={apiUrl}
                          onPageChange={handlePageChange}
                        />
                      </div>
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

export default DepositReport;
