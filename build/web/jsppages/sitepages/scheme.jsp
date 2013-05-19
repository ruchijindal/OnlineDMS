<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%
            response.setHeader("Pragma", "no-cache");
            response.setHeader("Cache-Control", "no-store, no-cache");

            response.setDateHeader("Expires", 0);

%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*,com.smp.jal.*,java.io.*;"%>
<%!    String sql;
    PreparedStatement pst, ps1;
    Connection con;
    ResultSet rs, rs1;
    int rownum;
    String con_id, a;
    String content;
    String content_type;
    String con_title;
    String con_date;
    int newsflag = 0;
    String flag;
    String news_heading;
    int x;
    String sql3;
    String sql1;
    int numRows;
    int startIndex = 1;
    int numRecordsPerPage = 8;
    int numPages;
    int remain;
    int i, j, k;
    String userrole;
    int t;

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head><title>Noida Jal Board :  Schemes</title>
    <jsp:include page="../common/header.jsp"/>
    <link rel="stylesheet" href="../../resources/css/jquery.css"/>
    </head>
    <body>
        <%
                    request.getSession(false);
                    request.setAttribute("t", t);

                    userrole = (String) session.getAttribute("userrole");
                    String ph1 = (String) pageContext.getServletContext().getAttribute("ph1");
                    String ph2 = (String) pageContext.getServletContext().getAttribute("ph2");


        %>
        <!-- Menu Starts -->
        <jsp:include page="../common/navigation.jsp"/>
        <!-- Menu Ends -->


        <div id="helper">
            <div class="inside">
                <div class="container">
                    <div class="bgr">
                    </div> <!-- #helper .leftcorners -->
                </div> <!-- #helper .container -->
            </div> <!-- #helper .inside -->
        </div> <!-- #helper -->



        <div id="breadcrumbs">
            <div class="inside">
                <div class="container">
                    <div id="breadcrumb">

                        <div class="youarehere">
                            <div class="leftcorners">
                                <div class="rightarrow">
                                    <div class="bg">
                                        You are here:
                                    </div> <!-- #breadcrums .bg -->
                                </div> <!-- #breadcrums .rightarrow -->
                            </div> <!-- #breadcrums .leftcorners -->
                        </div> <!-- #breadcrums .youarehere -->

                        <div class="inactive">
                            <a href="../../index.jsp" title="Home">
                                <span class="leftcorners">
                                    <span class="rightarrow">
                                        <span class="bg">
                                            Home
                                        </span>
                                    </span>
                                </span>
                            </a>
                        </div> <!-- #breadcrums .active -->
<div class="inactive">
                            <a href="#" title="Home">
                                <span class="leftcorners">
                                    <span class="rightarrow">
                                        <span class="bg">
                                            New & Events
                                        </span>
                                    </span>
                                </span>
                            </a>
                        </div> <!-- #breadcrums .active -->
                        <div class="active">
                            <a href="#" title="News">
                                <span class="leftcorners">
                                    <span class="rightarrow">
                                        <span class="bg">
                                            Schemes
                                        </span>
                                    </span>
                                </span>
                            </a>
                        </div> <!-- #breadcrums .active -->

                    </div> <!-- #breadcrums .breadcrumb -->
                </div> <!-- #breadcrums .container -->
            </div> <!-- #breadcrums .inside -->
        </div> <!-- #breadcrums -->


        <!-- Container Starts -->
        <div id="content">
            <div class="inside">
                <div class="container">
                    <div id="contentrail" class="full">

                        <div class="news">
                            <div class="heading heading35">
                                <div class="leftcorners">
                                    <div class="rightcorners">
                                        <div class="bg">
                                            <h2>Schemes</h2>
                                        </div> <!-- #news .bg -->
                                    </div> <!-- #news .rightcorners -->
                                </div> <!-- #news .leftcorners -->
                            </div> <!-- #news .heading -->
                            <div class="content">
                                <div class="insider">
                                    <div class="article">

                                        <%
                                                    int count = 0;
                                                    int increment = 1;
                                                    int numRows = 0;
                                                    sql = null;
                                                    sql1 = null;
                                                    int numPages = 0;



                                                    try {
                                                        String startIndexString = request.getParameter("startIndex");



                                                        if (request.getParameter("numRows") != null) {
                                                            numRows = Integer.parseInt(request.getParameter("numRows"));
                                                        } else {
                                                            numRows = 0;
                                                        }

                                                        if (startIndexString == null) {
                                                            startIndexString = "1";
                                                        }



                                                        startIndex = Integer.parseInt(startIndexString);


                                                        InitialContext initialContext = new InitialContext();
                                                        DataSource dataSource = (DataSource) initialContext.lookup("OnlineJal");
                                                        con = dataSource.getConnection();

                                                        sql = "select con_id,con_title,content_type,to_char(con_date,'dd Mon,yy'),display,rowid from jal_content where content_type='schemes' order by con_date desc";
                                                        sql1 = "select count(*) from jal_content where content_type='schemes'";
                                                        pst = con.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY, ResultSet.FETCH_UNKNOWN);
                                                        rs = pst.executeQuery();
                                                        ps1 = con.prepareStatement(sql1);
                                                        rs1 = ps1.executeQuery();
                                                        if (rs1.next()) {
                                                            numRows = rs1.getInt(1);
                                                        }





                                                        int numRecordsPerPage = 8;


                                                        numPages = numRows / numRecordsPerPage;

                                                        remain = numRows % numRecordsPerPage;

                                                        if (remain != 0) {

                                                            numPages = numPages + 1;

                                                        }



                                                        if ((startIndex + numRecordsPerPage) <= numRows) {

                                                            increment = startIndex + numRecordsPerPage;
                                                        } else {

                                                            if (remain == 0) {

                                                                increment = startIndex + numRecordsPerPage;

                                                            } else {

                                                                increment = startIndex + remain;
                                                            }
                                                        }

                                                        int l = 0;
                                                        char a[];



                                                        for (count = startIndex; count < increment; count++) {
                                                            if (rs.absolute(count)) {
                                                                con_id = rs.getString(1);
                                                                con_title = rs.getString(2);


                                                                content_type = rs.getString(3);
                                                                con_date = rs.getString(4);
                                                                sql3 = "select content from jal_content where con_id='" + con_id + "'";
                                                                ps1 = con.prepareStatement(sql3);
                                                                rs1 = ps1.executeQuery();
                                                                if (rs1.next()) {
                                                                    content = rs1.getString(1);
                                                                }


                                        %>
                                        <h4>  <%=con_title%></h4>
                                        <p>  <%=content%></p>

                                        <div class="infobar no">
                                            <div class="info">
                                                <%=con_date%>
                                            </div> <!-- #news .info -->

                                            <br class="clear" />
                                        </div> <!-- #news .infobar -->
                                        <br class="clear" />
                                        <%
                                                            }
                                                        }

                                                    } catch (Exception ex) {
                                                        System.out.println(ex);
                                                    } finally {
                                                        con.close();
                                                    }
                                        %>
                                    </div>  <!-- #news .insider -->

                                    <!-- Start Pagination-->
                                    <% if (numPages > 1) {%>
                                    <div class="paging p1">
                                        <ul>
                                            <%
                                                 if (startIndex != 1) {
                                            %>
                                            <li class="first">
                                                <a href="scheme.jsp?startIndex=1&amp;pflag=1&amp;numRows=<%=numRows%>" title="First Page">
                                                    <span class="leftcornerss">
                                                        <span class="rightcornerss">
                                                            <span class="bgs">
                                                                <img src="../../resources/images/icons/First3.png"  class="im" alt="first" title="First"></img>
                                                            </span> <!-- .paging .bg -->
                                                        </span> <!-- .paging .rightcorners -->
                                                    </span> </a>
                                            </li>
                                            <li class="previous">
                                                <a href="scheme.jsp?startIndex=<%=startIndex - numRecordsPerPage%>&amp;pflag=1&amp;numRows=<%=numRows%>" title="Previous Page">
                                                    <span class="leftcornerss">
                                                        <span class="rightcornerss">
                                                            <span class="bgs">
                                                                <img src="../../resources/images/icons/Prev3.png"  class="im" alt="first" title="Previous"></img>
                                                            </span> <!-- .paging .bg -->
                                                        </span> <!-- .paging .rightcorners -->
                                                    </span> </a>
                                            </li>
                                            <%
                                                 }
                                            %>


                                            <%
                                                 if (numPages <= 5) {
                                                     i = 1;
                                                     k = numPages;
                                                 } else {
                                                     i = (startIndex / numRecordsPerPage) + 1;
                                                     if (i + 4 <= numPages) {
                                                         k = i + 4;
                                                     } else {
                                                         i = numPages - 4;
                                                         k = numPages;
                                                     }
                                                 }
                                                 for (j = i; j <= k; j++) {
                                                     if (j == (startIndex / numRecordsPerPage) + 1) {
                                                         a = "active";
                                                     } else {
                                                         a = "";
                                                     }

                                            %>
                                            <li class="<%=a%>">
                                                <a href="scheme.jsp?startIndex=<%=(j - 1) * numRecordsPerPage + 1%>&amp;pflag=1&amp;numRows=<%=numRows%>" title="1">
                                                    <span class="leftcornerss">
                                                        <span class="rightcornerss">
                                                            <span class="bgs">
                                                                <%=j%>
                                                            </span> <!-- .paging .bg -->
                                                        </span> <!-- .paging .rightcorners -->
                                                    </span> <!-- .paging .leftcorners -->
                                                </a>
                                            </li>
                                            <%}

                                            %>

                                            <%if (startIndex + numRecordsPerPage <= numRows) {%>
                                            <li class="next">
                                                <a href="scheme.jsp?startIndex=<%=startIndex + numRecordsPerPage%>&amp;pflag=1&amp;numRows=<%=numRows%>" title="Next Page">
                                                    <span class="leftcornerss">
                                                        <span class="rightcornerss">
                                                            <span class="bgs">
                                                                <img src="../../resources/images/icons/Next3.png" class="im" alt="first" title="Next"></img>
                                                            </span> <!-- .paging .bg -->
                                                        </span> <!-- .paging .rightcorners -->
                                                    </span> </a>
                                            </li>
                                            <%}
                                            %>

                                            <%if (startIndex + numRecordsPerPage <= numRows) {
                                                     if (remain != 0) {%>

                                            <li class="last">
                                                <a href="scheme.jsp?startIndex=<%=numRows - remain + 1%>&amp;pflag=1&amp;numRows=<%=numRows%>" title="Last Page">
                                                    <span class="leftcornerss">
                                                        <span class="rightcornerss">
                                                            <span class="bgs">
                                                                <img src="../../resources/images/icons/Last3.png"   class="im" alt="first" title="Last"></img>
                                                            </span> <!-- .paging .bg -->
                                                        </span> <!-- .paging .rightcorners -->
                                                    </span>
                                                </a>
                                            </li>
                                            <%
                                                                                                        } else {
                                            %>
                                            <li class="last">
                                                <a href="scheme.jsp?startIndex=<%=numRows - numRecordsPerPage + 1%>&amp;pflag=1&amp;numRows=<%=numRows%>" title="Last Page">
                                                    <span class="leftcornerss">
                                                        <span class="rightcornerss">
                                                            <span class="bgs">
                                                                <img src="../../resources/images/icons/Last3.png"   class="im" alt="first" title="Last"></img>
                                                            </span> <!-- .paging .bg -->
                                                        </span> <!-- .paging .rightcorners -->
                                                    </span>
                                                </a>
                                            </li>
                                            <%
                                                     }
                                                 }
                                            %>
                                        </ul>
                                    </div> <!-- End .pagination -->

                                    <%}%>
                                </div> <!-- #news .content -->
                            </div> <!-- #news -->
                        </div>

                    </div> <!-- #centerrail -->

                </div>


            </div>
        </div>
        <!-- Container Ends -->
        <!-- Footer Starts -->
        <jsp:include page="../common/footer.jsp"/>
        <!-- Footer Ends -->

    </body>
</html>

