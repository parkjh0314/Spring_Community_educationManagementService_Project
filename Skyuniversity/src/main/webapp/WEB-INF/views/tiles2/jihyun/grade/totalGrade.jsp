<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>

 div#totalGradeContainer {
 	font-size: 11pt;
 	margin: 30px 50px;
 }

 div#block2 {
 	display: flex;
 }
 
 input.defaultInput {
 	width: 85px;
 	margin-right: 30px;
 	outline: none;
 }
 
 div.defaultInfo {
 	margin-bottom: 50px;
 }
 
 div.totalGradeInfo {
	/* border: solid 1px lightgray;
 	border-radius: 10px;
	padding: 20px; */
	width: 100%; 
	margin-bottom: 50px;
 }
 
  
 div#sumBlock {
 	/* border: solid 1px lightgray; */
 	/* border-radius: 10px;
 	padding: 20px; */
 	width: 37%;
 	margin-right: 1%;
 	height: 400px;
 }
 
 div#detailBlock {
 	/* border: solid 1px lightgray;
 	border-radius: 10px;
 	padding:20px; */
 	width: 62%;
 	
 	height: 400px;
 }
 
 .bordered {
    *border-collapse: collapse; /* IE7 and lower */
    border-spacing: 0;
    width: 100%;
    border: solid #ccc 1px;
    -moz-border-radius: 6px;
    -webkit-border-radius: 6px;
    border-radius: 6px;
    -webkit-box-shadow: 0 1px 1px #ccc;
    -moz-box-shadow: 0 1px 1px #ccc;
    box-shadow: 0 1px 1px #ccc;
}
 
.bordered tr:hover {
    background: #fbf8e9;
    -o-transition: all 0.1s ease-in-out;
    -webkit-transition: all 0.1s ease-in-out;
    -moz-transition: all 0.1s ease-in-out;
    -ms-transition: all 0.1s ease-in-out;
    transition: all 0.1s ease-in-out;
}
 
.bordered td, .bordered th {
    border-left: 1px solid #ccc;
    border-top: 1px solid #ccc;
    padding: 10px;
    text-align: center;
}
 
.bordered th {
    background-color: #dce9f9;
    background-image: -webkit-gradient(linear, left top, left bottom, from(#ebf3fc), to(#dce9f9));
    background-image: -webkit-linear-gradient(top, #ebf3fc, #dce9f9);
    background-image:    -moz-linear-gradient(top, #ebf3fc, #dce9f9);
    background-image:     -ms-linear-gradient(top, #ebf3fc, #dce9f9);
    background-image:      -o-linear-gradient(top, #ebf3fc, #dce9f9);
    background-image:         linear-gradient(top, #ebf3fc, #dce9f9);
    -webkit-box-shadow: 0 1px 0 rgba(255,255,255,.8) inset;
    -moz-box-shadow:0 1px 0 rgba(255,255,255,.8) inset;
    box-shadow: 0 1px 0 rgba(255,255,255,.8) inset;
    border-top: none;
    text-shadow: 0 1px 0 rgba(255,255,255,.5);
    position: sticky;
    top: -1px;
    border-top: none;
}
 
.bordered td:first-child, .bordered th:first-child {
    border-left: none;
}
 
.bordered th:first-child {
    -moz-border-radius: 6px 0 0 0;
    -webkit-border-radius: 6px 0 0 0;
    border-radius: 6px 0 0 0;
}
 
.bordered th:last-child {
    -moz-border-radius: 0 6px 0 0;
    -webkit-border-radius: 0 6px 0 0;
    border-radius: 0 6px 0 0;
}
 
.bordered th:only-child{
    -moz-border-radius: 6px 6px 0 0;
    -webkit-border-radius: 6px 6px 0 0;
    border-radius: 6px 6px 0 0;
}
 
.bordered tr:last-child td:first-child {
    -moz-border-radius: 0 0 0 6px;
    -webkit-border-radius: 0 0 0 6px;
    border-radius: 0 0 0 6px;
}
 
.bordered tr:last-child td:last-child {
    -moz-border-radius: 0 0 6px 0;
    -webkit-border-radius: 0 0 6px 0;
    border-radius: 0 0 6px 0;
}
 
</style>

<script type="text/javascript">

 $(document).ready(function(){
	console.log("${totalGradeList}");
 });

</script>

<div id="totalGradeContainer">
    <div class="defaultInfo">
        <label style="width: 30px;">??????</label><input type="text" class="defaultInput" value="${loginuser.memberNo}" readonly />
        <label style="width: 30px;">??????</label><input type="text" class="defaultInput" value="${loginuser.name}" readonly />
    </div>
    <div class="totalGradeInfo" >
    	<h4 style="font-weight: bold;">?????????</h4>
        <table class="bordered">
            <thead>
                <tr>
                    <th>????????????</th>
                    <th>????????????</th>
                    <th>?????????</th>
                    <th>????????????</th>
                </tr>
            </thead>
            <tbody>
             	 <c:if test="${totalGradeList == '0'}">
           	  		<tr>
	                    <td>0</td>
	                    <td>0</td>
	                    <td>0</td>
	                    <td>0</td>
	                </tr>
	             </c:if>
	             <c:if test="${totalGradeList != '0'}">
		            <c:forEach var="tlist" items="${totalGradeInfoList}">
		                <tr>
		                    <td>${tlist.applicateCredits}</td>
		                    <td>${tlist.completeCredits}</td>
		                    <td>${tlist.totalScore}</td>
		                    <td>${tlist.averageScore}</td>
		                </tr>
	                </c:forEach>
                </c:if>
            </tbody>
        </table>
    </div>
    <div id="block2">
    	<div id="sumBlock">
		    <h4 style="font-weight: bold;">????????? ????????????</h4>
	    	<div style="border: solid 1px lightgray; height: 400px; overflow: auto">
		        <table class="bordered">
		            <thead>
		                <tr>
		                    <th>No</th>
		                    <th>??????</th>
		                    <th>????????????</th>
		                    <th>????????????</th>
		                    <th>??????????????????</th>
		                    <th>????????????</th>
		                </tr>
		            </thead>
		            <tbody>
		            <c:if test="${totalGradeList == '0'}">
		             	<tr>
		             		<td colspan="6" style="text-align: center;">????????? ??????????????? ????????????.</td>
		             	</tr>
		             </c:if>
		             <c:if test="${totalGradeList != '0'}">
			             <c:forEach var="slist" items="${semesterGradeList}" varStatus="status">
			                <tr>
			                    <td>${status.count}</td>
			                    <td>${slist.courseSemester}??????</td>
			                    <td>${slist.cCradits}</td>
			                    <td>${slist.averageScore}</td>
			                    <td>${slist.firstAverageScore}</td>
			                    <td>${slist.warning}</td>
			                </tr>
		                </c:forEach>
		            </c:if>
		            </tbody>
		        </table>
		        <p style="margin-top: 30px;">
		        * ??????????????????  - ????????? ????????? ??????<br>
		        * ????????????????????? F, ????????????, ???????????? ????????? ???????????????. ????????????, ?????????????????? ???????????????.<br>
		        * ???????????????????????? ?????????????????? ????????? ???????????????.<br>
		        * P, NP, ??????????????? ????????? ???????????? ????????????.<br>
		        * ( )??????????????? ??????????????? ???????????? ????????????.
		        </p>
		    </div>
	    </div>
	    <div id="detailBlock">
	        <h4 style="font-weight: bold;">?????? ????????? ????????????</h4>
		    <div style="overflow: auto; height: 400px; border: solid 1px lightgray;">
		        <table class="bordered">
		            <thead>
		                <tr>
		                    <th>No</th>
		                    <th>??????</th>
		                    <th>????????????</th>
		                    <th>???????????????</th>
		                    <th>????????????</th>
		                    <th>??????</th>
		                    <th>??????</th>
		                    <th>????????????</th>
		               </tr>
		           </thead>
		           <tbody>
		           <c:if test="${totalGradeList == '0'}">
		           		<tr>
							<td colspan="8" style="text-align: center;">????????? ????????? ????????????.</td>
						</tr>
		           </c:if>
		           <c:if test="${totalGradeList != '0'}">
			           <c:forEach var="glist" items="${eachGradeList}" varStatus="status">
			                <tr>
			                    <td>${status.count}</td>
			                    <td>${glist.courseYear}???&nbsp;${glist.semester}??????</td>
			                    <td>${glist.division}</td>
			                    <td>${glist.subjectNo}</td>
			                    <td>${glist.subjectName}</td>
			                    <td>${glist.credits}</td>
			                    <td>${glist.score}</td>
			                    <td>${glist.complete}</td>
			                </tr>
			           </c:forEach>
		           </c:if>
		           </tbody>
		        </table>
		     </div>
	     </div>
	 </div>

</div>
