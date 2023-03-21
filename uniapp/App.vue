<script>
	/**
	 * tabBar页面路径列表 (用于链接跳转时判断)
	 * tabBarLinks为常量, 无需修改
	 */
	const tabBarLinks = ['class/index', 'student/index'];
	import config from '@/config.js';
	//引入 jianghuAxios
	import jianghuAxios from '@/common/jianghuJs/jianghuAxios.js';
	
	export default {
		globalData: {

		},
		/**
		 * 生命周期函数--监听小程序初始化
		 */
		onLaunch(options) {
			// #ifdef MP-WEIXIN || MP-BAIDU || MP-TOUTIAO || MP-ALIPAY
			//支持微信小程序	，百度小程序，字节跳动小程序
			this.autoLogin();//自动登录
			// #endif
	
			// 记录系统信息
			uni.setStorageSync('device', uni.getDeviceInfo());

			// #ifdef MP-WEIXIN
			this.updateApp();
			// #endif
		},
		methods: {	
			jianghuAxios,
	
			/**
			 * 自动登录
			 */
			autoLogin(callback){
				// #ifdef MP-WEIXIN
				// 执行微信登录
				uni.login({
				  success: async (res) => {
						const device = uni.getStorageSync('device') || {};
						const result = await jianghuAxios({
							data: {
								appData: {
									pageId: 'login',
									actionId: 'xcxLogin',
									actionData: {
										code: res.code,
										deviceType: device.deviceType,
										deviceId: device.deviceId,
										userAgent: `${device.deviceBrand}/${device.viceModel}/${device.eviceOrientation}/${device.evicePixelRatio}/${device.system}/${device.platform}`
									},
								}
							}
						});
						uni.setStorageSync(`${config.appId}_authToken`, result.data.appData.resultData.authToken);
				  },
				  fail: (res) => {
						console.log('uni.login fail', res)
				  }
				});
				// #endif
			},
			
			/**
			 * 获取tabBar页面路径列表
			 */
			getTabBarLinks() {
				return tabBarLinks;
			},
			
			/**
			 * 跳转到指定页面
			 * 支持tabBar页面
			 */
			goTo(url) {
				if (!url || url.length == 0) {
					return false;
				}
				let tabBarLinks = this.getTabBarLinks(); // tabBar页面
				if (tabBarLinks.indexOf(url) > -1) {
					uni.switchTab({
						url: '/pages/' + url
					});
				} else {
					// 普通页面
					uni.navigateTo({
						url: '/pages/' + url
					});
				}
			},
			
			/**
			 * 加载中
			 */
			loading(title) {
				uni.showLoading({
					title,
					mask: true
				});
			},

			/**
			 * 成功提示框
			 */
			success(title) {
				uni.showToast({
					title,
					icon: 'success',
					mask: true
				});
			},
			
			/**
			 * 小程序新版本检测与升级
			 */
			updateApp() {
				if (!uni.canIUse('getUpdateManager')) {
					return false;
				}
				const updateManager = uni.getUpdateManager();
				updateManager.onCheckForUpdate(res => {
					// 请求完新版本信息的回调
				});
				updateManager.onUpdateReady(() => {
					uni.showModal({
						title: '更新提示',
						content: '新版本已经准备好，即将重启应用',
						showCancel: false,
						success(res) {
							if (res.confirm) {
								// 新的版本已经下载好，调用 applyUpdate 应用新版本并重启
								updateManager.applyUpdate();
							}
						}

					});
				});
				updateManager.onUpdateFailed(() => {
					// 新的版本下载失败
					uni.showModal({
						title: '更新提示',
						content: '新版本下载失败',
						showCancel: false
					});
				});
			}
		}
	};
</script>
<style lang="scss">
	@import '@/uni_modules/uni-scss/index.scss';
	@import "@/uni_modules/uview-ui/index.scss";

	// table
	.uni-table-th, .uni-table-td{
		font-size: 24rpx !important;
	}

	// text
	.u-text{
		display: inline-block !important;
		width: auto !important;
		margin-left: 10rpx !important;
	}
	.u-text__value{
		font-size: 24rpx !important;
	}

	//form
	.uni-forms-item__label{
		font-size: 24rpx !important;
	}

	//input
	.is-input-border.is-focused{
		border: 1px solid #5ac725 !important;
	}
	
	//check
	.uni-table-checkbox .checkbox__inner.is-checked {
		border-color: #5ac725 !important;
		background-color: #5ac725 !important;
	}
	.uni-table-checkbox .checkbox__inner:hover {
		border-color: #5ac725 !important;
	}
	.uni-table-checkbox .checkbox__inner.checkbox--indeterminate {
		border-color: #5ac725 !important;
		background-color: #5ac725 !important;
	}
</style>
