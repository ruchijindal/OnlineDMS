
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %> 
<%response.setHeader("Pragma", "no-cache");
            response.setHeader("Cache-Control", "no-store, no-cache");
            response.setDateHeader("Expires", 0);
%>
<%! int searchFlag = 0;%>
<%@page  language="java" import="javax.xml.parsers.DocumentBuilderFactory,javax.xml.parsers.DocumentBuilder,org.w3c.dom.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <title>Search</title>
    <jsp:include page="../common/header.jsp"/>
    <script  type="text/javascript" src="<%= request.getContextPath()%>/NEWDMS/resources/jquery/jquery-1.3.2.js"></script>
    <script type="text/javascript" src="<%= request.getContextPath()%>/NEWDMS/resources/jquery/jquery.validate_1.js"></script>

    <script  type="text/javascript">
        $(document).ready(function()
        {
            $("#form1").validate();
            $("#form2").validate();
        });


        window.onload = function()
        {
            document.getElementById("cons_no").focus();
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
        function checkMst()
        {
            cons_no= document.getElementById("cons_no").value
            if(document.getElementById("cons_no").value!="")
            {
                xmlHttp=GetXmlHttpObject()
                if (xmlHttp==null)
                {
                    alert ("Browser does not support HTTP Request")
                    return
                }
                var url="<%=request.getContextPath()%>/CheckConsumer"
                url=url+"?&cons_no="+cons_no
                xmlHttp.onreadystatechange=stateChanged1
                xmlHttp.open("GET",url,true)
                xmlHttp.send(null)
            }
            else if(document.getElementById("cons_no").value=="")
            {
                document.getElementById("lcons_no").style.visibility="hidden";
            }


        }

        function clearUserID()
        {
          var consumer=  document.getElementById("cons_no").value;

            if(consumer.length <8)
            {
                document.getElementById("lcons_no").style.visibility="hidden";
            }else{
                 cons_no= document.getElementById("cons_no").value
            if(document.getElementById("cons_no").value!="")
            {
                xmlHttp=GetXmlHttpObject()
                if (xmlHttp==null)
                {
                    alert ("Browser does not support HTTP Request")
                    return
                }
                var url="<%=request.getContextPath()%>/CheckConsumer"
                url=url+"?&cons_no="+cons_no
                xmlHttp.onreadystatechange=stateChanged1
                xmlHttp.open("GET",url,true)
                xmlHttp.send(null)
            }
            else if(document.getElementById("cons_no").value=="")
            {
                document.getElementById("lcons_no").style.visibility="hidden";
            }
            }
        }

        function stateChanged1()
        {
            if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
            {
                var showdata = xmlHttp.responseText;
                var data=showdata.split(":");
                if(data[0]==0)
                {
                    document.getElementById("lcons_no").style.visibility="visible";
                    document.getElementById("cons_no").focus();
                    document.getElementById("flag").value="1";
                    data[0]=1;
                }
                else if(data[0]==1)
                {
                    document.getElementById("lcons_no").style.visibility="hidden";
                     document.getElementById("flag").value="0";
                }

            }
        }
        function validateCons()
        {
            var flag=document.getElementById("flag").value;
            if(flag==1)
                {
                    return false;
                }else{
                    return true;
                }
        }
        function populateBlock()
        {
             
            var sector= document.getElementById("sector").value;
            xmlHttp=GetXmlHttpObject()
           
            if (xmlHttp==null)
            {
                alert ("Browser does not support HTTP Request")
                return
            }

            var url="<%= request.getContextPath()%>/GetBlocks"
            url=url+"?&sector="+sector;

            xmlHttp.onreadystatechange=stateChanged
            xmlHttp.open("GET",url,true)
            xmlHttp.send(null)
        }
        function stateChanged()
        {
            if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
            {
                var showdata = xmlHttp.responseText;
                var blockList = showdata.split(":");
                document.getElementById("block").options.length=1;
                for(i=0;i<blockList.length;i++)
                {              
                    document.getElementById("block").options[i+1]=new Option(blockList[i],blockList[i]);
                }
            }
        }
    </script>


    <body>
        <div id="body-wrapper"> <!-- Wrapper for the radial gradient background -->
            <jsp:include page="../common/navbar.jsp"/>
            <div id="main-content"> <!-- Main Content Section with everything -->
                <div class="content-box"><!-- Start Content Box -->
                    <div class="content-box-header">
                        <h3>Search</h3>
                        <div class="clear"></div>
                    </div> <!-- End .content-box-header -->
                    <div class="content-box-content">
                        <noscript> <!-- Show a notification if the user has disabled javascript -->
                            <div class="notification error1 png_bg">
                                <a href="#" class="close"><img src="NEWDMS/resources/images/icons/cross_grey_small.png" title="Close this notification" alt="close" /></a>
                                <div>

						Javascript is disabled or is not supported by your browser. Please upgrade your browser or Enable Javascript in your browser.
                                </div>
                            </div>
                        </noscript>
                        <% if (searchFlag == 1) {%>
                        <div class="notification error1 png_bg">
                            <a href="#" class="close"><img src="NEWDMS/resources/images/icons/cross_grey_small.png" title="Close this notification" alt="close" /></a>
                            <div>
			          Records not available.
                            </div>
                        </div>
                        <%} else if (searchFlag == 2) {%>
                        <div class="notification success png_bg">
                            <a href="#" class="close"><img src="NEWDMS/resources/images/icons/cross_grey_small.png" title="Close this notification" alt="close" /></a>
                            <div>
			          Record deleted.
                            </div>
                        </div>
                        <%} else if (searchFlag == 3) {%>
                        <div class="notification error1 png_bg">
                            <a href="#" class="close"><img src="NEWDMS/resources/images/icons/cross_grey_small.png" title="Close this notification" alt="close" /></a>
                            <div>
			          There was some error.
                            </div>
                        </div>
                        <%}%>
                        <div class="tab-content default-tab" >
                            <table>
                                <tr>
                                    <td>
                                        <form  id="form2" method="post" action="<%= request.getContextPath()%>/SelectSector" >

                                            <p>
                                                <label class="form-label">Sector</label>
                                                <select name="sector" id="sector" other="#blk_no" class="required" onchange="populateBlock()" style="width: 185px;" >
                                                    <option value="">select</option>
                                                    <c:forEach var="sector" items="${sectorList}">
                                                        <option value="${sector}">${sector}</option>
                                                    </c:forEach>
                                                </select>
                                            </p>
                                            <p>
                                                <label class="form-label">Block No</label>
                                                <select name="block" id="block" style="width: 185px;">
                                                    <option value="">select</option>
                                                </select>
                                            </p>
                                            <p>
                                                <label class="form-label">Flat No</label>
                                                <input  type="text" name="flat_no" id="flat_no" />
                                            </p>
                                            <p>
                                                <input class="button" type="submit" value="Submit" />
                                                <input type="reset" class="button" value="Reset" name="reset">
                                            </p>

                                        </form>
                                    </td>
                                    <td>
                                        <form id="form1" action="<%= request.getContextPath()%>/ConsumerDetails" onsubmit="return validateCons()">
                                            <p>
                                                <label class="form-label">Consumer No</label>
                                                <input type="hidden" id="flag" value="0"/>
                                                <input  type="text" name="cons_no"  id="cons_no" minlength="8" maxlength="9" class="required"  onkeyup="clearUserID()" />
                                                <label id="lcons_no" class="error" style="visibility:hidden" >Consumer Does Not Exist.</label>
                                            </p>
                                            <p>
                                                <input class="button" type="submit" value="Submit" />
                                                <input type="reset" class="button" value="Reset" name="reset">
                                            </p>
                                        </form>
                                    </td>
                            </table>
                        </div>

                    </div>
                </div>
                <jsp:include page="../common/footer.jsp"/>
            </div>
        </div>
    </body>
</html>
