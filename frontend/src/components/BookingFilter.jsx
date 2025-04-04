// src/Navbar.js
import React, { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import { useNavigate } from "react-router-dom";
import AuthUser from "./AuthUser";

import axios from "/config/axiosConfig";
import $ from 'jquery';


const BookingFilter = () => {

  const navigate = useNavigate();
  const [adult, setAdult] = useState("");
  const [child, setChild] = useState("");

  return (
    <>
     <div className="container-fluid booking pb-5 wow fadeIn" data-wow-delay="0.1s" >
          <div className="container">
            <div className="bg-white shadow" style={{ padding: 35 }}>
              <div className="row g-2">
                <div className="col-md-10">
                  <div className="row g-2">
                    <div className="col-md-3">
                      <div
                        className="date"
                        id="date1"
                        data-target-input="nearest"
                      >
                        <input
                          type="text"
                          className="form-control datetimepicker-input"
                          placeholder="Check in"
                          data-target="#date1"
                          data-toggle="datetimepicker"
                        />
                      </div>
                    </div>
                    <div className="col-md-3">
                      <div
                        className="date"
                        id="date2"
                        data-target-input="nearest"
                      >
                        <input
                          type="text"
                          className="form-control datetimepicker-input"
                          placeholder="Check out"
                          data-target="#date2"
                          data-toggle="datetimepicker"
                        />
                      </div>
                    </div>
                    <div className="col-md-3">
                      <select
                        className="form-select"
                        value={adult}
                        onChange={(e) => setAdult(e.target.value)}
                      >
                        <option value="" disabled>
                          Adult
                        </option>
                        <option value={1}>Adult 1</option>
                        <option value={2}>Adult 2</option>
                        <option value={3}>Adult 3</option>
                      </select>
                    </div>
                    <div className="col-md-3">
                      <select
                        className="form-select"
                        value={child}
                        onChange={(e) => setChild(e.target.value)}
                      >
                        <option value="" disabled>
                          Child
                        </option>
                        <option value={1}>Child 1</option>
                        <option value={2}>Child 2</option>
                        <option value={3}>Child 3</option>
                      </select>
                    </div>
                  </div>
                </div>
                <div className="col-md-2">
                  <button className="btn btn-primary w-100">Submit</button>
                </div>
              </div>
            </div>
          </div>
        </div>
    </>
  );
};

export default BookingFilter;
