package com.dongnao.workbench.common.controller;

import java.io.IOException;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dongnao.workbench.basic.service.SurveyService;
import com.dongnao.workbench.common.bean.Survey;
import com.dongnao.workbench.common.util.AjaxUtils;
import com.dongnao.workbench.common.util.Utils;
import com.dongnao.workbench.common.util.msg.SMSCodeUtils;

import net.sf.json.JSONObject;


/**
 * 描述：公共模块controller类，负责公共获取
 * 
 * @author fan.yang
 * @version 1.0 2016-03-27
 */

@Controller
@RequestMapping("/common/")
public class CommonController {
@Resource SurveyService surveyService;
	/**
	 * 进入首页页面
	 * 
	 * @param request
	 *            HttpServletRequest
	 * @return ModelAndView 返回到首页页面
	 */
	@RequestMapping("/sendSmsCode")
	public void sendSmsCode(HttpServletRequest request,HttpServletResponse response) {
		AjaxUtils.sendAjaxForObjectStr(response, SMSCodeUtils.newMsgCode(request, Utils.getLoginUserInfo(request)));;
	}

	/**
	 * 进入首页页面
	 * 
	 * @param request
	 *            HttpServletRequest
	 * @return ModelAndView 返回到首页页面
	 */
	@RequestMapping("/patternSmsCode")
	public void patternSmsCode(String smsCode,HttpServletRequest request,HttpServletResponse response) {
		if(SMSCodeUtils.checkMsgCode(request, smsCode)){
			AjaxUtils.sendAjaxForObject(response, Boolean.TRUE);
		}else{
			AjaxUtils.sendAjaxForObject(response, Boolean.FALSE);
		}
	}
	
	/**
	 * 新增调查方法
	 * @param response HttpServletResponse
	 * @return: ajax输入json字符串
	 * @throws IOException 
	 * @throws ServletException 
	 */
	@RequestMapping("/addSurvey")
	public void add(@RequestBody String str,HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException{
		Survey survey = new Survey();
		survey.setIp(Utils.getRemortIP(request));
		survey.setContent(JSONObject.fromObject(str).getString("content"));
		
		AjaxUtils.sendAjaxForObjectStr(response,surveyService.add(survey));		
	}
}
