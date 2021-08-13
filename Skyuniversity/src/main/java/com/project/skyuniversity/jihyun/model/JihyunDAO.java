package com.project.skyuniversity.jihyun.model;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class JihyunDAO implements InterJihyunDAO {

	@Resource
	private SqlSessionTemplate sqlsession;
	
	// 로그인
	public JihyunMemberVO getLoginMember(Map<String, String> paraMap) {
		JihyunMemberVO getLoginMember = sqlsession.selectOne("Jihyun.getLoginMember", paraMap);
		return getLoginMember;
	}

	// 비밀번호 변경
	public int updatePwd(Map<String, String> paraMap) {
		int n = sqlsession.update("Jihyun.updatePwd", paraMap);
		return n;
	}

	// 비밀번호 확인
	@Override
	public boolean checkPwd(Map<String, String> paraMap) {
		boolean isEqualPwd = false;
		int checkPwd = sqlsession.selectOne("Jihyun.checkPwd", paraMap);
		System.out.println("checkPwd :" +checkPwd);
		if (checkPwd == 1) {
			isEqualPwd = true;
		}
		return isEqualPwd;
	}

	// 증명서 종류 리스트 가져오기
	@Override
	public List<Map<String, String>> getCertificateKindList() {
		List<Map<String,String>> certificateKindList = sqlsession.selectList("Jihyun.getCertificateKindList");
		return certificateKindList;
	}

	// 증명서 신청 내역 가져오기
	@Override
	public List<Map<String, String>> getApplicationList(String memberNo) {
		List<Map<String, String>> ApplicationList = sqlsession.selectList("Jihyun.getApplicationList", memberNo);
		return ApplicationList;
	}

	// 공지사항 가져오기 // 전체
	@Override
	public List<Map<String, String>> getNoticeList() {
		List<Map<String, String>> noticeList = sqlsession.selectList("Jihyun.getNoticeList");
		return noticeList;
	}
	// 과별
	@Override
	public List<Map<String, String>> getDeptNoticeList() {
		List<Map<String, String>> deptNoticeList = sqlsession.selectList("Jihyun.getdeptNoticeList");
		return deptNoticeList;
	}
	// 과목별
	@Override
	public List<Map<String, String>> getSubjectNoticeList() {
		List<Map<String, String>> subjectNoticeList = sqlsession.selectList("Jihyun.getsubjectNoticeList");
		return subjectNoticeList;
	}

	// 학번으로 로그인유저 불러오기
	@Override
	public JihyunMemberVO getLoginuserFromCommu(String memberNo) {
		JihyunMemberVO loginuser = sqlsession.selectOne("Jihyun.getLoginuserFromCommu", memberNo);
		return loginuser;
	}

	// 증명서 신청 내역 추가
	@Override
	public int addCertificateApplication(List<Map<String, String>> caList) {
		
		int length = caList.size();

		int result = 0;
		
		if(length<=1) {
			HashMap<String, String> paramap = (HashMap<String, String>) caList.get(0);
			result = sqlsession.insert("Jihyun.addCertificateApplicationOne", paramap);
		}
		else {
			result = sqlsession.insert("Jihyun.addCertificateApplicationAll", caList);
		}
		
		
		return result;
	}

	// 공지사항 내용 가져오기
	@Override
	public Map<String, String> getNoticeDetail(Map<String, String> paraMap) {
		
		Map<String, String> noticeDetail = null;
		
		String status = paraMap.get("status");
		System.out.println(status);
		
		switch (status) {
		case "0":
			noticeDetail =  sqlsession.selectOne("Jihyun.getNoticeDetail0", paraMap); 
			break;

		case "1":
			noticeDetail =  sqlsession.selectOne("Jihyun.getNoticeDetail1", paraMap); 
			break;
		
		case "2":
			noticeDetail =  sqlsession.selectOne("Jihyun.getNoticeDetail2", paraMap); 
			break;
		}
		
		 
		return noticeDetail;
	}

	// 이번학기 수강 과목 목록 가져오기
	@Override
	public List<Map<String, String>> getLectureList(String memberNo) {
		//List<Map<String, String>> lectureList = sqlsession.selectList("Jihyun.getLectureList", memberNo);
		
		List<Map<String, String>> totalLecture = new ArrayList<Map<String,String>>();
		List<Map<String, String>> lectureList = null;
		
		//전필
		lectureList = sqlsession.selectList("Jihyun.getThisJunpil", memberNo); 
		if(lectureList.size()>0) {
			for(Map<String,String> map : lectureList) {
				map.put("lectureKind", "전공필수");
				totalLecture.add(map);
			}
		}
		
		// 전선
		lectureList = sqlsession.selectList("Jihyun.getThisJunsun", memberNo);
		if(lectureList.size()>0) {
			for(Map<String,String> map : lectureList) {
				map.put("lectureKind", "전공선택");
				totalLecture.add(map);
			}
		}
		
		// 교필
		lectureList = sqlsession.selectList("Jihyun.getThisGyopil", memberNo); 
		if(lectureList.size()>0) {
			for(Map<String,String> map : lectureList) {
				map.put("lectureKind", "교양필수");
				totalLecture.add(map);
			}
		}
		
		//교선
		lectureList = sqlsession.selectList("Jihyun.getThisGyosun", memberNo); 
		if(lectureList.size()>0) {
			for(Map<String,String> map : lectureList) {
				map.put("lectureKind", "교양선택");
				totalLecture.add(map);
			}
		}
		
		//일선
		lectureList = sqlsession.selectList("Jihyun.getThisIlsun", memberNo); 
		if(lectureList.size()>0) {
			for(Map<String,String> map : lectureList) {
				map.put("lectureKind", "일반선택");
				totalLecture.add(map);
			}
		}
		
		lectureList = null;
		
		return totalLecture;
	}

	// 학생 기본정보 업데이트
	@Override
	public int sInfoUpdate(Map<String, String> paraMap) {
		int n = sqlsession.update("Jihyun.sInfoUpdate", paraMap);
		return n;
	}

	// 학생 주소 업데이트
	@Override
	public int sAddressUpdate(Map<String, String> paraMap) {
		int n = sqlsession.update("Jihyun.sAddressUpdate", paraMap);
		return n;
	}

	// 학교 전체 일정 가져오기
	@Override
	public List<Map<String, String>> getsScheduleList() {
		List<Map<String, String>> sScheduleList = sqlsession.selectList("Jihyun.getsScheduleList");
		return sScheduleList;
	}

	// 기이수 성적 가져오기
	@Override
	public Map<String, List<Map<String, String>>> getTotalGradeMap(String memberNo) {
		
		Map<String, List<Map<String,String>>> totalGradeMap = new HashMap<String, List<Map<String,String>>>();
		List<Map<String, String>> eachGradeList = new ArrayList<Map<String,String>>();
		List<Map<String, String>> totalGradeInfoList = new ArrayList<Map<String,String>>();
		Map<String, String> gradeInfo = null;
		
		eachGradeList = sqlsession.selectList("Jihyun.getEachGradeList", memberNo);
		
		if(eachGradeList.size() > 0) {
//			총성적(신청학점, 취득학점, 총점수, 평균학점) 얻기
			gradeInfo = new HashMap<String, String>();
			
			Map<String, Double> scoreMap = new HashMap<>();
			scoreMap.put("A+", 4.3);
			scoreMap.put("A", 4.0);
			scoreMap.put("A-", 3.7);
			scoreMap.put("B+", 3.3);
			scoreMap.put("B", 3.0);
			scoreMap.put("B-", 2.7);
			scoreMap.put("C+", 2.3);
			scoreMap.put("C", 2.0);
			scoreMap.put("C-", 1.7);
			scoreMap.put("D+", 1.3);
			scoreMap.put("D", 1.0);
			scoreMap.put("D-", 0.7);
			scoreMap.put("F", 0.0);
			
			int applicateCredits = 0;
			int completeCredits = 0;
			double totalScore = 0;
			double averageScore = 0;
			
			for(Map<String,String> map : eachGradeList) {
				applicateCredits += Integer.parseInt(map.get("credits"));
				if(!"F".equalsIgnoreCase(map.get("score"))&&map.get("score") != null){
					completeCredits += Integer.parseInt(map.get("credits"));
				}
				for(String key : scoreMap.keySet()) {
					if(key.equalsIgnoreCase(map.get("score"))) {
						totalScore += (scoreMap.get(key)*Integer.parseInt(map.get("credits")));
					}
				}
			}
			
			totalScore = Math.round(totalScore*100)/100.0;
			averageScore = Math.round(totalScore/completeCredits*100)/100.0;
			
			gradeInfo.put("applicateCredits", Integer.toString(applicateCredits));
			gradeInfo.put("completeCredits", Integer.toString(completeCredits));
			gradeInfo.put("totalScore", String.valueOf(totalScore));
			gradeInfo.put("averageScore", String.valueOf(averageScore));

			totalGradeInfoList.add(gradeInfo);
			
//			학기별 평점내역(학기,이수학점, 평점평균, 최초평점평균, 학사경고) 얻기
			List<Map<String, String>> semesterGradeList = new ArrayList<Map<String,String>>();
			semesterGradeList = sqlsession.selectList("Jihyun.semesterGradeList", memberNo);
			
			totalGradeMap.put("totalGradeInfoList", totalGradeInfoList);
			totalGradeMap.put("semesterGradeList", semesterGradeList);
		}
		
		totalGradeMap.put("eachGradeList", eachGradeList);
		
		return totalGradeMap;
	}

// 	당학기 성적조회
	@Override
	public List<Map<String, String>> getThisSemesterGrade(String memberNo) {
		List<Map<String, String>> thisSemesterGrade = sqlsession.selectList("Jihyun.getThisSemesterGrade", memberNo);
		return thisSemesterGrade;
	}

}
