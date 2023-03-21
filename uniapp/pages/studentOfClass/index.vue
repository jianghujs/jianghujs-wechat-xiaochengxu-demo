<template>
	<view class="uni-pa-3">
		<!-- 页面内容 >>>>>>>>>>>>> -->
		<view v-if="!isAllotDrawerShown">
			<!-- 分配学生按钮 -->
			<u-sticky>
				<view class="uni-mb-3">
					<u-button text="分配学生" type="success" size="small" @click="doUiAction('startAllotItem')"></u-button>
				</view>
			</u-sticky>
			<!-- 表格列表 -->
			<uni-table :loading="isTableLoading" border>
				<uni-tr>
					<uni-th width="60">操作</uni-th>
					<uni-th>学生ID</uni-th>
					<uni-th>班级ID</uni-th>
					<uni-th>备注</uni-th>
					<uni-th>操作者</uni-th>
					<uni-th>操作时间</uni-th>
				</uni-tr>
				<uni-tr v-for="(item, index) in tableData" :key="index">
					<uni-td>
						<u--text type="success" text="删除" @click="doUiAction('deleteItem', item)"></u--text>
					</uni-td>
					<uni-td>{{ item.studentId }}</uni-td>
					<uni-td>{{ item.classId }}</uni-td>
					<uni-td>{{ item.remark }}</uni-td>
					<uni-td>{{ item.operationByUser }}</uni-td>
					<uni-td>{{ item.operationAt }}</uni-td>
				</uni-tr>
			</uni-table>
		</view>
		<!-- <<<<<<<<<<<<< 页面内容 -->

		<!-- 分配学生 >>>>>>>>>>>>> -->
		<uni-section title="分配学生" titleColor="#8f939c" v-if="isAllotDrawerShown">
			<template v-slot:right>
				<u-button @click="isAllotDrawerShown = false" size="small">返回</u-button>			
			</template>
			<view class="uni-px-5">
				<!-- 分配学生按钮 -->
				<u-sticky>
					<view class="uni-mb-3">
						<u-button text="批量新增" type="success" size="small" @click="doUiAction('allotItem')"></u-button>
					</view>
				</u-sticky>
				<!-- 表格列表 -->
				<uni-table :loading="isAllotTableLoading" border type="selection" @selection-change="tableItemSelected">
					<uni-tr>
						<uni-th width="60">操作</uni-th>
            <uni-th>学生ID</uni-th>
            <uni-th>学生名字</uni-th>
            <uni-th>性别</uni-th>
            <uni-th>出生日期</uni-th>
            <uni-th>年级</uni-th>
            <uni-th>身高</uni-th>
            <uni-th>学生状态</uni-th>
						<uni-th>备注</uni-th>
						<uni-th>操作者</uni-th>
						<uni-th>操作时间</uni-th>
					</uni-tr>
					<uni-tr v-for="(item, index) in allotTableData" :key="index">
						<uni-td>
							<u--text type="success" text="新增" @click="doUiAction('buildRelation', item)"></u--text>
						</uni-td>
						<uni-td>{{ item.id }}</uni-td>
            <uni-td>{{ item.studentId }}</uni-td>
            <uni-td>{{ item.name }}</uni-td>
            <uni-td>{{ item.gender }}</uni-td>
            <uni-td>{{ item.dateOfBirth }}</uni-td>
            <uni-td>{{ item.level }}</uni-td>
            <uni-td>{{ item.bodyHeight }}</uni-td>
            <uni-td>{{ item.studentStatus }}</uni-td>
            <uni-td>{{ item.remark }}</uni-td>
            <uni-td>{{ item.operationByUser }}</uni-td>
            <uni-td>{{ item.operationAt }}</uni-td>
					</uni-tr>
				</uni-table>
			</view>
		</uni-section>
		<!-- <<<<<<<<<<<<< 分配学生 -->
				
  </view>
</template>

<script>
	const App = getApp();
	export default {
		data() {
			return {
				// url传递的参数
				options: {},
				classId: null,
				title: null,
				
				// 表格相关数据
				isTableLoading: true,
				tableData: [],

				// 分配学生表格相关数据
				isAllotTableLoading: true,
				allotTableData: [],
				allotTableDataFromBackend: [],
				allotTableSelected: [],

				// 操作相关
				isAllotDrawerShown: false,
				allotItemId: {},
				deleteItem: {},
				deleteItemId: null
			};
		},
		components: {},
		props: {},
		async onLoad(options) {
			this.options = options;

			await this.doUiAction('prepareUrlObj');
      await this.doUiAction('getTableData');
      await this.doUiAction('getAllotTableData');
		},
		onShow() {},
		methods: {
			async doUiAction(uiActionId, uiActionData) {
        switch (uiActionId) {
          case 'prepareUrlObj':
            await this.prepareUrlObj();
            break;
          case 'getTableData':
            await this.getTableData();
            break;
          case 'getAllotTableData':
            await this.getAllotTableData();
            await this.buildAllotTableData();
            break;
          case 'startAllotItem':
            await this.openAllotDrawer();
            break;
          case 'allotItem':
            await this.confirmAllotItemDialog();
            await this.doAllotItem();
            await this.clearAllotItemData();
            await this.getTableData();
            await this.buildAllotTableData();
            break;
          case 'buildRelation':
            await this.confirmAllotItemDialog();
            await this.prepareDoBuildRelation(uiActionData);
            await this.doBuildRelation();
            await this.clearAllotItemData();
            await this.getTableData();
            await this.buildAllotTableData();
            break;
          case 'deleteItem':
            await this.prepareDeleteFormData(uiActionData);
            await this.confirmDeleteItemDialog();
            await this.prepareDoDeleteItem();
            await this.doDeleteItem();
            await this.clearDeleteItem();
            await this.getTableData();
            await this.buildAllotTableData();
            break;
          default:
            console.error("[doUiAction] uiActionId not find", { uiActionId });
            break;
        }
      },

      // ---------- url传参 uiAction >>>>>>>>>> --------
      async prepareUrlObj() {
				this.classId = this.options.classId;
				this.title = this.options.title;

				uni.setNavigationBarTitle({
					title: `${this.title} - 学生列表`
				});
      },
      // ---------- <<<<<<<<<<< 校验url传参 uiAction  --------

      // ---------- 获取数据 uiAction >>>>>>>>>> --------
      async getTableData() {
        this.isTableLoading = true;
        const result = await App.jianghuAxios({
          data: {
            appData: {
              pageId: 'studentListOfOneClass',
              actionId: 'selectCurrentList',
              where: { classId: this.classId },
              orderBy: [{ column: 'operationAt', order: 'desc' }]
            }
          }
        });
        this.tableData = result.data.appData.resultData.rows;
        this.isTableLoading = false;
      },
      // ---------- <<<<<<<<<<< 获取数据 uiAction  --------

      // ---------- 抽屉表格数据 uiAction >>>>>>>>>> --------
      async getAllotTableData() {
        this.isAllotTableLoading = true;
        const result = await App.jianghuAxios({
          data: {
            appData: {
              pageId: 'studentListOfOneClass',
              actionId: 'selectAllList',
              orderBy: [{ column: 'operationAt', order: 'desc' }]
            }
          }
        });
        this.allotTableDataFromBackend = result.data.appData.resultData.rows;
        this.isAllotTableLoading = false;
      },

      buildAllotTableData() {
        if (_.isEmpty(this.allotTableDataFromBackend)) {
          this.allotTableData = [];
        } else {
          this.allotTableData = _.differenceBy(this.allotTableDataFromBackend, this.tableData, 'studentId');
        }
      },
      // ---------- <<<<<<<<<<< 抽屉表格数据 uiAction  --------

      // ---------- 分配学生 uiAction >>>>>>>>>> --------
      async openAllotDrawer() {
        this.isAllotDrawerShown = true;
      },
      async confirmAllotItemDialog() {
        return new Promise( async resolve=> {
					uni.showModal({
						title: "确定将学生分配给此班级吗", 
						content: "确定分配吗？", 
						success: (res) => {
							if(res.confirm){
								resolve(res.confirm)
							}else{
								throw new Error("[confirmAllotItemDialog] 否");
							}
						}
					})
				})
      },
      async prepareDoBuildRelation(funObj) {
        this.allotItemId = funObj.studentId;
      },
      async doAllotItem() {
        for (let i = 0; i < this.allotTableSelected.length; i++) {
          App.loading(`正在新增 第${i + 1}个`);
          await this.prepareDoBuildRelation(this.allotTableSelected[i]);
          await this.buildRelationImpl();
        }
        await App.success("批量新增成功");
      },
      async doBuildRelation() {
        await App.loading("正在新增");
        await this.buildRelationImpl();
        await App.success("新增成功");
      },
      async buildRelationImpl() {
        await App.jianghuAxios({
          data: {
            appData: {
              pageId: 'studentListOfOneClass',
              actionId: 'insertItem',
              actionData: { classId: this.classId, studentId: this.allotItemId }
            }
          }
        });
      },
      async clearAllotItemData() {
        this.allotTableSelected = [];
        this.allotItemId = null;
      },
      // ---------- <<<<<<<<<<< 分配学生 uiAction  --------

      // ---------- 删除数据 uiAction >>>>>>>>>>>> --------
      async prepareDeleteFormData(funObj) {
        this.deleteItem = _.cloneDeep(funObj);
      },
      async confirmDeleteItemDialog() {
        return new Promise( async resolve=> {
					uni.showModal({
						title: "删除", 
						content: "确定删除吗？", 
						success: (res) => {
							if(res.confirm){
								resolve(res.confirm)
							}else{
								throw new Error("[confirmDeleteItemDialog] 否");
							}
						}
					})
				})
      },
      async prepareDoDeleteItem() {
        const { id } = this.deleteItem;
        this.deleteItemId = id;
      },
      async doDeleteItem() {
        await App.loading("删除学生");
        await App.jianghuAxios({
          data: {
            appData: {
              pageId: 'studentListOfOneClass',
              actionId: 'deleteItem',
              actionData: {},
              where: { id: this.deleteItemId }
            }
          }
        });
        await App.success("删除学生成功");
      },
      async clearDeleteItem() {
        this.deleteItem = {};
        this.deleteItemId = null;
      },
      // ---------- <<<<<<<<<<< 删除数据 uiAction  --------

      // ---------- table selected >>>>>>>>>>>> --------
      tableItemSelected(e) {
				const selectedIndex = e.detail.index;
				this.allotTableSelected = selectedIndex.map(index => this.allotTableData[index])
      },
      // ---------- <<<<<<<<<<< table selected  --------
		}
	};
</script>
<style>

</style>
