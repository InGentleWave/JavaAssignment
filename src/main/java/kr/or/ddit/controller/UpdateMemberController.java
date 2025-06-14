package kr.or.ddit.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

import com.google.gson.Gson;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.service.IMemberService;
import kr.or.ddit.service.MemberServiceImpl;
import kr.or.ddit.vo.MemberVO;
import util.GsonUtil;

@WebServlet("/update.do")
public class UpdateMemberController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private IMemberService service = null;

	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		resp.setCharacterEncoding("utf-8");

		String memId = req.getParameter("memId");

		service = MemberServiceImpl.getInstance();
		MemberVO mv = service.getMemberDetail(memId);
		req.setAttribute("data", mv);

		req.getRequestDispatcher("/WEB-INF/views/memberDetail.jsp").forward(req, resp);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		resp.setCharacterEncoding("utf-8");

		String memId = req.getParameter("memId");
		String memPass = req.getParameter("memPass");
		String memName = req.getParameter("memName");
		String memTel = req.getParameter("memTel");
		String memAddr = req.getParameter("memAddr");
//		String memPhoto = req.getParameter("memPhoto");

		MemberVO mv = new MemberVO();
		mv.setMemId(memId);
		mv.setMemPass(memPass);
		mv.setMemName(memName);
		mv.setMemTel(memTel);
		mv.setMemAddr(memAddr);
//		mv.setMemPhoto(memPhoto);

		int cnt = service.updateMember(mv);
		// insert 성공 시 회원 목록 화면 출력
		if (cnt > 0) {
			resp.sendRedirect(req.getContextPath() + "/update.do?memId="+memId);
		} else {
			req.setAttribute("data", mv);

			req.setAttribute("msg", "회원 정보 수정에 실패했습니다.");
			req.getRequestDispatcher("/WEB-INF/views/memberDetail.jsp").forward(req, resp);
		}

	}

}
