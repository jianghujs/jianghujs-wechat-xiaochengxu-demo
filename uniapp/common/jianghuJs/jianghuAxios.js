import axios from '@/common/lib/axios.min.js';
import { uniAdapter } from "@/common/jianghuJs/axiosUniAdapter.js";

import appConfig from '@/config.js';

require('@/common/lib/lodash.min.js');

const appInfo = {
  appId: appConfig.appId,
  userAgent: '',
}
if (appInfo.userAgent.length > 127) {
  appInfo.userAgent = appInfo.userAgent.substring(0, 126);
}

class BizError extends Error {
	constructor({
		errorCode,
		errorReason,
		errorReasonSupplement,
		response
	}) {
		super(errorCode);
		this.name = 'BizError';
		this.errorCode = errorCode;
		this.errorReason = errorReason;
		this.errorReasonSupplement = errorReasonSupplement;
		this.response = response;
	}
}

const jianghuAxios = axios.create({
	headers: {
		'Content-Type': 'application/json'
	},
	timeout: 30000,
	withCredentials: false,
	adapter: uniAdapter,
});

/**
 * desc: 请求拦截器 ==> 数据填充
 * [axios文档](https://axios-http.com/zh/docs/interceptors)
 */
jianghuAxios.interceptors.request.use(async config => {
	const data = config.data;
	if (!data.appData) {
		data.appData = {};
	}
	const {
		pageId,
		actionId
	} = data.appData;
	const resourceId = `${pageId}.${actionId}`;

	// config.data 的 优先级更高
	const packageId = `${Date.now()}_${_.random(1000000, 9999999)}`;
	if (!data.packageId) {
		data.packageId = packageId;
	}
	const packageType = 'httpRequest';
	if (!data.packageType) {
		data.packageType = packageType;
	}
	const {
		appId,
		userAgent
	} = appInfo;
	if (!data.appData.appId) {
		data.appData.appId = appId;
	}
	if (!data.appData.userAgent) {
		data.appData.userAgent = userAgent;
	}

	const authToken = uni.getStorageSync(`${appInfo.appId}_authToken`) || '';

	if (!data.appData.authToken) {
		data.appData.authToken = authToken;
	}

	const baseURL = `${appConfig.jianghuAxiosDomain}/${appId}/resource?resourceId=${resourceId}`;
	
	const method = 'post';
	return {
		...config,
		baseURL,
		method,
		data
	};
}, err => {
	return Promise.reject(err);
});

/**
 * desc: 响应拦截器 ==> 异常处理
 * [axios文档](https://axios-http.com/zh/docs/interceptors)
 */
jianghuAxios.interceptors.response.use(async response => {
	const data = response.data || {};
	const responseData = data.appData || {};
	const {
		errorCode,
		errorReason
	} = responseData;
	if (errorCode === 'request_token_invalid' || errorCode === 'request_user_not_exist' ||
		errorCode === 'request_token_expired' || errorCode === 'user_banned') {
		uni.removeStorageSync(`${appInfo.appId}_authToken`)
		uni.showModal({
			title: "提示",
			content: errorReason,
			showCancel: false,
			confirmText: '知道了'
		});
		return response;
	}

	// 需要把 errorCode 转成异常抛出来
	if (errorCode) {
		uni.showModal({
			title: "提示",
			content: errorReason,
			showCancel: false,
			confirmText: '知道了'
		});
		throw new BizError({
			errorCode,
			errorReason,
			response
		});
	}
	
	return response;
}, err => {
	const {
		code,
		message,
		response
	} = err;
	let {
		errorCode,
		errorReason
	} = err;
	if (!errorCode && code) {
		errorCode = code;
	}
	if (!errorReason && message) {
		errorReason = message;
	}

	uni.showModal({
		title: "提示",
		content: errorReason,
		showCancel: false,
		confirmText: '知道了'
	});

	return Promise.reject(new BizError({
		errorCode,
		errorReason,
		response
	}));
});

export default jianghuAxios;
