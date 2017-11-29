package com.dongnao.workbench.account.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dongnao.workbench.common.page.Page;
import com.dongnao.workbench.common.util.AjaxUtils;
import com.dongnao.workbench.common.util.Utils;
import com.dongnao.workbench.school.model.Standard;
import com.dongnao.workbench.common.util.FormatEntity;
import com.dongnao.workbench.account.model.AccountFinance;
import com.dongnao.workbench.account.model.AccountSubject;
import com.dongnao.workbench.account.model.Accounting;
import com.dongnao.workbench.account.service.AccountFinanceService;
import com.dongnao.workbench.account.service.AccountSubjectService;
import com.dongnao.workbench.account.service.AccountingService;
import com.dongnao.workbench.accountflow.model.AccountFlow;
import com.dongnao.workbench.accountflow.service.AccountFlowService;
import com.dongnao.workbench.basic.model.UserInfo;
import com.dongnao.workbench.basic.service.UserInfoService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


/**
 * 描述：会计凭证管理模块controller类，负责页面分发与跳转
 * 
 * @author maggie
 * @version 1.0 2016-08-15
 */
 
@Controller
@RequestMapping("accounting")
public class AccountingController{
         @Resource
	private AccountingService accountingService;
         @Resource
     	private AccountSubjectService accountSubjectService;
         @Resource
     	private AccountFlowService accountFlowService;
         @Resource
     	private UserInfoService userInfoService;
         @Resource
     	private AccountFinanceService accountFinanceService;
 	/**
 	* 进入新增页面
 	* @return ModelAndView 返回到新增页面
 	*/
 	@RequestMapping("/toAddAccounting")
	public ModelAndView toAdd(String key,HttpServletRequest request){
 		ModelAndView mv = new ModelAndView(
 				"WEB-INF/jsp/account/accounting/addAccounting");
 		
 		if(key!=null){
 			AccountFlow entity = accountFlowService.getByPrimaryKey(key);
 			Map<String,String> accountFlow = FormatEntity.getObjectValue(entity);
 			mv.addObject("accountFlow", accountFlow);
 		}
 		UserInfo user=Utils.getLoginUserInfo(request);
 		mv.addObject("user", user);
 		
 		List<AccountSubject> accountList = accountSubjectService.listByCondition(new AccountSubject());
 		mv.addObject("accountList", accountList);
 		
 		List<AccountFinance> digestList = accountFinanceService.listByCondition(new AccountFinance());
 		mv.addObject("digestList", digestList);
 		
		return mv;
	}
	
	/**
	 * 进入查看页面方法
	 * @param key String：实体id
	 * @return ModelAndView: 查询实体
	 */	
	@RequestMapping("/toShowAccounting")
	public ModelAndView toShow(String key){
		Accounting entity = accountingService.getByPrimaryKey(key);
		Map<String,String> accounting = FormatEntity.getObjectValue(entity);
		return new ModelAndView("WEB-INF/jsp/account/accounting/showAccounting","accounting",accounting );
	}
	
	/**
	 * 新增方法
	 * @param response HttpServletResponse
	 * @param accounting Accounting:实体类
	 * @return: ajax输入json字符串
	 */
	@RequestMapping("/addAccounting")
	public void add(Accounting accounting,HttpServletRequest request,HttpServletResponse response){
	accounting.setId(Utils.generateUniqueID());
	AjaxUtils.sendAjaxForObjectStr(
				response,accountingService.add(accounting));		
	}
	
	/**
	 * 删除方法
	 * @param response HttpServletResponse
	 * @param key String:多个由“，”分割开的id字符串
	 * @return: ajax输入json字符串
	 */
	@RequestMapping("/deleteAccounting")
	public void deleteByKey(String key,HttpServletResponse response){
		String[] str = key.split(",");
		for(int i=0;i<str.length;i++){
			accountingService.deleteByKey(str[i]);
		}
		Map<String, String> map = new HashMap<String, String>();
		map.put("msg", "成功");
		AjaxUtils.sendAjaxForMap(response, map);
	}
	
	/**
	 * 进入列表页面
	 * @return ModelAndView
	 */
	@RequestMapping("/toListAccounting")
	public ModelAndView toList(){
		return new ModelAndView("WEB-INF/jsp/account/accounting/listAccounting");
	}
	
	/**
	 * 根据条件查找列表方法
	 * @param accounting Accounting：实体对象（查询条件）
	 * @param request HttpServletRequest
	 * @param response HttpServletResponse
	 * @param page Page:分页对象
	 * @return: ajax输入json字符串
	 */
	@RequestMapping("/listAccounting")
	public void listByCondition(Accounting accounting,HttpServletRequest request,
			HttpServletResponse response, Page page){
		accounting.setPage(page);	
		List<Accounting> list = accountingService.listByCondition(accounting);
		AjaxUtils.sendAjaxForPage(request, response, page, list);
	}
	
	/**
	 * 进入修改页面方法
	 * @param key String：实体id
	 * @return ModelAndView: 查询实体
	 */	
	@RequestMapping("/toEditAccounting")
	public ModelAndView toEdit(String key,String enterPno,HttpServletRequest request){
		ModelAndView mv = new ModelAndView(
				"WEB-INF/jsp/account/accounting/editAccounting");
		
		Accounting entity = accountingService.getByPrimaryKey(key);
		Map<String,String> accounting = FormatEntity.getObjectValue(entity);
		mv.addObject("accounting", accounting);
		
		List<UserInfo> user = userInfoService.listByCondition(new UserInfo());
		mv.addObject("user", user);
		
		UserInfo userInfo=Utils.getLoginUserInfo(request);
 		mv.addObject("userInfo", userInfo);
		
		List<AccountSubject> accountList = accountSubjectService.listByCondition(new AccountSubject());
 		mv.addObject("accountList", accountList);
		
 		List<AccountFinance> digestList = accountFinanceService.listByCondition(new AccountFinance());
 		mv.addObject("digestList", digestList);
		return mv;
	}
	
	/**
	 * 修改方法
	 * @param accounting Accounting：实体对象
	 * @param response HttpServletResponse
	 * @return: ajax输入json字符串
	 */	
	@RequestMapping("/updateAccounting")
	public void update(Accounting accounting,HttpServletRequest request,HttpServletResponse response){
		AjaxUtils.sendAjaxForObjectStr(
				response,accountingService.update(accounting));	
	}
	
	/**
 	* 进入审核页面
 	* @return ModelAndView 返回到审核页面
 	*/
 	@RequestMapping("/toAuditAccounting")
	public ModelAndView toAudit(String key,HttpServletRequest request){
 		ModelAndView mv = new ModelAndView(
 				"WEB-INF/jsp/account/accounting/auditAccounting");
 		
 		Accounting entity = accountingService.getByPrimaryKey(key);
		Map<String,String> accounting = FormatEntity.getObjectValue(entity);
		mv.addObject("accounting", accounting);
 		
 		List<UserInfo> userInfo = userInfoService.listByCondition(new UserInfo());
		mv.addObject("userInfo", userInfo);
 		
 		UserInfo user=Utils.getLoginUserInfo(request);
 		mv.addObject("user", user);
 		
		return mv;
	}
	
 	
 	/**
	 * 批量清算方法
	 * @param response HttpServletResponse
	 * @param key String:多个由“，”分割开的id字符串
	 * @return: ajax输入json字符串
	 */
	@RequestMapping("/auditAccounting")
	public void auditAccounting(String key,HttpServletRequest request,HttpServletResponse response){
		UserInfo user=Utils.getLoginUserInfo(request);
		String checkPno = user.getId();
		String[] str = key.split(",");
		for(int i=0;i<str.length;i++){
			Accounting entity = accountingService.getByPrimaryKey(str[i]);
			entity.setCheckPno(checkPno);
			accountingService.auditByKey(entity);
		}
		Map<String, String> map = new HashMap<String, String>();
		map.put("msg", "成功");
		AjaxUtils.sendAjaxForMap(response, map);
	}
}