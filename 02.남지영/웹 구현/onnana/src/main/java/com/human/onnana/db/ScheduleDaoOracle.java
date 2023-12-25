
package com.human.onnana.db;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.human.onnana.entity.Schedule;

@Mapper
public interface ScheduleDaoOracle {

	@Select("SELECT * FROM schedule"
			+ "  WHERE \"uid\"=#{uid} and sdate >= #{startDate} and sdate <= #{endDate}"
			+ "  ORDER BY startTime")
	List<Schedule> getSchedList(String uid, String startDate, String endDate);
	
	@Insert("INSERT INTO schedule VALUES (DEFAULT, #{uid}, #{sdate}, #{startTime}, #{title}, #{title2}, #{place},"
			+ " #{startplace}, #{endplace}, #{smoke}, #{smoke2}, #{waypoint1},#{waypoint2},#{waypoint3})")
	void insert(Schedule schedule);
	
	@Select("select * from schedule where sid=#{sid}")
	Schedule getSchedule(int sid);
	
	@Update("update schedule set \"uid\"=#{uid}, sdate=#{sdate}, startTime=#{startTime}, title=#{title}, title2=#{title2},"
			+ " place=#{place}, startplace=#{startplace}, endplace=#{endplace}, smoke=#{smoke}, smoke2=#{smoke2},"
			+ " waypoint1=#{waypoint1}, waypoint2=#{waypoint2}, waypoint3=#{waypoint3}  where sid=#{sid}")
	void update(Schedule schedule);
	
	@Delete("delete from schedule where sid=#{sid}")
	void delete(int sid);
	
	@Select("SELECT * FROM schedule"
			+ "  WHERE  \"uid\"=#{uid} and sdate >= #{startDate}"
			+ "  ORDER BY startTime LIMIT 15 OFFSET #{offset}")
	List<Schedule> getSchedListByPage(String uid, String startDate, int offset);
	
	@Select("SELECT COUNT(sid) FROM schedule"
			+ "  WHERE \"uid\"=#{uid} and sdate >= #{startDate}"
			+ "  ORDER BY startTime")
	int getSchedCount(String uid, String startDate);

	// 참여한 전체 유저 인원 카운트
	@Select("select count(*) from users")
	int count();
	
	// 한 유저 캘린더 작성 카운트
	@Select("SELECT COUNT(*)FROM schedule WHERE \"uid\" = #{uid}")
	int userCount(String uid);
	
	// 유저 전체 탄소 감소량 합계
	@Select("SELECT COALESCE(SUM(TO_NUMBER(REGEXP_SUBSTR(title, '\\d+(\\.\\d+)?'))), 0) + COALESCE(SUM(TO_NUMBER(REGEXP_SUBSTR(title2, '\\d+(\\.\\d+)?'))), 0) AS total_sum FROM schedule")
	Double carbonCount();
	
	// 한 유저 탄소감소량 합계
	@Select("SELECT  COALESCE(SUM(TO_NUMBER(REGEXP_SUBSTR(title, '\\d+(\\.\\d+)?'))), 0) + COALESCE(SUM(TO_NUMBER(REGEXP_SUBSTR(title2, '\\d+(\\.\\d+)?'))), 0) AS total_sum FROM schedule where \"uid\"= #{uid}")
	Double carbonUserCount(String uid);
	
	
	@Select("SELECT COALESCE(SUM(TO_NUMBER(REGEXP_SUBSTR(title, '\\d+(\\.\\d+)?'))), 0) + COALESCE(SUM(TO_NUMBER(REGEXP_SUBSTR(title2, '\\d+(\\.\\d+)?'))), 0) AS total_sum FROM schedule WHERE sid = #{sid}")
	double getUserCarbonReductionTotal(int sid);
	
	
	private int convertToNumber(String uid) {
	    try {
	        return Integer.parseInt(uid);
	    } catch (NumberFormatException e) {
	        // 숫자로 변환할 수 없는 경우 0을 반환하거나 예외 처리
	        return 0;
	    }
	}
	
	
	
	@Select("SELECT COUNT(*) FROM schedule WHERE \"uid\"=#{uid}")
	int getUserSchedCount(String uid);
	
	// 한유저의 특정일자 탄소감소량 합계
	@Select("SELECT  COALESCE(SUM(TO_NUMBER(REGEXP_SUBSTR(title, '\\d+(\\.\\d+)?'))), 0) + COALESCE(SUM(TO_NUMBER(REGEXP_SUBSTR(title2, '\\d+(\\.\\d+)?'))), 0) AS total_sum FROM schedule where \"uid\"= #{uid}  and sdate =  #{sdate}")
	double UserdaycarbonSum(String uid, String sdate);
	
	
	// 한유저의 특정일자 탄소감소량 합계
	@Select("SELECT  COALESCE(SUM(TO_NUMBER(REGEXP_SUBSTR(title, '\\d+(\\.\\d+)?'))), 0) + COALESCE(SUM(TO_NUMBER(REGEXP_SUBSTR(title2, '\\d+(\\.\\d+)?'))), 0) AS total_sum FROM schedule where sdate =  #{sdate}")
	double UserAlldaycarbonSum(String sdate);
	
	
}
