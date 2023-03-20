<template>
	<view>
		test
	</view>
</template>

<script>
	const App = getApp();
	export default {
		data() {
			return {
				user: {},
			};
		},
		components: {},
		props: {},
		onLoad: function(options) {

			// this.getIndexData(); // 获取首页数据
		},

		/**
		 * 生命周期函数--监听页面显示
		 */
		onShow() {},
		methods: {
			/**
			 * 获取首页数据
			 */
			getIndexData: function() {
				App.request({
					data: {
						appData: {
							pageId: 'studentList',
							actionId: 'selectItemList',
							actionData: {},
						}
					}
				}).then(result => {
					this.setData(result.data);
				});
			},

		}
	};
</script>
<style>

</style>
