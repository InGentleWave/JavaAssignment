package kr.or.ddit.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.List;

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

@WebServlet("/delete.do")
public class DeleteMemberController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private IMemberService service = null;

	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		resp.setCharacterEncoding("utf-8");
		service = MemberServiceImpl.getInstance();
		String memId=req.getParameter("memId");
		int cnt = service.deleteMember(memId);
		if(cnt>0) {
			String msg = URLEncoder.encode("삭제 성공했습니다.","UTF-8");
			req.getSession().setAttribute("msg", msg);
			resp.sendRedirect(req.getContextPath()+"/list.do");
		}
	}

}
