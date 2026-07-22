# 证据优先的科学论文写作

一个面向 Codex 的科研写作总控 Skill。它根据研究阶段、已有材料和风险状态，安排下一步任务，并把研究问题、证据、文献、写作、翻译、预审和返修接成一条可追溯的流程。

它不是论文生成器，而是科研写作流程的状态机和质量门禁。

## 为什么需要它

AI 辅助论文写作经常不是文本写不出来，而是研究阶段和写作行为没有对上：研究问题还没定就写摘要，实验还没完成就写结果，文献没有核验就下结论，科学内容没有确认就开始翻译和润色。

本 Skill 的基本边界是：

> 没有结果就不写结果，没有核验就不下结论，缺失材料就标记出来。

## 它负责什么

- 判断当前处于研究问题、证据构建、研究设计、起草、核验还是返修阶段。
- 检查是否具备进入下一阶段的材料。
- 生成下一步任务，并推荐当前应调用的专项 Skill。
- 建立研究基础、主张账本、论证图和章节契约。
- 约束中译英、英译中、英文润色和去模板化表达，不改变科学含义。
- 在缺失数据、结果、引用或作者确认时使用 `AUTHOR_INPUT_NEEDED`，而不是补写。

它不内置下游 Skill 的全部能力，也不会假设这些 Skill 已经安装。具体调用能力取决于本地环境。

## 工作状态与质量门禁

| 当前状态 | 进入条件 | 必须完成的检查 | 下一步 |
|---|---|---|---|
| 研究问题收敛 | 只有方向、题目或模糊想法 | 明确对象、问题、变量、目标和评价方式 | `academic-research-suite`、`researchwrite` |
| 证据构建 | 已有研究问题，但缺少可靠文献或来源记录 | 建立文献表、主张账本和证据缺口 | `nature-academic-search`、`nature-literature-pipeline`、`nature-reader`、`nature-citation` |
| 研究设计 | 问题和初步证据已明确 | 固定数据来源、划分、基线、指标、统计和可复现材料 | `academic-research-suite`、`researchwrite` |
| 正文起草 | 研究设计和可用证据已锁定 | 建立章节契约，区分允许主张与禁止主张 | `nature-writing` |
| 翻译与语言处理 | 科学事实、术语、数据和引文已确认 | 保留结论强度、引用关系、单位和不确定性 | `nature-reader`、`nature-polishing`、`humanizer` |
| 图表与披露 | 结果、图表逻辑和数据来源已确认 | 检查图表是否支持正文，完成数据/代码声明 | `nature-figure`、`nature-data` |
| 投稿前核验 | 稿件接近完成 | 检查主张、数字、图表、引文、限制和合规声明 | `nature-reviewer` |
| 审稿返修 | 收到审稿意见或决定信 | 逐条映射意见、证据、改动位置和未解决事项 | `nature-response`、`reviewer-driven-paper-revision` |

### 停止条件

遇到以下情况时，Skill 应暂停生成相关正文，并要求补充或确认材料：

- 研究问题仍无法回答；
- 结果、统计量或数据集划分缺少来源；
- 主张与引文无法对应；
- 翻译会改变原文的证据力度；
- 审稿意见要求的新实验尚未完成；
- 数据、伦理、代码或利益冲突声明不明确。

## 支持的专项 Skill

### 研究与证据

- `academic-research-suite`：研究问题、研究设计、实验规划、统计解释、完整性核验和端到端研究流程。
- `researchwrite`：证据表、论证图、章节契约和分层质量检查。
- `nature-academic-search`：多源文献检索、去重、DOI 核验和参考文献管理。
- `nature-literature-pipeline`：持续发现、评分筛选、精读和文献归档。
- `nature-downloader`：在合法学校、机构或开放获取权限下获取全文。
- `nature-reader`：带来源锚点、图表位置和中英对照的论文精读。
- `nature-citation`：将正文主张与可核验引用对应起来。

### 写作与投稿

- `nature-writing`：起草和重构摘要、引言、方法、结果、讨论和结论。
- `nature-polishing`：英文论文表达、中译英和 LaTeX 排版处理。
- `humanizer`：在科学内容确认后减少模板化、空泛和营销式表达。
- `nature-figure`：制作和审查投稿级科研图。
- `nature-data`：数据可用性、代码共享、数据集引用和 FAIR 检查。
- `nature-reviewer`：投稿前模拟审稿。
- `nature-response`：逐点回复审稿意见。
- `reviewer-driven-paper-revision`：建立返修映射、核验事实并定点改稿。
- `nature-paper2ppt`：将论文转为组会、答辩或会议汇报。
- `nature-paper-to-patent`：在公开前评估论文技术贡献的专利转化。

详见 [科研 Skill 调用路由](evidence-first-paper-writing/references/skill-routing.md)。

## 安装

### 只安装总控 Skill

```bash
git clone git@github.com:lennyS579/paper-writing.git
cp -R paper-writing/evidence-first-paper-writing ~/.codex/skills/
```

复制后重启 Codex 或刷新 Skills 列表。只安装总控 Skill 时，研究问题收敛、证据边界、提纲和停止条件仍然可用。

### 使用完整工作流

按实际阶段安装对应的下游 Skill。未安装某个 Skill 时，总控流程应保留人工操作建议和证据缺口，不得假装已经完成检索、下载、绘图、引用核验或模拟审稿。

`nature-downloader` 只能复用用户已有的合法访问权限，不绕过付费墙、验证码或机构认证。

## 快速开始

```text
使用 $evidence-first-paper-writing。
研究方向：轻量级目标检测模型在低算力设备上的部署。
已有材料：初步数据集，没有完成实验，也没有整理文献。
请输出：当前研究阶段、需要补充的材料、推荐调用的 Skill 和下一步任务。
要求：不要写结果，不要编造引用，并把缺失信息标为 AUTHOR_INPUT_NEEDED。
```

预期输出应包含：

1. 当前状态：研究问题收敛与证据准备；
2. 缺失材料：研究对象、基线、数据划分、指标和核心文献；
3. 禁止事项：不写结果章节，不声明优于现有方法；
4. 推荐下一步：`academic-research-suite`、`researchwrite`、`nature-academic-search`。

更多匿名场景见 [示例场景](evidence-first-paper-writing/references/example-scenarios.md)。

## 目录结构

```text
evidence-first-paper-writing/
├── SKILL.md
├── agents/openai.yaml
└── references/
    ├── research-foundation-template.md
    ├── drafting-and-integrity-checklist.md
    ├── academic-translation-and-style.md
    ├── skill-routing.md
    ├── upstream-attribution.md
    └── example-scenarios.md
```

## 已知限制

- 这是流程和写作辅助工具，不替代学科导师、统计审查、伦理审批或独立实验验证。
- 它不自动获得文献数据库、机构全文或本地实验数据的访问权。
- 下游 Skill 的可用性、版本和输出格式取决于本地安装状态。
- 真实论文、未发表数据、审稿材料、作者信息和私有模板不应放入本仓库。

## 上游项目与许可证

本工作流借鉴并路由到多个开源项目，完整的原始项目名称、作者/维护者和关联边界见 [上游开源项目署名](evidence-first-paper-writing/references/upstream-attribution.md)。主要来源包括：

- [`Imbad0202/academic-research-skills`](https://github.com/Imbad0202/academic-research-skills)
- [`Jiahao8595/research-pipeline`](https://github.com/Jiahao8595/research-pipeline)
- [`Yuan1z0825/nature-skills`](https://github.com/Yuan1z0825/nature-skills)
- [`blader/humanizer`](https://github.com/blader/humanizer)
- [`snipp-zha/Paper-to-patent-Skill`](https://github.com/snipp-zha/Paper-to-patent-Skill)

MIT 许可证仅适用于本仓库原创的工作流编排、模板和文档，不重新授权任何上游 Skill 的代码、提示词、示例或资产。使用和分发时须遵守各自许可证。

## 许可证

本仓库采用 MIT 许可证，见 [LICENSE](LICENSE)。
