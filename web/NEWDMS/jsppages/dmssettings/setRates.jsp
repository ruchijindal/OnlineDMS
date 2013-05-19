<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*,java.security.*;" %>
<%response.setHeader("Pragma", "no-cache");
            response.setHeader("Cache-Control", "no-store, no-cache");
            response.setDateHeader("Expires", 0);
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">


<c:set var="newRate" value="0"></c:set>
<c:set var="chl" value="1"></c:set>

<HTML>
    <HEAD>
        <title>Set Rates</title>
        <link rel="stylesheet" href="resources/css/reset.css" type="text/css" media="screen" />

        <!-- Main Stylesheet -->
        <link rel="stylesheet" href="resources/css/style.css" type="text/css" media="screen" />

        <!-- Invalid Stylesheet. This makes stuff look pretty. Remove it if you want the CSS completely valid -->
        <link rel="stylesheet" href="resources/css/invalid.css" type="text/css" media="screen" />
        <link rel="stylesheet" href="resources/css/simpletree.css" type="text/css" media="screen" />

        <jsp:include page="../common/header.jsp"/>
    </HEAD>


    <script  type="text/javascript" src="<%= request.getContextPath()%>/NEWDMS/resources/jquery/jquery-1.3.2.js"></script>
    <script type="text/javascript" src="<%= request.getContextPath()%>/NEWDMS/resources/jquery/jquery.validate_1.js"></script>
    <script type="text/javascript" src="<%= request.getContextPath()%>/NEWDMS/resources/jquery/jquery.maskedinput-1.2.2.js"></script>
    <script type="text/javascript">
        $(document).ready(function()
        {

            $("#dateFrom_2").mask("99/99/99");
            $("#dateTo_2").mask("99/99/99");
            $("#dateFrom_1").mask("99/99/99");
            $("#dateTo_1").mask("99/99/99");
            $("#newform").validate();
        
        });
       
        function insertRates()
        {
            xmlHttp=GetXmlHttpObject()
            if (xmlHttp==null)
            {
                alert ("Browser does not support HTTP Request")
                return;
            }
            var connectionType2 =document.getElementById("connectionType_2").value;
            var connectionCategory2 =document.getElementById("connectionCategory_2").value;
            var flatType2 =document.getElementById("flatType_2").value;
            var sector2 =document.getElementById("sector_2").value;
            var dateFrom2 =document.getElementById("dateFrom_2").value;           
            var minPlotSize2 =document.getElementById("minPlotSize_2").value;
            var maxPlotSize2 =document.getElementById("maxPlotSize_2").value;
            var pipeSize2 =document.getElementById("pipeSize_2").value;
            var rate2 =document.getElementById("rate_2").value;
            var connectionType_1= document.getElementById("connectionType_1").value;
            var connectionCategory_1=document.getElementById("connectionCategory_1").value;
            var dateFrom_1=document.getElementById("dateFrom_1").value;                  
            var plotSize_1=document.getElementById("plotSize_1").value;
            var pipeSize_1=document.getElementById("pipeSize_1").value;
            if((connectionType2==null||connectionType2=="")||(connectionCategory2==null||connectionCategory2=="")||(flatType2==null||flatType2=="")||(sector2==null||sector2=="")||(dateFrom2==null||dateFrom2=="")||(minPlotSize2==null||minPlotSize2=="")||(maxPlotSize2==null||maxPlotSize2=="")||(pipeSize2==null||pipeSize2=="")||(rate2==null||rate2==""))
            {               
                return false;
            }else{

                var url= "<%=request.getContextPath()%>/insertRate?connectionType2="+connectionType2 +"&connectionCategory2=" +connectionCategory2 +"&flatType2=" +flatType2 +"&sector2=" +sector2 +"&dateFrom2=" +dateFrom2 +"&minPlotSize2=" +minPlotSize2 +"&maxPlotSize2=" +maxPlotSize2 +"&pipeSize2=" +pipeSize2 +"&rate2=" +rate2+"&connectionType_1=" +connectionType_1 +"&connectionCategory_1=" +connectionCategory_1+"&dateFrom_1=" +dateFrom_1 +"&plotSize_1="+plotSize_1+"&pipeSize_1="+pipeSize_1;
                document.getElementById("connectionType_2").value=null;
                document.getElementById("connectionCategory_2").value=null;
                document.getElementById("flatType_2").value=null;
                document.getElementById("sector_2").value=null;
                document.getElementById("dateFrom_2").value=null;
                document.getElementById("minPlotSize_2").value=null;
                document.getElementById("maxPlotSize_2").value=null;
                document.getElementById("pipeSize_2").value=null;
                document.getElementById("rate_2").value=null;

                xmlHttp.onreadystatechange=statechanged;
            
                xmlHttp.open("POST",url,true);
                xmlHttp.send(null);
            
            }

        }

        function closeRates()
        {
            xmlHttp=GetXmlHttpObject()
            if (xmlHttp==null)
            {
                alert ("Browser does not support HTTP Request")
                return;
            }
            //            var connectionType_1= document.getElementById("connectionType_1").value;
            //            var connectionCategory_1=document.getElementById("connectionCategory_1").value;
            //            var flatType_1 =document.getElementById("flatType_1").value;
            //            var sector_1 =document.getElementById("sector_1").value;
            //            var dateFrom_1=document.getElementById("dateFrom_1").value;
            //            var dateTo_1=document.getElementById("dateTo_1").value;
            //            var minPlotSize_1=document.getElementById("minPlotSize_1").value;
            //            var maxPlotSize_1=document.getElementById("maxPlotSize_1").value;
            //            var pipeSize_1=document.getElementById("pipeSize_1").value;
            // var url= "<%=request.getContextPath()%>/rates?&connectionType_1=" +connectionType_1 +"&connectionCategory_1=" +connectionCategory_1 +"&flatType_1=" +flatType_1 +"&sector_1=" +sector_1+"&dateFrom_1=" +dateFrom_1 +"&dateTo_1=" +dateTo_1 +"&minPlotSize_1=" +minPlotSize_1+"&maxPlotSize_1="+maxPlotSize_1+"&pipeSize_1="+pipeSize_1;
            var url= "<%=request.getContextPath()%>/closeNewRate";
            xmlHttp.onreadystatechange=statechanged;
            xmlHttp.open("POST",url,true);
            xmlHttp.send(null);

        }
         

        function makeEditableChl1(chl)
        {
          
            var txt_inp = document.getElementsByTagName('input');                      
            var m=0 , j=1,k=1;

            for(i=0; i< txt_inp.length; i++)
            {

                if(txt_inp[i].type == "text" || txt_inp[i].type == "hidden" )
                {
                    var x = txt_inp[i];
                    
                   
                    // get or set id
                            
                    
                    if(x.name=="id"||x.name=="connectionType"||x.name=="connectionCategory"||x.name=="flatType"||x.name=="sector"||x.name=="dateFrom"||x.name=="minPlotSize"||x.name=="maxPlotSize"||x.name=="pipeSize"||x.name=="rate")
                                              
                    {
                        
                        x.id = "Id"+j; // We are dynamically setting and ID
                        Id="Id"+j;                       
                        if((j==((chl-1)*10)+k) && k<=10)
                        {
                        
                            document.getElementById(Id).removeAttribute("readonly");
                            if(x.name=="dateFrom"){
                                $("#"+Id).mask("99/99/99");
                            }
                           
                            document.getElementById(Id).id="ID"+k;
                            
                            
                            k++;
                            document.getElementById("edit"+chl).style.display="none";
                            document.getElementById("save"+chl).style.display="inline-block";
                            document.getElementById("del"+chl).style.display="inline-block";
                             
                        }
                        j++;
                       
                       
                    }
                }

            }


        }
        
        function editRates()
        {
            xmlHttp=GetXmlHttpObject()
            if (xmlHttp==null)
            {
                alert ("Browser does not support HTTP Request")
                return;
            }
            var id =document.getElementById("ID1").value;
            var connectionType =document.getElementById("ID2").value;
            var connectionCategory =document.getElementById("ID3").value;
            var flatType =document.getElementById("ID4").value;
            var sector =document.getElementById("ID5").value;
            var dateFrom =document.getElementById("ID6").value;            
            var minPlotSize =document.getElementById("ID7").value;
            var maxPlotSize =document.getElementById("ID8").value;
            var pipeSize =document.getElementById("ID9").value;
            var rate =document.getElementById("ID10").value;
            var connectionType_1= document.getElementById("connectionType_1").value;
            var connectionCategory_1=document.getElementById("connectionCategory_1").value;
            var dateFrom_1=document.getElementById("dateFrom_1").value;                   
            var plotSize_1=document.getElementById("plotSize_1").value;
            var pipeSize_1=document.getElementById("pipeSize_1").value;
            var url= "<%=request.getContextPath()%>/editRates?id="+id +"&connectionType="+connectionType +"&connectionCategory=" +connectionCategory +"&flatType=" +flatType +"&sector=" +sector +"&dateFrom=" +dateFrom +"&minPlotSize=" +minPlotSize +"&maxPlotSize=" +maxPlotSize +"&pipeSize=" +pipeSize +"&rate=" +rate+"&connectionType_1=" +connectionType_1 +"&connectionCategory_1=" +connectionCategory_1+"&dateFrom_1=" +dateFrom_1 +"&plotSize_1="+plotSize_1+"&pipeSize_1="+pipeSize_1;
            xmlHttp.onreadystatechange=statechanged;
            xmlHttp.open("POST",url,true);
            xmlHttp.send(null);
        
        }

        function confirmDel(id)
        {
            var msg;
            msg="Do you want to delete this record permanently?"
            var agree=confirm(msg);
            if(agree)
                deleteRates(id);
            else
                return false;

        }

        function deleteRates(id)
        {
            xmlHttp=GetXmlHttpObject()
            if (xmlHttp==null)
            {
                alert ("Browser does not support HTTP Request")
                return;
            }
            var connectionType_1= document.getElementById("connectionType_1").value;
            var connectionCategory_1=document.getElementById("connectionCategory_1").value;
            var flatType_1 =document.getElementById("flatType_1").value;
            var sector_1 =document.getElementById("sector_1").value;
            var dateFrom_1=document.getElementById("dateFrom_1").value;                  
            var plotSize_1=document.getElementById("plotSize_1").value;
            var pipeSize_1=document.getElementById("pipeSize_1").value;
            var url= "<%=request.getContextPath()%>/deleteRate?id="+id +"&connectionType_1=" +connectionType_1 +"&connectionCategory_1=" +connectionCategory_1 +"&flatType_1=" +flatType_1 +"&sector_1=" +sector_1 +"&dateFrom_1=" +dateFrom_1 +"&plotSize_1="+plotSize_1+"&pipeSize_1="+pipeSize_1 ;
            xmlHttp.onreadystatechange=statechanged;
            xmlHttp.open("GET",url,true);
            xmlHttp.send(null);
        }

        
        function resetAll()
        {
            xmlHttp=GetXmlHttpObject()
            if (xmlHttp==null)
            {
                alert ("Browser does not support HTTP Request")
                return;
            }


            var url= "<%=request.getContextPath()%>/rates" ;
            xmlHttp.onreadystatechange=statechanged;
            xmlHttp.open("GET",url,true);
            xmlHttp.send(null);


        }
        function searchType()
        {
            xmlHttp=GetXmlHttpObject()
            if (xmlHttp==null)
            {
                alert ("Browser does not support HTTP Request")
                return;
            }
            var connection_type= document.getElementById("connectionType_1").value;
            var connection_category=document.getElementById("connectionCategory_1").value;
            var flat_type =document.getElementById("flatType_1").value;
            var sector =document.getElementById("sector_1").value;
            var date_from=document.getElementById("dateFrom_1").value;
            var plotSize=document.getElementById("plotSize_1").value;
            var pipe_size=document.getElementById("pipeSize_1").value;

            var url= "<%=request.getContextPath()%>/searchType?connection_type=" +connection_type +"&connection_category=" +connection_category +"&flat_type=" +flat_type +"&sector=" +sector+"&date_from=" +date_from +"&plotSize="+plotSize+"&pipe_size="+pipe_size ;
            xmlHttp.onreadystatechange=statechanged;
            xmlHttp.open("GET",url,true);
            xmlHttp.send(null);

        }

        function statechanged()
        {
            if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
            {

                window.location = "#";
                window.location.reload();
           
            }
        }
        

        function pagination1( )
        {
            var startValue=  document.getElementById("page").value;
           
            var start= parseInt(startValue, 10)+1;
            var end=parseInt(startValue, 10)+10;
            paginations( start ,  end);
        }
        
        function paginations( start ,  end)
        {
            xmlHttp=GetXmlHttpObject()
            xmlHttp.open("GET","<%= request.getContextPath()%>/pagination?s="+start+"&e="+end,true);
            xmlHttp.onreadystatechange=statechanged;
            xmlHttp.send(null);
        }

        function setNewRate()
        {
            xmlHttp=GetXmlHttpObject()
            if (xmlHttp==null)
            {
                alert ("Browser does not support HTTP Request")
                return;
            }
            var url="<%=request.getContextPath()%>/setNewRate";            
            xmlHttp.onreadystatechange=statechanged;
            xmlHttp.open("GET",url,true);

            xmlHttp.send(null);

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


    <BODY>



        <div id="body-wrapper"> <!-- Wrapper for the radial gradient background -->
            <jsp:include page="../common/navbar.jsp"/>
            <div id="main-content"> <!-- Main Content Section with everything -->
                <a name="bottom"></a>


                <div class="content-box"><!-- Start Content Box -->
                    <div class="content-box-header">
                        <h3>Rates</h3> 

                        <div class="content-box-tabs">


                            <a href onclick="setNewRate()"><label class="button">New Rate </label></a>


                        </div>

                        <div class="clear"></div>

                    </div>
                    <!-- End .content-box-header -->


                    <div class="content-box-content">
                        <div class="tab-content default-tab" id="tab2">
                            <noscript> <!-- Show a notification if the user has disabled javascript -->
                                <div class="notification error1 png_bg">
                                    <a href="#" class="close"><img src="NEWDMS/resources/images/icons/cross_grey_small.png" title="Close this notification" alt="close" /></a>
                                    <div>

						Javascript is disabled or is not supported by your browser. Please upgrade your browser or Enable Javascript in your browser.
                                    </div>
                                </div>

                            </noscript>
                            <!-- <div class="notification information png_bg">
                                 <a href="#" class="close"><img src="resources/images/icons/cross_grey_small.png" title="Close this notification" alt="close" /></a>
                                 <div>
				 Records found: ${rateListSize}&nbsp;&nbsp;&nbsp;&nbsp;
                                 </div>
                             </div>-->
                            <div>
                                <c:set var="t3" value="<%= session.getAttribute("t3")%>"/>
                                <c:choose>
                                    <c:when test="${t3=='1'}">
                                        <%session.setAttribute("t3", 0);%>

                                        <div class="notification success png_bg">
                                            <a href="#" class="close"><img src="NEWDMS/resources/images/icons/cross_grey_small.png" title="Close this notification" alt="close" /></a>
                                            <div>
					Data Inserted Successfully.
                                            </div>
                                        </div>
                                    </c:when>
                                    <c:when test="${t3=='2'}">
                                        <% session.setAttribute("t3", 0);%>
                                        <div class="notification error1 png_bg">
                                            <a href="#" class="close"><img src="NEWDMS/resources/images/icons/cross_grey_small.png" title="Close this notification" alt="close" /></a>
                                            <div>
					 Error ! try again.
                                            </div>
                                        </div>

                                    </c:when>
                                </c:choose>
                                <c:set var="t4" value="<%= session.getAttribute("t4")%>"/>
                                <c:choose>
                                    <c:when test="${t4=='1'}">
                                        <% session.setAttribute("t4", 0);%>
                                        <div class="notification success png_bg">
                                            <a href="#" class="close"><img src="NEWDMS/resources/images/icons/cross_grey_small.png" title="Close this notification" alt="close" /></a>
                                            <div>
					 Updated Successfully
                                            </div>
                                        </div>
                                    </c:when>
                                    <c:when test="${t4=='2'}">
                                        <% session.setAttribute("t4", 0);%>
                                        <div class="notification error1 png_bg">
                                            <a href="#" class="close"><img src="NEWDMS/resources/images/icons/cross_grey_small.png" title="Close this notification" alt="close" /></a>
                                            <div>
			          There was some error.
                                            </div>
                                        </div>
                                    </c:when>
                                </c:choose>
                                <c:set var="t5" value="<%= session.getAttribute("t5")%>"/>
                                <c:choose>
                                    <c:when test="${t5=='1'}">

                                        <% session.setAttribute("t5", 0);%>
                                        <div class="notification success png_bg">
                                            <a href="#" class="close"><img src="NEWDMS/resources/images/icons/cross_grey_small.png" title="Close this notification" alt="close" /></a>
                                            <div>
					Data Deleted Successfully.
                                            </div>
                                        </div>


                                    </c:when>
                                    <c:when test="${t5=='2'}">
                                        <% session.setAttribute("t5", 0);%>
                                        <div class="notification error1 png_bg">
                                            <a href="#" class="close"><img src="NEWDMS/resources/images/icons/cross_grey_small.png" title="Close this notification" alt="close" /></a>
                                            <div>
					 Error ! try again.
                                            </div>
                                        </div>

                                    </c:when>

                                </c:choose>

                                <c:set value="10" var="pageSize"/>

                                <c:set var="rowStart" value="${s}"/>

                                <c:set var="rowEnd" value="${e}"/>


                                <form id="form1" name="form1" action="#">
                                    <table  cellspacing="0" cellpadding="0" style="color: #000;">
                                        <tr><td>
                                                Conn type

                                                <select id="connectionType_1" name="connectionType_1"  onchange="searchType() " style="width: 110px; " >
                                                    <option value="">Select</option>
                                                    <option value="I">Industrial</option>
                                                    <option value="T">Institutional</option>
                                                    <option value="C">Commercial</option>
                                                    <option value="R">Residential</option>
                                                    <option value="G">Group Housing</option>
                                                </select>
                                            </td>
                                            <td> Conn Category
                                                <select name="connectionCategory_1" id="connectionCategory_1" onchange="searchType()" style="width: 90px; ">
                                                    <option value="">Select</option>
                                                    <option value="T">Temporary</option>
                                                    <option value="R">Regular</option>
                                                </select></td>

                                            <td> Flat Type                                                
                                                <select name="flatType_1" id="flatType_1" onchange="searchType()" style="width: 90px; " >
                                                    <option value="">Select</option>
                                                    <option value="MIG">MIG</option>
                                                    <option value="MIGI">MIGI</option>
                                                    <option value="MIG2">MIG2</option>
                                                    <option value="HIG">HIG</option>
                                                    <option value="HIGI">HIGI</option>
                                                    <option value="DUPLEX">DUPLEX</option>
                                                    <option value="VILL">VILL</option>
                                                    <option value="EWS">EWS</option>
                                                    <option value="EWSI">EWSI</option>
                                                    <option value="LIG">LIG</option>
                                                    <option value="LIGI">LIGI</option>
                                                </select>

                                            </td>
                                            <c:set var="sectorsList" value="<%= session.getAttribute("sectorsList") %>"/>
                                            <td> Sector                                               
                                                <select name="sector_1" id="sector_1" onchange="searchType()" style="width: 100px; ">
                                                    <option value="">Select</option>
                                                    <c:forEach var="sector" items="${sectorsList}">
                                                        <option value="${sector}">${sector}</option>
                                                    </c:forEach>
                                                </select>
                                            </td>
                                            <td> Date From
                                                <input type="text" name="dateFrom_1" id="dateFrom_1" size="6px;" onblur="searchType()" /></td>
                                            

                                            <td> Pipe Size
                                                <input type="text" name="pipeSize_1" id="pipeSize_1" size="6px;" onblur="searchType()"/>
                                            </td>

                                            <td> Plot Size
                                                <input type="text" name="plotSize_1" id="plotSize_1" size="6px;" onblur="searchType()"/>
                                            </td>
                                            <td colspan="4" width="2400px;"></td>

                                            <td> 
                                                <input type="reset" onclick="resetAll()" class="button" size="20px;" /> </td> 

                                        </tr>
                                    </table>
                                </form>



                                <table  cellspacing="0" cellpadding="0" style="color: #000;">

                                    <thead>
                                        <tr>
                                            <th></th>

                                            <th>Conn type</th>
                                            <th>Conn Category</th>
                                            <th>Flat Type</th><th></th>
                                            <th>Sector</th>
                                            <th></th>
                                            <th>Date From</th>  <th></th>
                                            <th>Pipe Size</th>
                                            <th>Min Plot Size </th>
                                            <th>Max Plot Size</th> 
                                            <th >Rate</th>
                                            <th></th>
                                            <th>Options</th>

                                        </tr>

                                    </thead>



                                    <c:set var="newRate" value="<%= session.getAttribute("newRate")%>"/>
                                    <c:if test="${newRate eq 1}">
                                        <c:set var="newRate" value="0"></c:set>

                                        <table>
                                            <form id="newform" method="post" action="" onsubmit="insertRates()">

                                                <tr> <td></td> <td>
                                                        <input type="text" name="connectionType_2" id="connectionType_2" size="6px;" class="required"/>
                                                    </td>

                                                    <td> <input type="text" name="connectionCategory_2" id="connectionCategory_2" size="6px;" class="required"/>
                                                    </td>

                                                    <td>
                                                        <input type="text" name="flatType_2" id="flatType_2" size="6px;" class="required"/>
                                                    </td>

                                                    <td>
                                                        <input type="text" name="sector_2" id="sector_2" size="6px;" class="required"/>
                                                    </td>
                                                    <td> <input type="text" name="dateFrom_2" id="dateFrom_2" size= "6px;" class="required"/></td>
                                                    <td><input type="text" name="pipeSize_2" id="pipeSize_2" size="6px;" class="required"/></td>

                                                    <td><input type="text" name="minPlotSize_2" id="minPlotSize_2" size="6px;" class="required"/></td>

                                                    <td><input type="text" name="maxPlotSize_2" id="maxPlotSize_2" size="6px;" class="required"/></td>



                                                    <td><input type="text" name="rate_2" id="rate_2" size="6px;" class="required"/></td>

                                                    <td><input  type="submit" name="submit"  class="savebutton" value="" size="8px;" class="required"/></td><td><a href onclick="closeRates()" ><label  class="delbutton" ></label></a></td>
                                                </tr>
                                            </form>
                                        </table>


                                    </c:if>
                                    <c:set var="refresh" value="${rateList}"></c:set>
                                    <c:forEach  begin="${s-1}" step="1" end="${e-1}" var="rates" varStatus="status" items="${refresh}">

                                        <table id="table1">

                                            <form id="form${chl}" method="post" action="">
                                                <tr>
                                                    <td><input type="hidden" name="id" id="id" value="${rates.id}" size="6px;" readonly/></td>
                                                    <td><input type="text" name="connectionType" id="connectionType${chl}" value="${rates.connType}" size="6px;" readonly /></td>
                                                    <td><input type="text" name="connectionCategory" id="connectionCategory${chl}" value="${rates.connCategory}" size="6px;" readonly /></td>
                                                    <td><input type="text" name="flatType" id="flatType${chl}" value="${rates.flatType}" size="6px;" readonly/></td>
                                                    <td><input type="text" name="sector" id="sector${chl}" value="${rates.sector}" size="6px;" readonly /></td>
                                                    <td><fmt:formatDate value="${rates.dateFrom}"  pattern="dd/MM/yy" var="date_from"/> <input type="text" id="dateFrom${chl}" name="dateFrom" value="${date_from}" size="6px;" readonly/> </td>
                                                    <td><input type="text" name="pipeSize" id="pipeSize${chl}" value="${rates.pipeSize}" size="6px;" readonly/></td>

                                                    <td><input type="text" name="minPlotSize" id="minPlotSize${chl}" value="${rates.minPlotSize}" size="6px;" readonly/></td>
                                                    <td><input type="text" name="maxPlotSize" id="maxPlotSize${chl}" value="${rates.maxPlotSize}" size="6px;" readonly/></td>

                                                    <td><input type="text" name="rate" id="rate${chl}" value="${rates.rate}" size="6px;" readonly/></td>
                                                    <td id="edit${chl}"  style="display:inline-block">  <a href="#bottom" onclick="makeEditableChl1(${chl})"><label class="button" >EDIT</label></a></td>
                                                    <td id="save${chl}" style="display:none"><input  type="button" onclick="editRates()"  class="savebutton" value="" size="6px;"/></td>
                                                    <td  id="del${chl}" style="display:none"><a href  onclick="confirmDel(${rates.id})"><label  class="delbutton" ></label></a></td>
                                                </tr>
                                                <c:set var="chl" value="${chl+1}"></c:set>
                                            </form>

                                        </table>
                                    </c:forEach>

                                    <c:set value="${rateListSize}" var="rLen"/>
                                    <c:choose>
                                        <c:when test="${rLen lt e}">
                                            <c:set var="rCurrEnd" value="${rLen}"/>
                                        </c:when>
                                        <c:otherwise>
                                            <c:set var="rCurrEnd" value="${e}"/>
                                        </c:otherwise>
                                    </c:choose>

                                    <tr><td>



                                            <select name="page" id="page" onchange="pagination1()" >
                                                <option value="">Select Page No.</option>

                                                <c:forEach var="pStart" varStatus="status" begin="0" end="${rLen-1}" step="${pageSize}">

                                                    <option value="${pStart}" >Page No ${status.count} </option>
                                                </c:forEach>
                                            </select>


                                        </td>
                                        <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                        <td><div class="pagination"> Displaying Records:&nbsp; ${s}&nbsp;-&nbsp;${rCurrEnd}</div></td>



                                        <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                        <td ><div class="pagination">
                                                <c:choose>
                                                        <c:when test="${rLen < 40}">
                                                            <c:set var="rEnd" value="${rLen}"></c:set>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <c:set var="rEnd" value="40"></c:set>
                                                        </c:otherwise>
                                                    </c:choose>
                                                    <c:choose>
                                                        <c:when test="${rEnd%10 eq 0}">
                                                            <c:set var="rEnd1" value="${rEnd}"></c:set>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <c:set var="rEnd1" value="${rEnd+(10-(rEnd%10))}"></c:set>
                                                        </c:otherwise>
                                                    </c:choose>


                                                    <c:if test="${rowStart gt 10}">
                                                        
                                                        <a href=""  onclick="paginations( ${rowStart-pageSize}, ${rowEnd-pageSize})">&laquo; Prev</a>
                                                         
                                                    </c:if>


                                                    <c:choose>

                                                        <c:when test="${(rowEnd)> 40}">
                                                             <c:set var="rBegin" value="${rowStart-20}"></c:set>
                                                            <c:choose>
                                                                <c:when test="${rLen gt (rowEnd+10)}">
                                                                    <c:set var="rBegin" value="${rowStart-40}"></c:set>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <c:if test="${rLen gt (rowEnd)}">
                                                                        <c:set var="rBegin" value="${rowStart-30}"></c:set>
                                                                    </c:if>

                                                                </c:otherwise>

                                                            </c:choose>

                                                            <c:forEach var="pStart" varStatus="status" begin="${rBegin}" end="${rowEnd}" step="${pageSize}">



                                                                <span>

                                                                    <c:set value="${(status.count)+(((rowStart-1)/10)-2)}"  var="count"/>
                                                                    <fmt:formatNumber maxFractionDigits="0" value="${count}" var="count1"></fmt:formatNumber>

                                                                    <c:choose>
                                                                        <c:when test="${rowEnd/10 eq count}">
                                                                            
                                                                            
                                                                            <a href="" onclick="paginations(${(count1-1)*10+1},${(count1-1)*10+10})" ><b style="color: black"> ${count1}</b> </a>
                                                                        </c:when>
                                                                        <c:otherwise>

                                                                            <a href="" onclick="paginations(${(count1-1)*10+1},${(count1-1)*10+10})" > ${count1} </a>

                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </span>
                                                            </c:forEach>
                                                        </c:when>
                                                        <c:otherwise>
                                                            
                                                               <c:set var="rREND" value="${rowEnd}"></c:set>
                                                              <c:choose>
                                                                <c:when test="${rLen lt rowEnd}">
                                                                    <c:set var="rBegin" value="1"></c:set>
                                                                    <c:set var="rREND" value="${rowEnd}"></c:set>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <c:set var="rBegin" value="1"></c:set>
                                                                    <c:set var="rREND" value="${rowEnd+40}"></c:set>
                                                                </c:otherwise>
                                                                
                                                            </c:choose>
                                                            <c:choose>
                                                            <c:when test="${rLen >= ((rREND)-9)}">

                                                                    <c:set var="rREND" value="${rREND}"></c:set>
                                                                    <c:if test="${(rREND-rBegin) > 50}">

                                                                    <c:set var="rREND" value="50"></c:set>
                                                                    </c:if>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <c:if test="${rLen <= rREND-39}">
                                                                        
                                                                    <c:set var="rREND" value="${rREND-30}"></c:set>
                                                                    </c:if>
                                                                    <c:if test="${rLen <= rREND-29}">

                                                                    <c:set var="rREND" value="${rREND-20}"></c:set>
                                                                    </c:if>
                                                                     <c:if test="${rLen <= rREND-19}">

                                                                    <c:set var="rREND" value="${rREND-10}"></c:set>
                                                                    </c:if>
                                                                     <c:if test="${rLen <= rREND-9}">

                                                                    <c:set var="rREND" value="${rREND-10}"></c:set>
                                                                    </c:if>
                                                                    <c:if test="${(rREND-rBegin) > 50}">

                                                                    <c:set var="rREND" value="50"></c:set> 
                                                                    </c:if>
                                                                </c:otherwise>
                                                            </c:choose>

                                                            <c:forEach var="pStart" varStatus="status" begin="${rBegin}" end="${rREND}" step="${pageSize}">


                                                                <span>
                                                                    <c:set value="${(status.count)+((rBegin-1)/10)}"  var="count"/>

                                                                    <fmt:formatNumber maxFractionDigits="0" value="${count}" var="count1"></fmt:formatNumber>

                                                                    <c:choose>
                                                                        <c:when test="${rowEnd/10 eq count}">

                                                                            <a href="" onclick="paginations(${(count1-1)*10+1},${(count1-1)*10+10})" ><b style="color: black"> ${count1}</b> </a>
                                                                        </c:when>
                                                                        <c:otherwise>

                                                                            <a href="" onclick="paginations(${(count1-1)*10+1},${(count1-1)*10+10})" > ${count1} </a>

                                                                        </c:otherwise>
                                                                    </c:choose>


                                                                </span>
                                                            </c:forEach>

                                                        </c:otherwise>
                                                    </c:choose>



                                                

                                                <c:if test="${(rLen gt rowEnd)   }">

                                                    <a href="" onclick="paginations(${rowEnd+1}, ${rowEnd+10})">Next &raquo;</a>
                                                </c:if>
                                            </div>
                                        </td>
                                    </tr>

                                </table>
                            </div>
                        </div>
                        <br> <br>

                    </div>
                </div>
            </div>

            <jsp:include page="../common/footer.jsp"/>
        </div>

    </BODY>
</HTML>
