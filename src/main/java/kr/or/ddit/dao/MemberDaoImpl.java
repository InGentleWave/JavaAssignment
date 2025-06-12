package kr.or.ddit.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.vo.MemberVO;
import util.MyBatisUtil;

public class MemberDaoImpl implements IMemberDao {
	private static IMemberDao dao;
	private MemberDaoImpl() {}
	public static IMemberDao getInstance() {
		if(dao==null) dao = new MemberDaoImpl();
		return dao;
	}
	@Override
	public List<MemberVO> getListAll() {
		SqlSession session = null;
		List<MemberVO> list =null;
		try {
			session = MyBatisUtil.getSqlSession();
			list = session.selectList("member.getListAll");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return list;
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
