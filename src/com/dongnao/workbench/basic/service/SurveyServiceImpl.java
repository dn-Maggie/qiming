package com.dongnao.workbench.basic.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.dongnao.workbench.basic.dao.SurveyMapper;
import com.dongnao.workbench.common.bean.ResultMessage;
import com.dongnao.workbench.common.bean.Survey;
import com.dongnao.workbench.common.util.AjaxUtils;

@Service("surveyService")
public class SurveyServiceImpl implements SurveyService {
	@Resource
	private SurveyMapper surveyMapper;
	
	@Override
	public ResultMessage add(Survey survey) {
		List<Survey> list = surveyMapper.listByCondition(survey);
		if(list.size()>0){
			return AjaxUtils.getFailureMessage("同一IP下不能重复提交");
		}
		if(surveyMapper.add(survey)>0){
			return AjaxUtils.getSuccessMessage();
		}else{
			return AjaxUtils.getFailureMessage("插入数据失败");
		}
	}

	@Override
	public List<Survey> listByCondition(Survey survey) {
		return surveyMapper.listByCondition(survey);
	}

}
