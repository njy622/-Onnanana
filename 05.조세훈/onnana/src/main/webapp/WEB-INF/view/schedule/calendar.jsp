<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="height" value="${600 / numberOfWeeks}"></c:set>
<c:set var="todaySdate" value="${fn:substring(today,0,4)}${fn:substring(today,5,7)}${fn:substring(today,8,10)}"></c:set>

<!DOCTYPE html>
<html>
<head>
    <%@ include file="../common/head.jspf" %>
    <style>
        th { text-align: center; width: 14.28%;}
        .disabled-link	{ pointer-events: none; }
        
        .imgcampain {
		  position: absolute; /* 이미지 위치 설정 */
		  top: 0; /* 원하는 위치로 조정 */
		  right: 0; /* 원하는 위치로 조정 */
		  z-index: 800; /* 다른 요소들보다 위에 오도록 설정 */
		}
    </style>
    <script src="/onnana/js/calendar.js?v=2"></script>
    <script src="/onnana/js/calcu.js" defer></script>
    
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> <!-- jQuery 라이브러리 -->    
	
	
	
	<script>


   
// <!-- ========================= insert 함수 form태그없이 함수로 제출버튼 구현 ======================== -->
	function insert(){
		
		var startDate = $('#startDate').val();
		var startTime = $('#startTime').val();
		var title = $('#title').val();				// insert에 들어가는 데이터 id로 불러와서 변수에 넣음
		var place = $('#place').val();
		var smoke = $('#smoke').val();
		
		
	    $.ajax({
	        type: "POST",
	        url: "/onnana/schedule/insert", // 스케줄 컨트롤러안의 함수 불러오는 경로
	        data: {startDate, startTime, title, place, smoke},
	        success: function(response){
	            // JSON 응답을 파싱
	        	var data = JSON.parse(response); 
				
	            //각 변수에 접근하여, 변경된 세션 다시 불러오기
	            
	            $('#asideSessId').text(data.countUser); //한 유저의 참여일수 합계
	            $('#asideSessCarbonId').text(data.countUserCarbon);//한 유저의 감소량 합계
	            
	            $('#asideSessAllId').text(data.count);//전체유저 인원수
	            $('#asidesessAllCarbonId').text(data.countCarbon); //전체유저의 감소량 합계

	            $('#addModal').modal('hide');
	            location.href = '/onnana/schedule/calendar';
	        }
	        });
	}
	

	// <!-- =================== update 함수 form태그없이 함수로 제출버튼 구현 =================== -->
	function update(){
		var startDate = $('#startDate2').val();
		var startTime = $('#startTime2').val();
		var title = $('#title2').val();				// update에 들어가는 데이터 id로 불러와서 변수에 넣음
		var place = $('#place2').val();
		var smoke = $('#smoke2').val();
		let sid = $('#sid2').val();

		console.log(place);
	    $.ajax({
	        type: "POST",
	        url: "/onnana/schedule/update", // 스케줄 컨트롤러안의 함수 불러오는 경로
	        data: {startDate, startTime, title, place, smoke, sid},
	        success: function(response){
	            // JSON 응답을 파싱
	        	var data = JSON.parse(response); 
				
	            //각 변수에 접근하여, 변경된 세션 다시 불러오기
	            
	            $('#asideSessId').text(data.countUser); //한 유저의 참여일수 합계
	            $('#asideSessCarbonId').text(data.countUserCarbon);//한 유저의 감소량 합계
	            
	            $('#asideSessAllId').text(data.count);//전체유저 인원수
	            $('#asidesessAllCarbonId').text(data.countCarbon); //전체유저의 감소량 합계

	            $('#addModal').modal('hide');
	            location.href = '/onnana/schedule/calendar';
	        }
	        });
	}
	


	</script>                       
	             
	                        
    
</head>
	<%@ include file="../common/top.jspf" %>
<body>
	
	<div class="container" style="margin-top: 80px;">
        <div class="d-flex">
        	<%@ include file="../common/aside.jspf" %>
        
        	<!-- ======================== main ======================== -->
			<div class="col-8 mt-3 ms-1">
            	<h3 style="color:green;"><strong>그린캠페인 캘린더</strong></h3>
            	<hr>
                <div class="d-flex justify-content-between">
                    <div>${today}</div>
                    <div style="margin-left:-100px">
                        <a href="/onnana/schedule/calendar/left2" style="color:green"><i class="fa-solid fa-angles-left"></i></a>
                        <a href="/onnana/schedule/calendar/left"style="color:green"><i class="fa-solid fa-angle-left ms-2"></i></a>
                        <span class="mx-2 ms-3 me-3" style="font-size:20px;">${year}.${month}</span>
                        <a href="/onnana/schedule/calendar/right"style="color:green"><i class="fa-solid fa-angle-right me-2"></i></a>
                        <a href="/onnana/schedule/calendar/right2"style="color:green"><i class="fa-solid fa-angles-right"></i></a>
                    </div>
                  
                  	 <div>
                  	 <!--  기념일 및 공휴일 추가 버튼 (사용안함으로 비활성화)
                    	<a href="#" onclick="addAnniversary()"><i class="fa-solid fa-pen me-2"></i></a>
                    	<%-- 관리자만이 공휴일/24절기 추가권한이 있음 --%>
        				<c:if test="${sessUid eq 'admin'}">
                    		<a href="#" onclick="addAnnivList()"><i class="fa-solid fa-calendar-plus"></i></a>
                    	</c:if>
                    	<c:if test="${sessUid ne 'admin'}">
       						<a href="#" class="disabled-link"><i class="fa-solid fa-calendar-plus"></i></a>
       					</c:if> -->
                    </div>
                </div>
                <table class="table table-bordered mt-2 mb-5">
                    <tr class="bg-warning  bg-opacity-10">
                        <th class="text-danger">일</th>
                        <th>월</th><th>화</th><th>수</th><th>목</th><th>금</th>
                        <th class="text-primary">토</th>
                    </tr>
                <c:forEach var="week" items="${calendar}">
                    <tr>
                    <c:forEach var="day" items="${week}">
                        <td style="height: ${height}px; ${todaySdate eq day.sdate ? 'background-color: #efffff;' : ''}" onclick="cellClick(${day.sdate})">
                            <div class="d-flex justify-content-between">
                           	<c:if test="${day.isOtherMonth eq 1}">
                               	<div class="${(day.date eq 0 or day.isHoliday eq 1) ? 'text-danger' : day.date eq 6 ? 'text-primary' : ''}" 
                               		 style="opacity: 0.5;"><strong>${day.day}</strong></div>
	                        	<div style="opacity: 0.5;">
		                        <c:forEach var="name" items="${day.annivList}" varStatus="loop">
		                        	${loop.first ? '' : '&middot;'} ${name}
	                        	</c:forEach>
	                        	</div>
                           	</c:if>
                           	<c:if test="${day.isOtherMonth eq 0}">
                               	<div class="${(day.date eq 0 or day.isHoliday eq 1) ? 'text-danger' : day.date eq 6 ? 'text-primary' : ''}">
                               		<strong>${day.day}</strong></div>
                               	<div>
		                        <c:forEach var="name" items="${day.annivList}" varStatus="loop">
		                        	${loop.first ? '' : '&middot;'} ${name}
	                        	</c:forEach>
	                        	</div>
                           	</c:if>
                            </div>
                        <c:forEach var="sched" items="${day.schedList}" varStatus="loop">
						    <div style="text-align: center; font-size: 13px; margin-top: ${loop.first ? '0' : '5px'}; font-size: 12px;" onclick="schedClick(${sched.sid})">
						        <!-- 글작성 시, 스탬프 찍기 -->
						        <div style="display: inline-block; float: right; margin-right: 2px;">
						            <!-- Stamp Image -->
									<img id="stampImage" height="30px" src="/onnana/img/stamp.png">
									<span style="display: none;">${sched.title}</span>
						        </div>
						    </div>
						</c:forEach>

                        </td>
                    </c:forEach>
                    </tr>
                </c:forEach>
                </table>
            </div>
			<!-- =================== main =================== -->
            
       
<!-- =================================== 상세페이지 ============================================================= -->
	<div class="col-4 ms-5 container border bg-warning p-2 text-dark bg-opacity-10" id="table-borderless" style="border-radius:.80rem!important; margin-top:60px; height:700px">
	<input type="hidden" name="sid" id="sid2">
		<table class="table table-borderless">
             <h4 style="color:green; margin-top:10px;"><i class="fa-solid fa-leaf"></i>&nbsp; 감소한 탄소배출량 상세보기</h4>
             <tr>
	             <td>
	                 <label for="startDate2">일 자</label>
	                 <input class="form-control" type="date" id="startDate2" name="startDate">
	             </td>
             </tr>
             <tr>
	             <td style="display: none;">
	                 <label for="startTime2">시작시간</label>
	                 <select class="form-control" name="startTime" id="startTime2">
	                 <c:forEach var="tl" items="${timeList}">
	                     <option value="${tl}" >${tl}</option>
	                 </c:forEach>
	                 </select>
	             </td>
             </tr>
<!-- ========================================================= 탄소계산기 start ========================================================= -->
          <tr>
             <td colspan="2">
             	<p id="demo" style="display: none;"></p> <!-- 현재 위치를 표시할 요소 -->
                 <label for="place">거리에 따른 배출 감소량 계산하기</label>
                 <div class="input-group outer-container" style="width: 100%;">
					<input type="text" style="height: auto;" class="form-control" id="place2" name="place" placeholder=" 도착지 주소를 입력하면 현재위치부터 계산합니다">
					<button class="btn btn-success"  id="calculateDistanceBtn2"  style="width: 80px;" onclick="searchAndCalculateDistance2()">계산</button>
					</div>
                    <p id="result2"></p>  <!-- 검색된 위치의 좌표와 거리를 표시할 요소 -->
             </td>
         </tr>  
         
<!-- ========================================================= 탄소계산기 end ======================================================== -->
          <tr>
             <td colspan="2">
                <label for="smoke">금연(개비) 배출 감소량</label>
				<select class="form-select form-control"  type="text" id="smoke2" name="smoke"">
				  <c:forEach var="i" begin="1" end="20">
				<option value="${i}" >${i}</option>
					</c:forEach>
				</select>
				 <p id="showResult2"  style="display: none;"></p>
				<p>※ 산출방식: 14g/개</p>
             </td>
         </tr>
          <tr>
             <td colspan="2">
                 <label for="title">합 산</label>
                 <div class="input-group outer-container" style="width: 100%;">
					<input class="form-control" type="text" id="title2" name="title" disabled>
					<button  class="btn btn-success" style="width: 80px;"  onclick="readJs2()"><i class="fa-solid fa-calculator"></i></button>
				</div>
              </td>
            </tr>   
                <tr>
                    <td colspan="2" style="text-align: right;">
		                 <button class="btn btn-success me-2" onclick="update()">수정</button>
		                 <button class="btn btn-danger me-2"  data-bs-dismiss="modal" onclick="deleteSchedule()">삭제</button>
						<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">종료</button>
                    </td>
                </tr>
             </table>
             <hr>
             
             
             <img style="margin-left:50px" src="/onnana/img/greencam.png" width="300px">
             
		</div>
	</div>
 </div>
    <%@ include file="../common/bottom.jspf" %>
    
    
    
<!---------------------------------------- Insert 프론트엔드  ------------------------------------------>
	<div class="modal" id="addModal">
		<div class="modal-dialog">
			<div class="modal-content">
				<!-- Modal Header -->
				<div class="modal-header">
					<h5 class="modal-title"><i class="fa-solid fa-leaf"></i>&nbsp; 오늘의 탄소감소량</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
				</div>
			
				<!-- Modal body -->
				<div class="modal-body">
				
						<table class="table table-borderless">
	                       
	                        
	                        <tr>
	                            <td>
	                                <label for="startDate">일 자</label>
	                                <input class="form-control" type="date" id="startDate" name="startDate">
	                            </td>
	                            <td style="display: none;">
	                                <label for="startTime" >시작 시간</label>
	                                <select class="form-control" name="startTime" id="startTime">
	                                <c:forEach var="tl" items="${timeList}">
	                                    <option value="${tl}">${tl}</option>
	                                </c:forEach>
	                                </select>
	                            </td>
	                        </tr>
<!-- ========================================================= 탄소계산기 start ========================================================= -->
	                         <tr>
	                            <td colspan="2">
	                            	<p id="demo" style="display: none;"></p> <!-- 현재 위치를 표시할 요소 -->
	                                <label for="place">거리에 따른 배출 감소량 계산하기</label>
	                                <div class="input-group outer-container" style="width: 100%;">
									    <input type="text" style="height: auto;" class="form-control" id="place" name="place" placeholder=" 도착지 주소를 입력하면 현재위치부터 계산합니다">
									    <button id="calculateDistanceBtn"  class="btn btn-success" style="width: 80px;" onclick="searchAndCalculateDistance()">계산</button>
									</div>
		                              <p id="result"></p>  <!-- 검색된 위치의 좌표와 거리를 표시할 요소 -->
	                            </td>
	                        </tr>    
<!-- ========================================================= 탄소계산기 end ======================================================== -->
	                        <tr>
	                            <td colspan="2">
                                <label for="smoke">흡연(개비) 배출량</label>
									    <select class="form-select form-control"  type="text" id="smoke" name="smoke">
										     <c:forEach var="i" begin="1" end="20">
										      <option value="${i}" >${i}</option>
									      		</c:forEach>
									    </select>
									     <p id="showResult"  style="display: none;"></p>
									    <p>※ 산출방식: 14g/개 (※감소량에서 차감됩니다.)</p>
	                            </td>
	                        </tr>
	                         <tr>
	                            <td colspan="2">
	                                <label for="title">합 산</label>
	                                <div class="input-group outer-container" style="width: 100%;">
									    <input class="form-control" type="text" id="title" name="title" disabled>
									    <button class="btn btn-success" style="width: 80px;" onclick="readJs()"><i class="fa-solid fa-calculator"></i></button>
									</div>
	                            </td>
	                        </tr>   
	                        
	                        
	                        <tr>
	                            <td colspan="2" style="text-align: right;">
	                                <button class="btn btn-primary me-2" onclick="insert()">제출</button>
	                                <!-- <button class="btn btn-secondary" type="reset">취소</button> -->
	                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">종료</button>
	                            </td>
	                        </tr>
	                        
	                    </table>
				</div>
			</div>
		</div>
	</div>
	
	
	
</body>
</html>