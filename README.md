# freesurfer_sampling_maps

## Requirement
FreeSurfer 6.0.0  
FSL  
MRtrix3

## 概要

このレポジトリには、MRI画像の前処理と領域毎の定量指標の計測を行うための2つの主要なスクリプトが含まれています。

1. **sampling_maps_prepro.sh**: FreeSurferを使用してMRI画像の前処理を行い、さまざまな領域のラベルマップを生成します。
2. **sampling_maps.sh**: 指定された領域でMRIマップの平均値と中央値を計測します。

## フォルダ構造
以下のフォルダ構造を想定しています。　　
各コードをworkdirで実行します。  
各被験者に対応するフォルダ名は"{ID}_{vendor}_{scan}"としてください。

```
workdir
├── ID01_Discovery_scan
│ ├── T1MAP.nii.gz
│ ├── T1WI.nii.gz
│ └── T2MAP.nii.gz
└── ID01_Discovery_rescan
│ ├── T1MAP.nii.gz
│ ├── T1WI.nii.gz
│ └── T2MAP.nii.gz
├── ID02_Discovery_scan
...
```



## 使用方法

### 1. sampling_maps_prepro.sh

```
bash sampling_maps_prepro.sh -i T1WI.nii.gz -p [プロセス数]
```

オプション:

-i: 入力として使用するT1WIファイル名。  
-p: 使用するプロセスの数。  
-h: ヘルプメッセージを表示。  

```
bash sampling_maps.sh -m PDMAP.nii.gz,T1MAP.nii.gz,T2MAP.nii.gz -v Skyra,Prisma -s scan,rescan -a nodes_DK
```

オプション:  
  
-m: 分析するマップを指定 (例: PDMAP.nii.gz,T1MAP.nii.gz,T2MAP.nii.gz)。  
-v: ベンダーを指定 (例: Skyra,Prisma)。  
-s: スキャンタイプを指定 (例: scan,rescan)。  
-a: 使用するアトラスを指定 (例: nodes_DK, nodes_aseg, nodes_wmparc)。  
-h: ヘルプメッセージを表示。  
注意: 必要に応じて、各スクリプトの中で定義されているパスや変数を適切に設定してください。  

