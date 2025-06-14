package kr.or.ddit.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.vo.MemberVO;
import util.MyBatisUtil;

public class MemberDaoImpl implements IMemberDao {
	private static IMemberDao dao;

	private MemberDaoImpl() {
	}

	public static IMemberDao getInstance() {
		if (dao == null)
			dao = new MemberDaoImpl();
		return dao;
	}

	@Override
	public List<MemberVO> getListAll() {
		SqlSession session = null;
		List<MemberVO> list = null;
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
		SqlSession session = null;
		int cnt = 0;
		try {
			session = MyBatisUtil.getSqlSession();
			cnt = session.insert("member.insertMember", mv);
			if(cnt>0) session.commit();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return cnt;
	}

	@Override
	public MemberVO getMemberDetail(String memId) {
		SqlSession session = null;
		MemberVO mv = new MemberVO();
		try {
			session = MyBatisUtil.getSqlSession();
			mv = session.selectOne("member.getMemberDetail", memId);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return mv;
	}

	@Override
	public int updateMember(MemberVO mv) {
		SqlSession session = null;
		int cnt = 0;
		try {
			session = MyBatisUtil.getSqlSession();
			cnt = session.update("member.updateMember", mv);
			if(cnt>0) session.commit();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return cnt;
	}

	@Override
	public int deleteMember(String memId) {
		SqlSession session = null;
		int cnt = 0;
		try {
			session = MyBatisUtil.getSqlSession();
			cnt = session.update("member.deleteMember", memId);
			if(cnt>0) session.commit();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return cnt;
	}

	@Override
	public int isIdAvailable(String memId) {
		SqlSession session = null;
		int cnt = 0;
		try {
			session = MyBatisUtil.getSqlSession();
			cnt = session.selectOne("member.isIdAvailable", memId);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return cnt;
	}

}
