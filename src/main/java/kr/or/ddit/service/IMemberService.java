package kr.or.ddit.service;

import java.util.List;

import kr.or.ddit.vo.MemberVO;

public interface IMemberService {
	public List<MemberVO> getListAll();
	public int insertMember(MemberVO mv);
	public MemberVO getMemberDetail(String memId);
	public int updateMember(MemberVO mv);
	public int deleteMember(String memId);
	public int isIdAvailable(String memId);
}
