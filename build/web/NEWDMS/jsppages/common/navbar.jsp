<%response.setHeader("Pragma", "no-cache");
            response.setHeader("Cache-Control", "no-store, no-cache");
            response.setDateHeader("Expires", 0);
%>

<script type="text/javascript">
    function rate()
    {
        xmlHttp=GetXmlHttpObject()
        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request")
            return;
        }


        var url= "<%=request.getContextPath()%>/rates" ;
        //xmlHttp.onreadystatechange=statechanged;
        xmlHttp.open("GET",url,true);

        xmlHttp.send(null);




    }
</script>
<%!     String userrole;
    int dashflag;
    int searchflag;
    int adminflag;
    int managerflag;
    int repoflag;
    int crflag;
    int auflag;
    int vuflag;
    int rcrdflag;
    int mstflag;
    int chlflag;
    int billflag;
    int billgen;
    int ledgen;
    int housebillgen;
    int defgen;
    int errgen;
    int dmssettingsflag;
    int setrates;
    int setinsertrate;
    int setcessrate;
    int setdiscountrate;

%>

<%
            searchflag = 0;
            adminflag = 0;
            repoflag = 0;
            auflag = 0;
            crflag = 0;
            vuflag = 0;
            rcrdflag = 0;
            mstflag = 0;
            chlflag = 0;
            billflag = 0;
            billgen = 0;
            ledgen = 0;
            defgen = 0;
            housebillgen=0;
            dmssettingsflag = 0;
            setrates = 0;
            setinsertrate = 0;
            setcessrate = 0;
            setdiscountrate = 0;
            managerflag = 0;

            userrole = (String) session.getAttribute("userrole");
            System.out.println("USERROLE------------" + userrole);
            String s = new String(request.getRequestURL());
            System.out.println("URL------------" + s);
            String s1 = s.substring(s.lastIndexOf("/") + 1);
            s = s.substring(0, s.lastIndexOf("/"));
            String searchstr = s.substring(s.lastIndexOf("/") + 1);
            System.out.println(searchstr);

            if (searchstr.equals("Search")) {
                searchflag = 1;
            } else if (searchstr.equals("manager")) {
                managerflag = 1;
                if (s1.equals("authorise.jsp")) {
                    auflag = 1;
                }

            } else if (searchstr.equals("admin")) {
                adminflag = 1;
                if (s1.equals("create_user.jsp")) {
                    crflag = 1;
                } else if (s1.equals("view_user.jsp")) {
                    vuflag = 1;
                }
            } /*else if(searchstr.equals("browserepository"))
            repoflag=1;*/ else if (searchstr.equals("chl_mst")) {
                rcrdflag = 1;
                if (s1.equals("new_chl.jsp")) {
                    chlflag = 1;
                } else if (s1.equals("new_mst.jsp")) {
                    mstflag = 1;
                }
            } else if (searchstr.equals("billing")) {
                billflag = 1;
                if (s1.equals("billgen.jsp")) {
                    billgen = 1;
                }else if (s1.equals("housing_billing.jsp")) {
                    housebillgen = 1;
                } else if (s1.equals("ledgergen.jsp")) {
                    ledgen = 1;
                } else if (s1.equals("default_err.jsp")) {
                    defgen = 1;
                }

            } else if (searchstr.equals("dmssettings")) {
                dmssettingsflag = 1;
                if (s1.equals("setRates.jsp")) {
                    setrates = 1;
                } else if (s1.equals("setInterestRate.jsp")) {
                    setinsertrate = 1;
                } else if (s1.equals("setCessRate.jsp")) {
                    setcessrate = 1;
                } else if (s1.equals("setDiscountRate.jsp")) {
                    setdiscountrate = 1;
                }
            }

%>


<ul id="nav" class="dropdown dropdown-horizontal">



    <li>
        <%
                    if (searchflag == 1) {
        %>
        <a href="<%= request.getContextPath()%>/SearchController" class=" current"> <!-- Add the class "current" to current menu item -->
					Search
        </a>

        <%
                            } else {
        %>


        <a href="<%= request.getContextPath()%>/SearchController"> <!-- Add the class "current" to current menu item -->
					Search
        </a>
        <%
                    }
        %>
    </li>


    <%System.out.println("user role " + userrole);%>

    <%    if (userrole.equals("admin") || userrole.equals("employee") || userrole.equals("general") || userrole.equals("manager")) {
    %>
    <li>
        <%
                if (rcrdflag == 1) {
        %>
        <div class="current "> <!-- Add the class "current" to current menu item -->
            <span class="dir">New Records</span>
        </div>
        <%                                   } else {
        %>
        <span class="dir">New Records</span>
        <%                                          }
        %>
        <ul><li>
                <%
                        if (mstflag == 1) {
                %>
                <a  class="current" href="<%= request.getContextPath()%>/NEWDMS/jsppages/chl_mst/new_mst.jsp">New Consumer</a>
                <%
                                                                          } else {
                %>
                <a   href="<%= request.getContextPath()%>/NEWDMS/jsppages/chl_mst/new_mst.jsp">New Consumer</a>
                <%
                        }
                %>
            </li>
        </ul>
    </li>
    <%
                }
                if (userrole.equals("admin") || userrole.equals("employee") || userrole.equals("general") || userrole.equals("manager")) {
    %>
    <li>
        <%
                            if (billflag == 1) {
        %>
        <div class="current "> <!-- Add the class "current" to current menu item -->
            <span class="dir">Billing</span>
        </div>
        <%                                   } else {
        %>

        <span class="dir">Billing</span>

        <%                                          }
        %>
        <ul><li>
                <%
                                    if (billgen == 1) {
                %>
                <a  class="current" href="<%= request.getContextPath()%>/BillingController">Bill Generation</a>
                <%
                                                                          } else {
                %>
                <a   href="<%= request.getContextPath()%>/BillingController">Bill Generation</a>

                <%
                                    }
                %>
            </li>
             <%    if (userrole.equals("admin") || userrole.equals("manager")) {
    %>
            <li>
                <%
                                    if (housebillgen == 1) {
                %>
                <a  class="current" href="<%= request.getContextPath()%>/GroupHousingBill">Group Housing Bill</a>
                <%
                                                                          } else {
                %>
                <a   href="<%= request.getContextPath()%>/GroupHousingBill">Group Housing Bill</a>

                <%
                                    }
                %>
            </li>

            <%
}
            %>

            <li>
                <%
                                    if (ledgen == 1) {
                %>
                <a class="current" href="<%= request.getContextPath()%>/LedgerController">Ledger Generation</a>
                <%
                                                                          } else {
                %>
                <a href="<%= request.getContextPath()%>/LedgerController">Ledger Generation</a>
                <%
                                    }
                %>
            </li>
            <li>
                <%
                                    if (defgen == 1) {
                %>
                <a class="current" href="<%= request.getContextPath()%>/DefaultPdf">Defaulter & Error</a>
                <%
                                                                          } else {
                %>
                <a href="<%= request.getContextPath()%>/DefaultPdf?id=1">Defaulter & Error</a>
                <%
                                    }
                %>
            </li>

        </ul>
    </li>



    <%
                }
    %>


    <%
                if (userrole.equals("admin")) {
    %>
    <li>
        <%
                            if (adminflag == 1) {
        %>
        <div class="current "> <!-- Add the class "current" to current menu item -->
            <span class="dir">User Settings</span>
        </div>
        <%                                   } else {
        %>

        <span class="dir">User Settings</span>

        <%                                          }
        %>
        <ul><li>
                <%
                                    if (crflag == 1) {
                %>
                <a  class="current" href="<%= request.getContextPath()%>/NEWDMS/jsppages/admin/create_user.jsp">Create User</a>
                <%
                                                                          } else {
                %>
                <a   href="<%= request.getContextPath()%>/NEWDMS/jsppages/admin/create_user.jsp">Create User</a>

                <%
                                    }
                %>
            </li>

            <li>
                <%
                                    if (vuflag == 1) {
                %>
                <a class="current" href="<%= request.getContextPath()%>/viewUser">View User</a>
                <%
                                                                          } else {
                %>
                <a href="<%= request.getContextPath()%>/viewUser">View User</a>
                <%
                                    }
                %>
            </li>
        </ul>
    </li>





    <%
                }
                if (userrole.equals("manager") || userrole.equals("admin")) {
    %>
    <li>
        <%
                            if (managerflag == 1) {
        %>
        <div class="current "> <!-- Add the class "current" to current menu item -->
            <span class="dir">Manager</span>
        </div>
        <%                                   } else {
        %>

        <span class="dir">Manager</span>

        <%                                          }
        %>
        <ul><li>
                <%
                                    if (auflag == 1) {
                %>
                <a  class="current" href="<%= request.getContextPath()%>/AuthoriseMasterChallan">Authorise</a>
                <%
                                                                          } else {
                %>
                <a   href="<%= request.getContextPath()%>/AuthoriseMasterChallan">Authorise</a>

                <%
                                    }
                %>
            </li>

        </ul>
    </li>

    <%
                }
                if (userrole.equals("admin")) {
    %>
    <li>
        <%
                            if (dmssettingsflag == 1) {
        %>
        <div class="current "> <!-- Add the class "current" to current menu item -->
            <span class="dir">Dms Settings</span>
        </div>
        <%                                      } else {
        %>
        <span class="dir"> Dms Settings</span>
        <%                                          }
        %>
        <ul><li>
                <%
                                    if (setrates == 1) {
                %>
                <a  class="current" href="<%= request.getContextPath()%>/NEWDMS/jsppages/dmssettings/setRates.jsp" onclick="rate()" >Rates</a>
                <%
                                                                          } else {
                %>

                <a  href="<%= request.getContextPath()%>/NEWDMS/jsppages/dmssettings/setRates.jsp" onclick="rate()" >Rates</a>
                <%
                                    }
                %>
            </li>
            <li>
                <%
                                    if (setinsertrate == 1) {
                %>
                <a  class="current" href="<%= request.getContextPath()%>/InterestRateController">Interest Rate</a>
                <%
                                                                          } else {
                %>
                <a  href="<%= request.getContextPath()%>/InterestRateController">Interest Rate</a>
                <%
                                    }
                %>
            </li>
            <li>
                <%
                                    if (setcessrate == 1) {
                %>
                <a  class="current" href="<%= request.getContextPath()%>/CessRateController">Cess Rate</a>
                <%
                                                                          } else {
                %>
                <a  href="<%= request.getContextPath()%>/CessRateController">Cess Rate</a>
                <%
                                    }
                %>
            </li>

            <li>
                <%
                                    if (setdiscountrate == 1) {
                %>
                <a class="current" href="<%= request.getContextPath()%>/discountRate">Discount Rate</a>
                <%
                                                                          } else {
                %>
                <a  href="<%= request.getContextPath()%>/discountRate">Discount Rate</a>
                <%
                                    }
                %>
            </li>
        </ul>
    </li>
    <%
                }
    %>



</ul> <!-- End #main-nav -->

