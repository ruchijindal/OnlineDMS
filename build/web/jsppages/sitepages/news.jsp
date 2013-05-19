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
    PreparedStatement pst;
    Connection con;
    ResultSet rs;
    int rownum;
    String con_id;
    String content;
    String content_type;
    String con_title;
    String con_date;
    String content_heading;
    String content_date;
    String userrole;
    int t;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

    <head><title>Noida Jal Board : News  </title>
        <jsp:include page="../common/header.jsp"/></head>
    <body>
        <%
                    request.getSession(false);
                    request.setAttribute("t", t);

                    userrole = (String) session.getAttribute("userrole");
                    String ph1 = (String) pageContext.getServletContext().getAttribute("ph1");
                    String ph2 = (String) pageContext.getServletContext().getAttribute("ph2");


        %>

        <%
                    try {
                        con_id = request.getParameter("con_id");
                        InitialContext initialContext = new InitialContext();
                        DataSource dataSource = (DataSource) initialContext.lookup("OnlineJal");
                        con = dataSource.getConnection();
                        //con = (Connection) pageContext.getServletContext().getAttribute("con");
                        sql = "select con_id,con_title,content,content_type,to_char(con_date,'dd Mon,yyyy') from jal_content where con_id=" + con_id;
                        pst = con.prepareStatement(sql);
                        rs = pst.executeQuery();

                        while (rs.next()) {
                            con_id = rs.getString(1);
                            con_title = rs.getString(2);
                            content = rs.getString(3);
                            content_type = rs.getString(4);
                            con_date = rs.getString(5);

                        }
                    } catch (Exception ex) {
                        System.out.println(ex);
                    } finally {
                        con.close();
                    }
        %>

        <!-- Menu Starts -->
        <jsp:include page="../common/navigation.jsp"/>
        <!-- Menu Ends -->
        <div id="breadcrumbs">
                <div class="inside">
                    <div class="container">
                        <div id="breadcrumb">

                            <div class="youarehere">
                                <div class="leftcorners">
                                    <div class="rightarrow">
                                        <div class="bg">
                                            You are here :
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
<div class="active">
                            <a href="#" title="Events">
                                <span class="leftcorners">
                                    <span class="rightarrow">
                                        <span class="bg">
                                            News & Events

                                        </span>
                                    </span>
                                </span>
                            </a>
                        </div> <!-- #breadcrums .active -->
                        <div class="inactive">
                            <a href="news_list.jsp" title="Home">
                                <span class="leftcorners">
                                    <span class="rightarrow">
                                        <span class="bg">
                                            News
                                        </span>
                                    </span>
                                </span>
                            </a>
                        </div> <!-- #breadcrums .active -->

                        <div class="active">
                            <a href="#" title="Home">
                                <span class="leftcorners">
                                    <span class="rightarrow">
                                        <span class="bg">
                                            <%=con_title%>
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
                    <div id="centerrail">

                        <div class="news">
                            <div class="heading heading35">
                                <div class="leftcorners">
                                    <div class="rightcorners">
                                        <div class="bg">

                                        </div> <!-- #news .bg -->
                                    </div> <!-- #news .rightcorners -->
                                </div> <!-- #news .leftcorners -->
                            </div> <!-- #news .heading -->
                            <div class="content">
                                <div class="leftcorners">
                                    <div class="rightcorners">
                                        <div class="bg">
                                            <div class="insider">
                                                <div class="article">
                                                    <br class="clear" />




                                                        <div class="inside">
                                                            <div class="container">
                                                                <div id="contentrail" class="full">

                                                                    <h2><%=con_title%>  </h2>
                                                                    <%=con_date%>

                                                                    <%=content%>

                                                                    <br class="clear" />
                                                                </div>
                                                            </div>

                                                    </div>

                                                </div>  <!-- #news .insider -->
                                            </div> <!-- #news .bg -->
                                        </div> <!-- #news .rightcorners -->
                                    </div> <!-- #news .leftcorners -->
                                </div> <!-- #news .content -->
                            </div> <!-- #news -->

                        </div> <!-- #centerrail -->

                    </div>
                </div>
            </div>
        </div>
        <!-- Container Ends -->
        <!-- Footer Starts -->
        <jsp:include page="../common/footer.jsp"/>
        <!-- Footer Ends -->

    </body>
</html>
