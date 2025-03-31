import React, { useState, useEffect, useContext } from "react";
import axios from "/config/axiosConfig";
import { Link } from "react-router-dom";
import AuthUser from "../components/AuthUser";
import { useNavigate } from "react-router-dom";
import $ from "jquery"; // Import jQuery
import "./css/LeftSideBarComponent.css";


const LeftSideBarComponent = () => {

  const navigate = useNavigate();
  const [menuItems, setMenuItems] = useState([]);
  const [activeMenu, setActiveMenu] = useState(null);

  useEffect(() => {
    axios.get('/public/dynamicLeftSidebarmenu')
      .then((response) => {
        setMenuItems(response.data);
      })
      .catch((error) => {
        console.error('There was an error fetching the menu:', error);
      });
  }, []);

  const toggleSubmenu = (index) => {
    setActiveMenu(activeMenu === index ? null : index);
  };

  const { user } = AuthUser();
  useEffect(() => {
   
  }, []);

  return (
    <div className="sidebar-wrapper" data-simplebar="true">
      <div className="sidebar-header">
        <div>
          <img src="/assets/images/avatars/futuregenit-logo.png" className="logo-icon" />
        </div>
        <div>
          <h4 className="logo-text" style={{ fontSize: '17px' }}><b>FG Gateway</b></h4>
        </div>
        <div className="toggle-icon ms-auto"><i className="bx bx-arrow-back" />
        </div>
      </div>
      {/*navigation*/}
      <ul className="metismenu" id="menu">
        {menuItems.map((item, index) => (
          <li key={index}>
            <Link
              to={item.path}
              className={item.submenu.length > 0 ? "has-arrow" : ""}
              onClick={() => item.submenu.length > 0 && toggleSubmenu(index)}
            >
              <div className="parent-icon">
                <i className={item.icon} />
              </div>
              <div className="menu-title">{item.label}</div>
            </Link>
            {item.submenu.length > 0 && (
              <ul className={activeMenu === index ? "open" : ""}>
                {item.submenu.map((subitem, subindex) => (
                  <li key={subindex}>
                    <Link to={subitem.path}>
                      <i className={subitem.icon} />
                      {subitem.label}
                    </Link>
                  </li>
                ))}
              </ul>
            )}
          </li>
        ))}
      </ul>
      {/*end navigation*/}
    </div>
  );
};

export default LeftSideBarComponent;
