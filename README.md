# README

## サービス名
　　『なんでもいい飯メニュー（仮）』

## サービス概要
  何を食べたいか聞かれた時に「何でもいい」という回答しか思いつかいない人に
  何でもいい時によく食べるご飯や食べたいご飯の記録、シェア環境を提供し、
  日々の食事メニュー考案を手助けするサービスです。

## メインのターゲットユーザー
	20〜30代前半の男性、誰かと同居している人（実家住みや結婚されている男性）
	日々の食事を親や奥様に作ってもらっており、空腹時以外に夕食を何にするか相談されるものの食べたいものが思いつかず具体的な回答ができない

## ユーザーが抱える課題
	・特別食べたいものはないけど、何を食べるか決めなければ作ってもらう人を悩ましてしまう
	・相手が食べたいものも気になる
	・冷蔵庫にある材料という制限があるとき、何を作れるかわからない

## 解決方法
	・この時はこれが食べたいという情報を記録することで、特別食べたいものがないときに過去この気分の時は何食べたら不満ないという情報を見つけられる
	・特定の相手の食べたいものをお気に入り登録で見られるようにすることで、相手に合わせたいときの参考にできる
  ・みんなの食事メニューを見ることで、これ食べたいかもという気持ちを芽生えさせる
	・材料から作れる料理を検索できるようにすることで、冷蔵庫にある材料から何を食べたいか考えられる。

## 実装予定の機能（以下の例は実際のアプリの機能から一部省略しています）
	【MVPリリース】
　・非ログインユーザー
		ログイン機能
		ユーザーの新規作成機能
		他のユーザーの投稿一覧を見れる

　・ログインユーザー（非ログインユーザーの機能からのプラス機能）
	  食べたいを投稿するためのCRUD機能
		投稿へのお気に入り機能
    自分の投稿一覧を見れる
		お気に入り一覧を見れる
	
	【本リリース】
　・非ログインユーザー
    食材から料理を検索できる（APIを利用）
		投稿検索機能

　・ログインユーザー（非ログインユーザーの機能からのプラス機能）
		プロフィール編集機能
		投稿へのコメント機能
		パスワードリセット機能

　・管理ユーザー
    ユーザー管理(一覧・詳細・編集・削除)
    投稿管理(一覧・詳細・編集・削除)

　・非機能面
    レスポンシブ対応
    コメント投稿削除の非同期通信

## なぜこのサービスを作りたいのか？
　毎日食事のメニューを考え作ってくれる人に感謝をしつつも、メニューを決められず申し訳ない気持ちになる。家族の日々出る悩みから解放する手助けをしたい。

## スケジュール
  企画〜技術調査：1/7〆切
  README〜ER図作成：1/14 〆切
  メイン機能実装：1/14 - 2/18
  β版をRUNTEQ内リリース（MVP）：2/18〆切
  本番リリース：3/4