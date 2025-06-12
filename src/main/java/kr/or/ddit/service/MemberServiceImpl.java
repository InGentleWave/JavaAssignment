package kr.or.ddit.service;

import java.util.List;

import kr.or.ddit.dao.IMemberDao;
import kr.or.ddit.dao.MemberDaoImpl;
import kr.or.ddit.vo.MemberVO;

public class MemberServiceImpl implements IMemberService {
	private IMemberDao dao;
	private static IMemberService service;
	private MemberServiceImpl() {
		dao = MemberDaoImpl.getInstance();
	}
	public static IMemberService getInstance() {
		if(service==null) service = new MemberServiceImpl();
		return service;
	}
	@Override
	public List<MemberVO> getListAll() {
		return dao.getListAll();
	}

	@Override
	public int insertMember(MemberVO mv) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public MemberVO getMemberDetail(String memId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int updateMember(MemberVO mv) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteMember(String memId) {
		// TODO Auto-generated method stub
		return 0;
	}

}
