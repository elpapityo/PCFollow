# PC Follow

FFXIV / Dalamud 用のPC追従プラグインです。

開始時に選択したPCを追従対象として記憶し、現在の戦闘ターゲットとは独立して追従を維持します。PT外PCも対象にできます。

## 主な機能

- 標準 `/follow` を使う Native Follow モード
- vnavmesh を使う VNA Follow モード
- 戦闘で追従が解除された場合の自動再追従
- エリア移動後の追従対象再取得
- 追従対象のHP低下時に指定スキルを実行
- Rotation Solver Reborn が Auto 中の場合、回復処理中だけ一時停止して完了後に復帰

## 現在のバージョン

v0.1.11

## 導入

Dalamud のカスタムプラグインリポジトリに以下を登録してください。

`https://raw.githubusercontent.com/elpapityo/PCFollow/main/pluginmaster.json`

## 操作

1. 追従したいPCをターゲットします。
2. PC Follow の設定画面で追従モードを選びます。
3. 開始すると、そのPCを追従対象として保持します。
4. 戦闘中に別の敵をターゲットしても追従対象は変わりません。

## 回復スキル

追従対象のHPが設定値以下になったとき、指定したアクション名を追従対象へ使用します。

RSRがAuto中の場合は、RSRを一時停止し、予約済みアクションや詠唱が落ち着くまで待ってから回復スキルを試行し、回復確認後にRSRをAutoへ戻します。

## 作者

Elpa
