<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%response.setHeader("Pragma", "no-cache");
            response.setHeader("Cache-Control", "no-store, no-cache");
            response.setDateHeader("Expires", 0);
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<c:set var="chl" value="1"></c:set>
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
    </head>
    <script type="text/javascript">
        
        

       

        function deleteConfirm(id)
        {
            var msg;
            msg="Do you want to delete this record permanently?"
            var agree=confirm(msg);
            if(agree)
                deleteUser(id);
            else
                return false;

        }

        function deleteUser(id)
        {
            xmlHttp=GetXmlHttpObject()
            if (xmlHttp==null)
            {
                alert ("Browser does not support HTTP Request")
                return;
            }

            var url= "<%=request.getContextPath()%>/deleteUser?id="+id;
            xmlHttp.onreadystatechange=statechanged;
            xmlHttp.open("GET",url,true);
            xmlHttp.send(null);
        }

        function statechanged()
        {
            if(xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
            {
                window.location.reload();
            }

        }
        function GetXmlHttpObject()
        {
           
            var xmlHttp=null;
            try
            {
                // Firefox, Opera 8.0+, Safari
                xmlHttp=new XMLHttpRequest();
            }
            catch (e)
            {
                //Internet Explorer
                try
                {
                    xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
                }
                catch (e)
                {
                    xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
                }
            }
            return xmlHttp;
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
                        <table cellspacing="0" cellpadding="0">
                            <c:set var="t" value="<%= session.getAttribute("t")%>"/>
                            <c:choose>
                                <c:when test="${t=='1'}">
                                    <% session.setAttribute("t", 0);%>
                                    <div class="notification success png_bg" >
                                        <a href="#" class="close"><img src="NEWDMS/resources/images/icons/cross_grey_small.png" title="Close this notification" alt="close" /></a>
                                        <div>
					 Updated Successfully
                                        </div>
                                    </div>

                                </c:when>
                                <c:when test="${t=='2'}">
                                    <% session.setAttribute("t", 0);%>
                                    <div class="notification error1 png_bg">
                                        <a href="#" class="close"><img src="NEWDMS/resources/images/icons/cross_grey_small.png" title="Close this notification" alt="close" /></a>
                                        <div>
			          There was some error.
                                        </div>
                                    </div>
                                </c:when>

                            </c:choose>



                            <c:set var="t2" value="<%= session.getAttribute("t2")%>"/>
                            <c:choose>
                                <c:when test="${t2=='1'}">
                                    <% session.setAttribute("t2", 0);%>
                                    <div class="notification success png_bg">
                                        <a href="#" class="close"><img src="NEWDMS/resources/images/icons/cross_grey_small.png" title="Close this notification" alt="close" /></a>
                                        <div>
					Data Deleted Successfuly.
                                        </div>
                                    </div>
                                </c:when>
                                <c:when test="${t2=='2'}">
                                    <% session.setAttribute("t2", 0);%>
                                    <div class="notification error1 png_bg">
                                        <a href="#" class="close"><img src="NEWDMS/resources/images/icons/cross_grey_small.png" title="Close this notification" alt="close" /></a>
                                        <div>
			          There was some error.
                                        </div>
                                    </div>
                                </c:when>
                            </c:choose>


                            <thead>
                                <tr>
                                    <th>User ID&nbsp;&nbsp;</th>                                  
                                    <th>First Name &nbsp;&nbsp;</th>
                                    <th>Last Name</th>
                                    <th>User Role</th>
                                    <th>Division</th>
                                    <th>Creation Date</th>
                                    <th>Last Login</th>
                                    <th>CreatedBy</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <c:forEach var="userList" items="${userList}">
                                <table id="table1">
                                    <form id="form${chl}" method="post" action="" >
                                        <tr>
                                            <td><input type="text" name="id" id="id" value="${userList.userid}" size="8px;" readonly /></td>
                                            <td><input type="text" name="firstName" id="firstName" value="${userList.firstName}" size="8px;" readonly /></td>
                                            <td><input type="text" name="lastName" id="lastName" value="${userList.lastName}" size="8px;" readonly /></td>
                                            <td><input type="text" name="userRole" id="userRole" value="${userList.userrole}" size="8px;" readonly /></td>
                                            <td><input type="text" name="division" id="division" value="${userList.division}" size="8px;" readonly /></td>
                                            <td><fmt:formatDate pattern="dd/MM/yy" value="${userList.crdate}" var="crDate"/> <input type="text" name="crDate" id="crDate" value="${crDate}" size="8px;" readonly /></td>
                                            <td><fmt:formatDate pattern="dd/MM/yy" value="${userList.lastloginDt}" var="lastLoginDate"/><input type="text" name="lastLoginDt" id="lastLoginDt" value="${lastLoginDate}" size="8px;" readonly /></td>
                                            <td><input type="text" name="createdBy" id="createdBy" value="${userList.createdBy}" size="8px;" readonly /></td>
                                            <td  style="display:inline-block">  <a href="<%= request.getContextPath()%>/redirectEditPage?userId=${userList.userid}"><label class="button" >EDIT</label></a></td>
                                            <td  style="display:inline-block">  <a href=""  onclick="deleteConfirm('${userList.userid}')" ><label class="button" >DELETE</label></a></td>
                                        </tr>
                                        <c:set var="chl" value="${chl+1}"></c:set>

                                    </form>
                                </table>
                            </c:forEach>

                        </table>
                    </div>
                </div>
                <jsp:include page="../common/footer.jsp"/>
            </div>
        </div>
    </body>
</html>