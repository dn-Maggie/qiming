package com.dongnao.workbench.common.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.dongnao.workbench.account.service.ExpenseAccountService;
import com.dongnao.workbench.account.service.OrderInfoService;
import com.dongnao.workbench.accountflow.model.AccountFlow;
import com.dongnao.workbench.accountflow.service.AccountFlowService;
import com.dongnao.workbench.basic.model.Org;
import com.dongnao.workbench.basic.model.UserInfo;
import com.dongnao.workbench.basic.service.OrgService;
import com.dongnao.workbench.basic.service.UserInfoService;
import com.dongnao.workbench.common.Constant;
import com.dongnao.workbench.common.bean.ResultMessage;
import com.dongnao.workbench.common.bean.ResultMoney;
import com.dongnao.workbench.common.util.AjaxUtils;
import com.dongnao.workbench.common.util.DateUtil;
import com.dongnao.workbench.common.util.MD5Encryption;
import com.dongnao.workbench.common.util.StringUtil;
import com.dongnao.workbench.common.util.Utils;
import com.dongnao.workbench.common.util.ValidateCodeServlet;
import com.dongnao.workbench.continuePay.service.ContinuePayService;
import com.dongnao.workbench.marketStudent.service.MarketStudentService;
import com.dongnao.workbench.school.model.EmpNotice;
import com.dongnao.workbench.school.model.Employee;
import com.dongnao.workbench.school.service.EmpNoticeService;
import com.dongnao.workbench.school.service.EmpPerformanceService;
import com.dongnao.workbench.school.service.EmployeeService;
import com.dongnao.workbench.school.service.LeaveApplyService;
import com.dongnao.workbench.subject.model.Subject;
import com.dongnao.workbench.subject.service.SubjectService;
import com.dongnao.workbench.system.model.Module;
import com.dongnao.workbench.system.model.Role;
import com.dongnao.workbench.system.service.ModuleService;
import com.dongnao.workbench.system.service.RoleService;
import com.dongnao.workbench.vipStudent.model.VipStudent;
import com.dongnao.workbench.vipStudent.service.VipStudentService;


/**
 * 描述：首页模块controller类，负责页面分发与跳转
 * 
 * @author zhou.zheng
 * @version 1.0 2016-03-06
 */

@Controller
@RequestMapping("/")
public class MainController {

	private UserInfoService userInfoService;
	@Resource
	private VipStudentService vipStudentService;
	@Resource
	private AccountFlowService accountFlowService;
	@Resource
    private ContinuePayService continuePayService;
	@Resource
	private MarketStudentService marketStudentService;
	@Resource
	private EmployeeService employeeService;
	@Resource
	private OrderInfoService orderInfoService;
	@Resource
	private ExpenseAccountService expenseAccountService;
	@Resource
	private EmpPerformanceService empPerformanceService;
	@Resource
	private LeaveApplyService leaveApplyService;
	@Resource
	private EmpNoticeService empNoticeService;
	@Resource
	private OrgService orgService;
	@Resource
	private SubjectService subjectService;
	@Resource
	private RoleService roleService;
	/**
	 * 设置service
	 * 
	 * @param userInfoService
	 *            UserService
	 */
	@Autowired
	public void setUserInfoService(UserInfoService userInfoService) {
		this.userInfoService = userInfoService;
	}

	private ModuleService moduleService;

	/**
	 * 设置service
	 * 
	 * @param moduleService
	 *            ModuleService
	 */
	@Autowired
	public void setModuleService(ModuleService moduleService) {
		this.moduleService = moduleService;
	}

	/**
	 * 进入首页页面
	 * 
	 * @param request
	 *            HttpServletRequest
	 * @return ModelAndView 返回到首页页面
	 */
	@RequestMapping("/index")
	public ModelAndView toMain(HttpServletRequest request) {
		UserInfo user = Utils.getLoginUserInfo(request);
		user.setLastLoginIp((String)Utils.getRemortIP(request));
		userInfoService.updateLastLoginInfo(user);
		List<Module> menus = null;
		ModelAndView m = null;
		Map<String, Object> map = null;
		if (Utils.isSuperAdmin(request)){//超管
			menus = moduleService.getMenuListForAdmin();
			m = new ModelAndView("WEB-INF/jsp/common/adminMain");
			map = m.getModel();
			map.put("menus", menus);
		} else if(user.getDutyId().equals("b8d29f69-9c38-4417-bd58-cc0e369c42b8")){//外部服务部门
			menus = moduleService.getMenuListByPcode(Utils.getLoginUserInfo(request).getId());
			m = new ModelAndView("WEB-INF/jsp/common/allStudent");
			map = m.getModel();
			if(user.getRoleId().equals("dc3dfb2e-5e70-4525-9739-beef0856f15c")){//外部服务部门管理员
				map.put("isAdmin", true);
			}
			map.put("menus", menus);
		}
		else {//普通用户
			menus = moduleService.getMenuListByPcode(Utils.getLoginUserInfo(request).getId());
			m = new ModelAndView("WEB-INF/jsp/common/userMain");
			map = m.getModel();
			map.put("menus", menus);
			Employee entity = employeeService.getByPrimaryKey(Utils.getLoginUserInfo(request).getId());
			m.addObject("employee",entity);
		}
		return m;
	}
	
	/**
	 * 进入首页页面
	 * 
	 * @param request
	 *            HttpServletRequest
	 * @return ModelAndView 返回到首页页面
	 */
	@RequestMapping("/adminHomePage")
	public ModelAndView adminHomePage(HttpServletRequest request) {
		ModelAndView mv = null;
		Map<String,Object> model = new HashMap<String,Object>();
		Calendar curr = Calendar.getInstance();
		Calendar before = Calendar.getInstance();
		before.add(Calendar.MONTH, -1);
		
		UserInfo user = Utils.getLoginUserInfo(request);
		
		Org org = new Org();
		if (Utils.isSuperAdmin(request)||user.getRoleId().equals("")){
			mv = new ModelAndView("WEB-INF/jsp/common/adminHomePage");
		}else {
			mv = new ModelAndView("WEB-INF/jsp/common/userMessage");
			mv.addObject("user",user);
			Employee entity = employeeService.getByPrimaryKey(Utils.getLoginUserInfo(request).getId());
			mv.addObject("employee",entity);
			
			Subject sub = new Subject();
			org.setOrgName(entity.getDept());
			sub.setName(orgService.listByCondition(org).get(0).getPinyin());
			boolean isHavePerformance = false;
			if(subjectService.listByCondition(sub).size()>0){
				isHavePerformance=true;
			}
			mv.addObject("isHavePerformance",isHavePerformance);//添加是否有业绩指标标识(区分有业绩指标的部门和无业绩指标的部门)
			
			Subject subject = new Subject();
			List<Subject> listsub = subjectService.listByCondition(sub);
			if(listsub.size()>0){
				subject = listsub.get(0);//查询部门业绩目标
			}else{			
				subject.setPerfTarget(0);
			}
			model.put("subject", subject);
			
			Role role = new Role();
			role.setRoleId(user.getRoleId());
			boolean ViewPerformance=false;
			if(roleService.listByCondition(role).get(0).getHpvp()==1){
				ViewPerformance=true;
			};
			mv.addObject("ViewPerformance",ViewPerformance);//添加是否有权限查看公司总业绩等信息标识
		}		
		
		int perfTarget = subjectService.queryPerfTarget();//查询这个月的总业绩目标
		model.put("perfTarget", perfTarget);

		VipStudent vipStudent = new VipStudent();
		model.put("all", vipStudentService.getStatistical(null));
		model.put("today", vipStudentService.getStatisticaltoday(curr.get(Calendar.YEAR)+""+(curr.get(Calendar.MONTH)+1)+""+curr.get(Calendar.DATE)));
		vipStudent.setJointime(curr.get(Calendar.YEAR)+""+(curr.get(Calendar.MONTH)+1));
		model.put("currMonth", vipStudentService.getStatistical(vipStudent));
		vipStudent.setJointime(curr.get(Calendar.YEAR)+"");
		model.put("currYear", vipStudentService.getStatistical(vipStudent));
		vipStudent.setJointime(StringUtil.formatDateyyyyMM(before.getTime()));
		model.put("beforeMonth", vipStudentService.getStatistical(vipStudent));
		vipStudent.setJointime((curr.get(Calendar.YEAR)-1)+"");
		model.put("beforeYear", vipStudentService.getStatistical(vipStudent));
		
		
		model.put("allMarkStu", marketStudentService.getMarkStuCount(""));
		model.put("currMonthMarkStu", marketStudentService.getMarkStuCount(StringUtil.formatDateyyyyMMdd(curr.getTime()).replaceAll("-", "")));		
		model.put("currYearMarkStu", marketStudentService.getMarkStuCount(curr.get(Calendar.YEAR)+""));
		model.put("beforeMonthMarkStu", marketStudentService.getMarkStuCount(StringUtil.formatDateyyyyMMdd(before.getTime()).replaceAll("-", "")));		
		model.put("beforeYearMarkStu", marketStudentService.getMarkStuCount((curr.get(Calendar.YEAR)-1)+""));
		
		AccountFlow accountEnt = new AccountFlow();
		model.put("allMoney",accountFlowService.getCountMoney(accountEnt));
		accountEnt.setStartDate(curr.get(Calendar.YEAR)+"");
		model.put("currYearMoney", accountFlowService.getCountMoney(accountEnt));
		accountEnt.setStartDate(curr.get(Calendar.YEAR)+"-"+(curr.get(Calendar.MONTH)+1)+"-01");
		model.put("currMonthMoney", accountFlowService.getCountMoney(accountEnt));
		accountEnt.setStartDate(curr.get(Calendar.YEAR)-1+"");
		model.put("beforeYearMoney", accountFlowService.getCountMoney(accountEnt));
		accountEnt.setStartDate(StringUtil.formatDateyyyyMMdd(before.getTime()));
		model.put("beforeMonthMoney", accountFlowService.getCountMoney(accountEnt));
		
		AccountFlow accountxf = new AccountFlow();
		model.put("allxf",accountFlowService.getXFMoney(null));
		accountxf.setCreateTime(curr.get(Calendar.YEAR)+""+(curr.get(Calendar.MONTH)+1));
		model.put("currMonthxf", accountFlowService.getXFMoney(accountxf));
		accountxf.setCreateTime(curr.get(Calendar.YEAR)+"");
		model.put("currYearxf", accountFlowService.getXFMoney(accountxf));
		accountxf.setCreateTime(StringUtil.formatDateyyyyMM(before.getTime()));
		model.put("beforeMonthxf", accountFlowService.getXFMoney(accountxf));
		accountxf.setCreateTime((curr.get(Calendar.YEAR)-1)+"");
		model.put("beforeYearxf", accountFlowService.getXFMoney(accountxf));
		mv.addObject("model", model);		
		
		model.put("myExpense", expenseAccountService.getMyExpense(user.getId(),curr.get(Calendar.YEAR)+"-"+(curr.get(Calendar.MONTH)+1)+"-01"));
		model.put("myMessage", employeeService.getMyMessage(user.getId()));
		model.put("myPerformance", empPerformanceService.getMyPerformance(user.getId(),curr.get(Calendar.YEAR)+"-"+(curr.get(Calendar.MONTH)+1)+"-01"));
		accountxf.setCreateTime(curr.get(Calendar.YEAR)+""+(curr.get(Calendar.MONTH)+1));
		accountxf.setSubjectName(orgService.listByCondition(org).size()>0?orgService.listByCondition(org).get(0).getPinyin():"");
		model.put("deptPerformance", accountFlowService.getBarStatistic(accountxf));
		//消息中心
 		mv.addObject("noticeList", empNoticeService.listByCondition(new EmpNotice()));
		
		List<Subject> sublist = subjectService.listByCondition(new Subject());
		for(int i=0;i<sublist.size();i++){
			String deptname = sublist.get(i).getName();
			accountxf.setSubjectName(deptname);
			model.put(deptname, accountFlowService.getBarStatistic(accountxf));
		}
 		return mv;
	}

	
	/**
	 * 进入用户首页页面
	 * 
	 * @param request
	 *            HttpServletRequest
	 * @return ModelAndView 返回到首页页面
	 */
	@RequestMapping("/userHomePage")
	public ModelAndView userHomePage(HttpServletRequest request) {
		ModelAndView mv = new ModelAndView("WEB-INF/jsp/common/userMessage");
		Map<String,Object> model = new HashMap<String,Object>();
		Calendar calendar = Calendar.getInstance();
		Calendar before = Calendar.getInstance();
		before.add(Calendar.MONTH, -1);
		
		UserInfo user = Utils.getLoginUserInfo(request);
		mv.addObject("user",user);
		Employee entity = employeeService.getByPrimaryKey(Utils.getLoginUserInfo(request).getId());
		mv.addObject("employee",entity);
		
		Org org = new Org();
		Subject sub = new Subject();
		org.setOrgName(entity!=null?entity.getDept():"");
		sub.setName(orgService.listByCondition(org).get(0).getPinyin());
		boolean isHavePerformance = false;
		if(subjectService.listByCondition(sub).size()>0){
			isHavePerformance=true;
		}
		mv.addObject("isHavePerformance",isHavePerformance);//添加是否有业绩指标标识(区分有业绩指标的部门和无业绩指标的部门)
		
		Role role = new Role();
		role.setRoleId(user.getRoleId());
		boolean ViewPerformance=false;
		if(roleService.listByCondition(role).get(0).getHpvp()==1){
			ViewPerformance=true;
		};
		mv.addObject("ViewPerformance",ViewPerformance);//添加是否有权限查看公司总业绩等信息标识
		
		int perfTarget = subjectService.queryPerfTarget();//查询这个月的总业绩目标
		model.put("perfTarget", perfTarget);
		Subject subject = new Subject();
		List<Subject> listsub = subjectService.listByCondition(sub);
		if(listsub.size()>0){
			subject = listsub.get(0);//查询部门业绩目标
		}else{			
			subject.setPerfTarget(0);
		}
		model.put("subject", subject);
		VipStudent vipStudent = new VipStudent();
		vipStudent.setJointime(calendar.get(Calendar.YEAR)+""+(calendar.get(Calendar.MONTH)+1));
		model.put("today", vipStudentService.getStatisticaltoday(calendar.get(Calendar.YEAR)+""+(calendar.get(Calendar.MONTH)+1)+""+calendar.get(Calendar.DATE)));
		model.put("currMonth", vipStudentService.getStatistical(vipStudent));
		vipStudent.setJointime(StringUtil.formatDateyyyyMM(before.getTime()));
		model.put("beforeMonth", vipStudentService.getStatistical(vipStudent));
		
		model.put("currMonthMarkStu", marketStudentService.getMarkStuCount(StringUtil.formatDateyyyyMMdd(calendar.getTime()).replaceAll("-", "")));
		model.put("beforeMonthMarkStu", marketStudentService.getMarkStuCount(StringUtil.formatDateyyyyMMdd(before.getTime()).replaceAll("-", "")));
		
		AccountFlow accountEnt = new AccountFlow();
		accountEnt.setStartDate(calendar.get(Calendar.YEAR)+""+(calendar.get(Calendar.MONTH)+1)+"01");
		model.put("currMonthMoney", accountFlowService.getCountMoney(accountEnt));
		accountEnt.setStartDate(StringUtil.formatDateyyyyMMdd(before.getTime()));
		model.put("beforeMonthMoney", accountFlowService.getCountMoney(accountEnt));
		
		AccountFlow accountxf = new AccountFlow();
		accountxf.setCreateTime(calendar.get(Calendar.YEAR)+""+(calendar.get(Calendar.MONTH)+1));
		model.put("currMonthxf", accountFlowService.getXFMoney(accountxf));
		accountxf.setCreateTime(StringUtil.formatDateyyyyMM(before.getTime()));
		model.put("beforeMonthxf", accountFlowService.getXFMoney(accountxf));
		
		model.put("myExpense", expenseAccountService.getMyExpense(user.getId(),calendar.get(Calendar.YEAR)+"-"+(calendar.get(Calendar.MONTH)+1)+"-01"));
		model.put("myMessage", employeeService.getMyMessage(user.getId()));
		model.put("myPerformance", empPerformanceService.getMyPerformance(user.getId(),calendar.get(Calendar.YEAR)+"-"+(calendar.get(Calendar.MONTH)+1)+"-01"));
		accountxf.setCreateTime(calendar.get(Calendar.YEAR)+""+(calendar.get(Calendar.MONTH)+1));
		accountxf.setSubjectName(orgService.listByCondition(org).get(0).getPinyin());
		model.put("deptPerformance", accountFlowService.getBarStatistic(accountxf));
		
		mv.addObject("noticeList", empNoticeService.listByCondition(new EmpNotice()));
		
		List<Subject> sublist = subjectService.listByCondition(new Subject());
		for(int i=0;i<sublist.size();i++){
			String deptname = sublist.get(i).getName();
			accountxf.setSubjectName(deptname);
			model.put(deptname, accountFlowService.getBarStatistic(accountxf));
		}
		mv.addObject("model", model);
		if(user.getPassword().equals(Constant.INIT_PASSWORD)){//用户密码是初始密码就提示修改密码
			mv.addObject("isModifyPw", "t");
		}else{
			mv.addObject("isModifyPw", "f");
		}
		
		return mv;
	}
	
	/*public static void main(String[] args) {
		Calendar calendar = Calendar.getInstance();
		int year = calendar.get(Calendar.YEAR);
		int month = calendar.get(Calendar.MONTH)+1;
	}*/
	/**
	 * 登录处理
	 * 
	 * @param request
	 *            HttpServletRequest
	 * @return ModelAndView 登陆页面
	 */
	@RequestMapping("/login")
	public ModelAndView login(HttpServletRequest request,Map<String, String> map, HttpServletResponse response, boolean captchaRequired) {
	    // 验证用户名密码  
		String userName = StringUtils.defaultIfEmpty(
				request.getParameter("userName"), StringUtils.EMPTY);
		String password = StringUtils.defaultIfEmpty(
				request.getParameter("password"), StringUtils.EMPTY);
		// 根据用户SID获取用户实体
		UserInfo userInfo = userInfoService.getByUserAccount(userName);
		// 判断用户密码和加密后输入密码是否一致
		if (userInfo == null || password == null || "".equals(password)) {
			return new ModelAndView("jsp/common/login", "message", Utils.getI18n("user.password.mistake", null));
		}
		boolean b = userInfo.getPassword().equals(MD5Encryption.MD5(password));
		// 如果一致则跳转主页否则跳转至登陆页
		if (!b) {
			// 密码错误跳转登陆页面，并返回提示
			return new ModelAndView("jsp/common/login", "message", Utils.getI18n("user.password.mistake", null));
		}
		if ((userInfo.getEnableStateDate() != null && DateUtil.now().compareTo(
				userInfo.getEnableStateDate()) == -1)
				|| (userInfo.getEnableEndDate() != null && DateUtil.parseDate(
						DateUtil.now(), Constant.DATETIME_FORMAT).compareTo(
						DateUtil.parseDate(userInfo.getEnableEndDate(),
								Constant.DATE_FORMAT) + " 23:59:59") == 1)) {
			// 开通开始时间大于NOW获取结束时间小于NOW，则图示
			return new ModelAndView("jsp/common/login", "message", Utils.getI18n("user.overdue", null));
		}
		// 登陆成功将用户信息放入session中
		request.getSession().setAttribute(Constant.LOGIN_USER_KEY, userInfo);
		userInfo.setLastLoginIp(Utils.getRemortIP(request));
		userInfo.setLastLoginTime(DateUtil.nowSqlTimestamp());
		userInfoService.updateLastLoginInfo(userInfo);
		return new ModelAndView("redirect:/index.do");

	}

	/**
	 * 跳转到登录页面
	 * 
	 * @param request
	 *            HttpServletRequest
	 * @return ModelAndView 登陆页面
	 */
	@RequestMapping("/tologin")
	public ModelAndView tologin(HttpServletRequest request) {
		return new ModelAndView("WEB-INF/jsp/common/login");
	}
	/**
	 * 验证图片验证码
	 * @return 
	 * */
	@RequestMapping("/varifyCode")
	public void varifyCode(HttpServletRequest request,HttpServletResponse response,String strcode){
		HttpSession session = request.getSession();
        String obj = session.getAttribute("validateCode").toString();
        String code = StringUtils.defaultIfEmpty(
				request.getParameter("strcode"), StringUtils.EMPTY);
        
        ResultMessage rm = new ResultMessage();
     // 如果一致则返回true
       if(code.toLowerCase().equals(obj.toLowerCase())){
    	   	rm.setStatus(1);
			AjaxUtils.sendAjaxForObjectStr(response, rm);
			return;
       }
       return;
	}
	/**
	 * app登录处理
	 * 
	 * @param request
	 *            HttpServletRequest
	 * @return ModelAndView 登陆页面
	 */
	@RequestMapping("/appLogin")
	public void applogin(HttpServletRequest request,
			HttpServletResponse response) {
		String userName = StringUtils.defaultIfEmpty(
				request.getParameter("userName"), StringUtils.EMPTY);
		String password = StringUtils.defaultIfEmpty(
				request.getParameter("password"), StringUtils.EMPTY);
		// 根据用户SID获取用户实体
		UserInfo userInfo = userInfoService.getByUserAccount(userName);
 		ResultMessage rm = new ResultMessage();
		
		// 判断用户密码和加密后输入密码是否一致
		if (userInfo == null || password == null || "".equals(password)) {
			rm.setStatus(0);
			rm.setMessage(Utils.getI18n("user.password.mistake", null));
			AjaxUtils.sendAjaxForObjectStr(response, rm);
			return;
		}
		password = MD5Encryption.MD5(password);
		boolean b = userInfo.getPassword().equals(password);
		// 如果一致则跳转主页否则跳转至登陆页
		if (!b) {
			// 密码错误跳转登陆页面，并返回提示
			rm.setStatus(0);
			rm.setMessage("用户名或密码错误！");
			AjaxUtils.sendAjaxForObjectStr(response, rm);
			return;
		}
		if ((userInfo.getEnableStateDate() != null && DateUtil.now().compareTo(
				userInfo.getEnableStateDate()) == -1)
				|| (userInfo.getEnableEndDate() != null && DateUtil.parseDate(
						DateUtil.now(), Constant.DATETIME_FORMAT).compareTo(
						DateUtil.parseDate(userInfo.getEnableEndDate(),
								Constant.DATE_FORMAT) + " 23:59:59") == 1)) {
			// 开通开始时间大于NOW获取结束时间小于NOW，则图示 账号过期
			rm.setStatus(0);
			rm.setMessage(Utils.getI18n("user.overdue", null));
			AjaxUtils.sendAjaxForObjectStr(response, rm);
			return;
		}

		// 登陆成功将用户信息放入session中
		request.getSession().setAttribute(Constant.LOGIN_USER_KEY, userInfo);
		
		userInfo.setLastLoginIp(Utils.getRemortIP(request));
		userInfo.setLastLoginTime(DateUtil.nowSqlTimestamp());
		userInfoService.updateLastLoginInfo(userInfo);
		rm.setData(userInfo);
		rm.setJsessionid(request.getSession().getId());
		AjaxUtils.sendAjaxForObjectStr(response, rm);
	}

	/**
	 * 登出操作请求的页面
	 * 
	 * @param request
	 *            HttpServletRequest
	 * @return ModelAndView
	 */
	@RequestMapping("/logout")
	public ModelAndView logout(HttpServletRequest request) {
		request.getSession().removeAttribute(Constant.LOGIN_USER_KEY);
		return new ModelAndView("WEB-INF/jsp/common/login");
	}

	/**
	 * 登出操作请求的页面
	 * 
	 * @param request
	 *            HttpServletRequest
	 * @return ModelAndView
	 */
	@RequestMapping("/getLocationStr")
	public void getLocationStr(HttpServletRequest request,
			HttpServletResponse response) {
		String urlStr = StringUtils.defaultIfEmpty(
				request.getParameter("urlStr"), StringUtils.EMPTY);
		ResultMessage rm = new ResultMessage();
		rm.setMessage(moduleService.getModuleLocationStrByUrl(urlStr));
		AjaxUtils.sendAjaxForObjectStr(response, rm);
	}

	
	/**
	 * 进入没有权限信息提示页面
	 * 
	 * @return error
	 */
	@RequestMapping("/alertNoRight")
	public ModelAndView alertNoRight() {
		return showError("msg.noRight", null);
	}

	/**
	 * 进入错误信息提示页面
	 * 
	 * @param mKey
	 *            String
	 * @param mValue
	 *            mValue
	 * @return ModelAndView
	 */
	@RequestMapping("/showError")
	public ModelAndView showError(String mKey, String mValue) {
		Object[] variable = null;
		if (StringUtil.isBlank(mValue)) {
			variable = new Object[] {};
		} else {
			variable = mValue.split(",");
		}
		return new ModelAndView("jsp/common/error", "message", Utils.getI18n(
				mKey, variable));
	}


	/**
	 * 跳转到导入共通页面
	 * 
	 * @param request
	 *            HttpServletRequest
	 * @return ModelAndView
	 */
	@RequestMapping("/import/toImportExcel")
	public ModelAndView toImportExcel(HttpServletRequest request,
			String parseUrl, String serviceName, String serviceId) {
		ModelAndView m = new ModelAndView("jsp/common/importExcelPage");
		m.addObject("parseUrl", parseUrl);
		m.addObject("serviceName", serviceName);
		m.addObject("serviceId", serviceId);
		return m;
	}

}
