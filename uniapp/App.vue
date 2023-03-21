<script>
	/**
	 * tabBar页面路径列表 (用于链接跳转时判断)
	 * tabBarLinks为常量, 无需修改
	 */
	const tabBarLinks = ['class/index', 'student/index'];
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
			uni.setStorageSync('system', uni.getSystemInfoSync());

			// #ifdef MP-WEIXIN
			this.updateApp();
			// #endif

			console.log('device=============', uni.getDeviceInfo(), uni.getSystemInfoSync());
		},
		methods: {	
			
			/**
			 * 当前用户id
			 */
			getUserId() {
				user = this.getUser();
				return user.user_id || '';
			},
			
			/**
			 * 当前用户
			 */
			getUser() {
				return uni.getStorageSync('user') || '';
			},
			
			
			/**
			 * 自动登录
			 */
			autoLogin(callback){
				// #ifdef MP-WEIXIN
				// 执行微信登录
				uni.login({
				  success: async (res) => {
					const result = await jianghuAxios({
						data: {
							appData: {
								pageId: 'login',
								actionId: 'xcxLogin',
								actionData: {
									code: res.code,
									deviceType: 'pad',
									deviceId: '111',
									userAgent: '222'
								},
							}
						}
					});
					console.log('111111111', result)
					// uni.setStorageSync('user', result.data.detail);
					// callback && callback(result.data.detail);
				  },
				  fail: (res) => {
					console.log('uni.login fail', res)
				  }
				});
				// #endif
			},

			/**
			 * 验证登录
			 */
			checkIsLogin() {
				user = this.getUser();
				return user.is_login;
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
			 * jianghuAxios 请求
			*/
			async request(funObj) {
				try{
					const result = await jianghuAxios({
						data: {
							appData: {
								pageId: 'studentList',
								actionId: 'selectItemList',
								actionData: {},
							}
						}
					})
					return {
						data: result.data.appData.resultData.rows || result.data.appData.resultData.row || result.data.appData.resultData || {},
						success: result.data.status === 'success',
						message: ''
					}
				} catch (error) {
					console.error(error)
				}
			},
			
	
			/**
			 * 显示成功提示框
			 */
			showSuccess(msg, callback) {
				uni.showToast({
					title: msg,
					icon: 'success',
					mask: true,
					duration: 1500,
					success() {
						callback && setTimeout(() => {
							callback();
						}, 1500);
					}
				});
			},
			
			/**
			 * 显示失败提示框
			 */
			showError(msg, callback) {
				uni.showModal({
					title: '友情提示',
					content: msg,
					showCancel: false,
					success(res) {
						callback && callback();
					}
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
@import "@/uni_modules/uview-ui/index.scss";
@import "@/common/jh.css";
</style>
