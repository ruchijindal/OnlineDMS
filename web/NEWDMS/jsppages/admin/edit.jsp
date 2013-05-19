<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%response.setHeader("Pragma", "no-cache");
            response.setHeader("Cache-Control", "no-store, no-cache");
            response.setDateHeader("Expires", 0);
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">


<html>
    <head>
        <title>View User</title>
        <link rel="stylesheet" href="resources/css/reset.css" type="text/css" media="screen" />

        <!-- Main Stylesheet -->
        <link rel="stylesheet" href="resources/css/style.css" type="text/css" media="screen" />

        <!-- Invalid Stylesheet. This makes stuff look pretty. Remove it if you want the CSS completely valid -->
        <link rel="stylesheet" href="resources/css/invalid.css" type="text/css" media="screen" />
        <link rel="stylesheet" href="resources/css/simpletree.css" type="text/css" media="screen" />

        <jsp:include page="../common/header.jsp"/>
        <script  type="text/javascript" src="<%=request.getContextPath()%>/NEWDMS/resources/jquery/jquery-1.3.2.js"></script>
        <script type="text/javascript" src="<%=request.getContextPath()%>/NEWDMS/resources/jquery/jquery.validate_1.js"></script>
    </head>
    <script type="text/javascript">
        $(document).ready(function(){
            $("#form").validate();
        });
        window.onload = function()
        {
            document.getElementById("password").focus();
        }
    </script>

    <body>
        <div id="body-wrapper"> <!-- Wrapper for the radial gradient background -->


            <jsp:include page="../common/navbar.jsp"/>

            <div id="main-content"> <!-- Main Content Section with everything -->



                <div class="content-box"><!-- Start Content Box -->

                    <div class="content-box-header">

                        <h3>Users Details</h3>

                        <div class="clear"></div>

                    </div> <!-- End .content-box-header -->

                    <div class="content-box-content">

                        <c:set var="userList" value="${userList}"/>

                        <form  id="form" method="post" action="<%= request.getContextPath()%>/editUser">

                            <p>   <label class="form-label">Username</label>

                                <input type="text" value="${userList.userid}" name="userId" readonly="true">
                            </p>
                            <p>
                                <label class="form-label">Password</label>
                                <input type="password"  name="editPassword" id="password"  minlength="6"  maxlength="15" class="required">
                            </p>

                            <p><label class="form-label">Re Enter Password</label>

                                <input type="password"  name="conPassword"  id="conpassword" equalTo="#password"  minlength="6"  maxlength="15" class="required">
                            </p>
                            <p>
                                <label class="form-label">First Name</label>
                                <input type="text" value="${userList.firstName}" name="firstName" class="required">
                            </p>

                            <p><label class="form-label">Last Name</label>
                                <input type="text" value="${userList.lastName}"  name="lastName">
                            </p>

                            <p>
                                <label class="form-label">User Role</label>
                                <select name="userRole" id="userrole" style="width: 170px;" >
                                    <c:if test="${userList.userrole eq 'admin'}">
                                        <option value="admin">Administrator</option>
                                        <option value="employee">Employee</option>
                                        <option value="general">General</option>
                                        <option value="manager">Manager</option>
                                    </c:if>
                                    <c:if test="${userList.userrole eq 'employee'}">
                                        <option value="employee">Employee</option>
                                        <option value="admin">Administrator</option>
                                        <option value="general">General</option>
                                        <option value="manager">Manager</option>
                                    </c:if>
                                    <c:if test="${userList.userrole eq 'general'}">
                                        <option value="general">General</option>
                                        <option value="admin">Administrator</option>
                                        <option value="employee">Employee</option>
                                        <option value="manager">Manager</option>
                                    </c:if>
                                    <c:if test="${userList.userrole eq 'manager'}">
                                        <option value="manager">Manager</option>
                                        <option value="admin">Administrator</option>
                                        <option value="employee">Employee</option>
                                        <option value="general">General</option>
                                    </c:if>
                                </select>                              

                            </p>

                            <p><label class="form-label">Division</label>                               
                                <select name="division" id="division" style="width: 170px;">
                                    <c:if test="${userList.division eq '1'}">
                                        <option value="1">JAL 1</option>
                                        <option value="2">JAL 2</option>
                                        <option value="3">JAL 3</option>
                                    </c:if>
                                    <c:if test="${userList.division eq '2'}">
                                        <option value="2">JAL 2</option>
                                        <option value="1">JAL 1</option>
                                        <option value="3">JAL 3</option>
                                    </c:if>
                                    <c:if test="${userList.division eq '3'}">
                                        <option value="3">JAL 3</option>
                                        <option value="1">JAL 1</option>
                                        <option value="2">JAL 2</option>
                                    </c:if>
                                </select>
                            </p>


                            <input type="submit" class="button" value="Submit" name="submit">

                            <a href="<%= request.getContextPath()%>/viewUser"><input type="button" class="button" value="Cancel" name="cancel"></a>

                        </form>



                    </div>
                </div>
                <jsp:include page="../common/footer.jsp"/>
            </div>
        </div>
    </body>
</html>