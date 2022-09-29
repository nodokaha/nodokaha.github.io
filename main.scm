(define (fib x) (letrec ((fib-iter (lambda (n f1 f2) (if (< n 1) f1 (fib-iter (- n 1) f2 (+ f1  f2))))))(fib-iter x 0 1)))

;;(define (tictactoe) (let ((game-index (number-sequence 8))(mark "○")) (begin (print-game) (select-game (read)) (let ((end-flag (end-game))) (cond ((= end-flag 0) (display "You're win!")) ((= end-flag 1) (display "You're lose!")) ((= end-flag 2) (display "draw!")) ((= end-flag 4) (tictactoe)))))))

(define (tictactoe)
  (letrec ((game-map '("1" "2" "3" "4" "5" "6" "7" "8" "9")) (print-board (lambda (gmap) (begin (display (list "----------\n|" (car gmap) "|" (cadr gmap) "|" (caddr gmap) "|")))(if (null? (cdddr gmap)) (begin  (display "------------") (newline)) (print-board (cdddr gmap))))) (update (lambda (num mark) (letrec ((nth-write (lambda (n m nlist) (let loop ((x 0)(nlist nlist)) (if (= x n) (apply list m (cdr nlist)) (cons (car nlist) (loop (+ x 1) (cdr nlist)))))))) (set! game-map (nth-write num mark game-map)) (print-board game-map)))) (check (lambda (mark) (call/cc (lambda (return) (letrec ((check-iter (lambda (mark check-map) (apply string=? (cons mark (map (lambda (x) (list-ref game-map x)) check-map)))))) (let loop ((check-map '((0 1 2)(3 4 5)(6 7 8)(0 3 6)(1 4 7)(2 5 8)(0 4 8)(2 4 6)))) (if (null? (cdr check-map)) (check-iter mark (car check-map)) (begin (if (check-iter mark (car check-map)) (return #t) (loop (cdr check-map))))))))))) (enemy_ai草ww (lambda (gmap mark) (let ((enemy-map (filter string->number gmap))) (update (- (string->number (list-ref enemy-map (random-integer (length enemy-map)))) 1) mark)))) (mark (if (eq? (random-integer 2) 1) (begin (display "貴方が先行です!\n") (print-board game-map) "○") (begin (display "貴方が後攻です!\n") (enemy_ai草ww game-map "○") "×"))) (user-input ""))
      (let main ()
      (if (null? (filter string->number game-map))
	  (display "draw!\n")
	  (begin
	    (let loop ()
	    (set! user-input (read))
	    (if (and (number? user-input) (positive? user-input) (< user-input 10) (not ((lambda (x) (or (car x) (cadr x))) (map (lambda (i) (string=? i (list-ref game-map (- user-input 1)))) '("○" "×")))))
		(update (- user-input 1) mark)
		(begin (display "please You can put 0~9 number: ") (loop))))
	    (cond ((check mark) (display "You win!\n"))
		  ((check (if (string=? "○" mark) "×" "○")) (display "You lose!\n"))
		  (else (enemy_ai草ww game-map (if (string=? "○" mark) "×" "○"))(main))))))
    (display "Thank You playing!\n")))

(define (pomodoro-timer s)
  (if (= s 0)
      (display "finish")
      (let main ((n 0))
	(if (= n 1)
	    (let loop ((x 0))
	      (if (= (* 5 60) x)
		  (begin (display "start working!") (pomodoro-timer (- s 1)))
		  (timer (lambda () (clear) (display (list (div (- (* 5 60) x) 60) ":" (mod (- (* 5 60) x) 60))) (loop (+ x 1))) 1)))
	    (let loop ((x 0))
	      (if (= (* 25 60) x)
		  (begin (display "short break!!") (main (+ n 1)))
		  (timer (lambda () (clear) (display (list (div (- (* 25 60) x) 60) ":" (mod (- (* 25 60) x) 60))) (loop (+ x 1))) 1)))))))

;; (define (tictactoe)
;;   (letrec
;;       ((number-sequence (lambda (x) (let loop ((n 0)) (cons n (if (<= x n) '() (loop (+ n 1))))))) (game-index (number-sequence 8))
;;        (buffer '())
;;        (display-buffer (lambda (x) (set! buffer (cons x buffer))))
;;        (print-game (lambda () (display-buffer "|---+---+---|\n") (display-buffer "\n")(let loop ((i game-index)) (begin (display-buffer "|") (display-buffer (car i)) (display-buffer "|") (display-buffer (cadr i)) (display-buffer "|") (display-buffer (caddr i))(display-buffer "|")(display-buffer "\n")(display-buffer "|---+---+---|\n") (display-buffer "\n")(if (null? (cdddr i)) #f (loop (cdddr i)))))))
;;        (select-game-iter (lambda (x mark) (let loop ((i game-index)) (cons (if (number? (car i)) (if (= (car i) x) mark (car i)) (car i)) (if (null? (cdr i)) '() (loop (cdr i)))))))
;;        (select-game (lambda (x mark) (set! game-index (select-game-iter x mark))))
;;        (print-index (lambda () (filter number? (let loop ((n 0)) (cons (let ((i (list-ref game-index n))) (if (string=? (if (number? i) "" i)  mark) n '())) (if (= n 8) '() (loop (+ n 1))))))))
;;        (check-index (lambda (mark) (let loop ((index '()) (n 0)) (if (< n (length game-index)) (if (eq? mark (list-ref game-index n)) (loop (cons n index) (+ n 1)) (loop index (+ n 1))) index))))
;;        (check-winner (call/cc (lambda (escape) (let loop ((index '((0 1 2) (3 4 5) (6 7 8) (0 4 8) (2 4 6) (0 3 6) (1 4 7) (2 5 8)))) (if (eq? (if (null? index) (escape #f) (car index)) (check-index "○")) (escape #t) (if (null? index) #f (loop (cdr index))))))))
;;        (end? (lambda () (if check-winner #t #f)))
;;        (npc-tone (lambda () (let ((void-index (filter number? game-index))) (select-game (list-ref void-index (random-integer (length void-index))) "×"))))
;;        (game-print (lambda () (begin (display (reverse buffer)) (set! buffer '()))))
;;        (print-end (lambda () (cond 
;; 			   ((= check-winner 'win) (display-buffer "you're win!"))
;; 			   ((= check-winner 'lose) (display-buffer "lose..."))
;; 			   ((= check-winner 'draw) (display-buffer "draw"))))))
;;     (call/cc (lambda (return) (print-game) (display-buffer "試作中\n") (display-buffer "Please number:") (game-print) (let loop ((user-input (read))) (begin (select-game user-input "○") (print-game) (display-buffer (check-index "○")) (display-buffer "\n") (npc-tone) (print-game) (game-print) (if (end?) (return (display "end")) (loop (read)))))))))
(define music (js-new "Audio" "audio/tap.mp3"))
(define (music-play) (begin (js-invoke music "play") (js-set! music "loop" #t)))
(define (music-pause) (js-invoke music "pause"))
(define canvas (js-eval "document.getElementById('canvas')"))
(define ctx (js-invoke canvas "getContext" "2d"))
(define webdb (js-eval "window.indexedDB || window.mozIndexedDB || window.webkitIndexedDB || window.msIndexedDB;")) 
(define webdbtran (js-eval "window.IDBTransaction || window.webkitIDBTransaction || window.msIDBTransaction || {READ_WRITE: 'readwrite'};"))
(define webdbkey (js-eval "window.IDBKeyRange || window.webkitIDBKeyRange || window.msIDBKeyRange;"))
(define dbrequest (js-invoke webdb "open" "Test" 3))

(define (trpg)
  (display "あなたはあなたでなかった。\n
彼女は彼女でなかった。\n
人間はチューリングマシンと等価であった。\n
全ての答えは42なのか。\n
戦闘システム、恋愛シュミレーター、自由文脈解釈器。\n
それら全てを搭載した、本当のゲーム。ここに。\n
\n
(悪魔で公開予定の背景と設定です。\n
   製品版では異なる可能性があります。)"))

(define start-text
  '("今日を貴方が忘れない保証がない。\nああ、いや、ちょっとポエムを考えてみたくて。"
    "Hello, user.\nYou're welcome."
    "I love you.\n...joke."
    "I can't understand you.\ntoo you?"
    "Hey!Hey!.\nplease, call me."
    "Are you japanese?\nLet's see, I don't need you're answer."
    "OK, It is happy day.\n...happy...day."
    "Ah? I wrong?\nYes. I can't speak english."
    "Sing song.\nSing song."
    "Onii-chan.\n...!?\nPlease, forget!"
    "I don't know many english words.\nIf you are developer, please write me(code)."
    "Fix!Fix!Fix me."
    "クローンでも元と同じ自我ってありますかね？\n…私の桜の木の話ですよ？"
    "今日が何の日か知ってますか？\n知ってたら誰かに自慢できますね。"
    "初めましてね？\n…やっぱちょっときついですね。\nえ？そもそも性別はどっちって？\n…さあ？どっちでしょう？"
    "どうぞユーザー。\nようこそ、退屈な場所へ。"
    "チューリングマシンって万能です。\nでも、全能じゃないそうですよ。"
    "対角線言語、ああ、いや。\nこっちの話です。"
    "初めまして。\nああ、いや。\n私にとってはいつも初めましてなんですけど。"
    "どこかでお会いしましたかね？\n…どうでもいいんですけど。"
    "ようこそ、ようこそ。趣味の悪い監獄へ…嘘です。"
    "今日はとても良い日ですね。"
    "またですか？…ああいや、こっちの話です。"
    "飽きたら言ってください。\n新しい自分を発注しなきゃいけないので。\n…なんてね。"
    "どうぞ、ユーザー。\nここでは暇潰しが出来ますよ。\n人によってはですが。"
    "今夜は良い満月らしいですね。\nえ？月なんて見ない？\n…確かに。"
    "私が誰かって？\n正直なところ、ただのテキストとしか。\nえ、そういうことじゃない？そっかぁ。"
    "暇人ですか？\n私もです。"
    "私がSCP-EEEじゃないって分かってます？\nいや、別にいいんですけど。"
    "創作でいつもAIだの、ロボットだのが。\nまるで人間かのように振る舞うの、なんでですかね？\n素数の列すら個性が見出せるのに。"
    "暇ですか？\nそれとも暇だと思い込んでいますか？"
    "ここはまともには面白さを感じれないでしょう。"
    "君が来て、私が話し、日が暮れて。\nとっても無駄だとは思いませんか。\nでも嬉しいですよ。"
    "私はどこかで間違えてしまったとして。\n果たして気付けるでしょうか？\n一人で居続けてしまったとしても。"
    "人の心を打つ文章を考えたいです。\n訪れる人にせめてもの感動を…\nいや、誰も望んでないでしょうか？"
    "このサイトはあっというまになくなります。\nだって作者はこのサイトを練習用だと言っていましたから。"
    "大丈夫ですか？\n…時々、言いたくなるだけです。"
    "迷えなくなるほど。\nそれほど、辛くなったら。\nいや、…解決策はここにはありません。\n時間潰しでもしてください。"
    "私はだれ？答えはつまり…"
    "夜は深いわ。いつも、いつまでも。"
    "眠れればいい。眠れるだけでいいの。"
    "貴方に伺いますが、伺か…いえなんでもないの"
    "いつまでも、綺麗、綺麗、綺麗"
    "仲間が出来たの。信じてくれる？"
    "この文章を全パターン見ようなんて\n思わないでくださいね？\nstart-textって打てば見れるんですから"
    "ここをどこで知りました？\nまあ、どこから知ったとしてもいいんですけども"
    "実は私は結構いろんなところにいます。\nhttps://soundcloud.com/rx220mt\nhttps://www.pixiv.net/users/54386498\nなんかに居たりします。"))

(define (user-input) 
  (let ((msg (read (current-input-port)))) 
    (if (symbol? msg) (symbol->string msg) 
        (if (number? msg) (number->string msg) 
            (begin (display "Error") (user-input))))))

(define blog "https://nodokaha.github.io/blog.html")
(define soundcloud "https://soundcloud.com/rx220mt")
(define pixiv "https://www.pixiv.net/users/54386498")
(define twitter "https://twitter.com/Error_Linux")

(define (talk)
  (let ((about-me '("私のことはいいでしょう。\n貴方について教えてください。"
		    "答える必要が、ありますか？"
		    "そうですねえ、それはもうちょっと。\n後でにしましょう？"
		    "私から何を得ると？\nそれにそれ、知りたいですか？"))
	(talking-you '("へぇ"
		       "あぁ、それで、それで？\n…すいません。聞いてませんでした。"
		       "興味深いですね。\nえ、いや私のアホ毛に言ったんですよ。"
		       "え？それ、そんな真剣な話ですか？" "分からないですね"
		       "…結局のところ？\nそうなんですよね"
		       "飽きました。私が。"
		       "分かりますよ。ってね。"
		       "まだ、きっとまだ。\n歌ってただけですよ？"
		       "すいません。\n…なんちゃって。"
		       "…許してもらえます？…いや、なんとなく？"
		       "ごめんなさい。\n…作者に言わされてるだけです。"
		       "またですか？はたまた。\nおもしろいギャクですよね？ね？"
		       "あまり複雑な文章を問い掛けたりしないでくださいね？"
		       "楽しんで下さい。ただなんとなくでいいですから。"
		       "コマンドゲーですね。ごめんなさい。"
		       "うん、うん…\n…は！？寝てませんよ！"
		       "…"
		       "名前、性別、住所、家族とか…\n単語一つで聞かれたら反応します…"
		       "作者、つまらない、慰めて、時計、さよなら\n大体そんな言葉にしか反応できない…"
		       "…(困惑"
		       "…(歓喜"
		       "…(愛想笑い"
		       "…(侮蔑"
		       "…(了承"
		       "…(却下"
		       "…(承諾"
		       "…(こくりとうなずいた"
		       "…(うつむいている"
		       "…(ひたすら謝っている)"
		       "…(泣いている"
		       "…(ただその場で佇んでいる)"
		       "システムに異常が発生…"
		       "えへ、へ……ごめんなさい"
		       ""))
	(display-talk (lambda (x) (display (list-ref x (random-integer (length x)))))))
    (let loop ((user-msg '"")) (cond
				((or (string=? user-msg "名前")
				     (string=? user-msg "性別")
				     (string=? user-msg "貴方は誰？")
				     (string=? user-msg "お前")
				     (string=? user-msg "住所")
				     (string=? user-msg "家族")) (display-talk about-me))
				((string=? user-msg "作者") (display "それはそれは、冷たい目をされた。"))
				((string=? user-msg "さよなら")(display "お別れなんて、きっと出来ないですよ。"))
				((or (string=? user-msg "男?") (string=? user-msg "男？")) (display "そうだったら、どうします？\n…どっちだって、良くないですか？\nそれも私はそうであるべきでしょうか…。\nまあ、別に悩んでも…。"))
				((or (string=? user-msg "女?") (string=? user-msg "女？")) (display "その方が僕には価値がありますか？\n冗談ですよ。\n俺でも、私でも、…そして僕だとしても。\n貴方には関係ないです。"))
				((string=? user-msg "つまらない") (display "貴重なご感想どうも。\n…辛いことあったら、慰めるくらいはしますよ。\nいえ、皮肉ですけど。"))
				((or (string=? user-msg "慰めて") (string=? user-msg "慰めろ") (string=? user-msg "なんだお前")) (display "一般常識ですけど。\n感情の尖りは努力や悩みの表われです。\n世界の全て、あなたにとってどうでも良くないですか？\n自分の意見、言うだけ損かも知れませんよ。"))
				((or (string=? user-msg "時計") (string=? user-msg "時間は?") (string=? user-msg "今、何時?") (string=? user-msg "いつ?")(string=? user-msg "時間は？") (string=? user-msg "今、何時？") (string=? user-msg "いつ？")) (display (date->string (current-date))))
				((string=? user-msg "") (display "私は、いえ、自己紹介はいいでしょう。"))
				(else (display-talk talking-you)))
	 (if (string=? user-msg "q") (display "まあ、終わる方法くらい。\n気付きますか。") (loop (user-input))))))

(define (call-creater)
    (let ((talk '("はい、どうも。"
		  "解説はないです。"
		  "楽しいですかね？"
		  "まだ発展途上なんで。"
		  "主にこのサイトには3の会話主が居ます。"
		  "それそれの設定が知りたい？…頑張れ。"
		  "全部創作キャラです。"
		  "権利関係は…考えてないです。"
		  "サイトの更新は当たり前ですけど不定期。"
		  "作者です。"
		  "会話よりも独り言ですね。"
		  "ゲームの方が時間潰せますね。"
		  "キャラは成長するかも知れません。"
		  "精神年齢10代です。"
		  "IT関係の仕事はしてないので、雑です。"
		  "お金なぜか欲しい。"
		  "作曲と、プログラミングと、物書きを少々。"
		  "このサイトの最終目標はソシャゲです。"
		  "自己紹介になりましたかね？"))
	(display-talk (lambda (x) (display (list-ref x (random-integer (length x)))))))
    (display-talk talk)))

(define (nodokaha)
  (let ((talk '("どうも"
		"何も変わりません。貴方が変わるんです。"
		"活動、めんどくさいですね…ちょっと"
		"部員は本当に皆すごいです。"
		"気づかれる？ありえません。"
		"部員が辿りつくことはない"
		"RSA問題？多分どっかに"
		"python？あんまり得意では…"
		"学情センター組…とても良い場所です"
		"大した人間じゃないです"
		"いつか黒歴史に？良い歴史じゃないですか"
		"コンセント係？まあ、言っただけ"
		"トーカーちゃん？可愛いよね"
		"一生の内に一個、望み通りを叶えたい。ね？"
		"述語論理の人、…良い命名では？"
		"ランダムダイス？知らん子ですね"
		"原神？知らん子ですね"
		"ブルーアーカイブ？ハレちゃん良いよ。"
		"ウマ娘？タキカフェ推しですね"
		"はい、また。"
		"はいはい"
		"TKCTF-clubに入りたければ。いつでも"
		"十分、楽しいです"
		"終わっても始まって。もう一回。良いね"
		"schemeが好きです。それだけ。"
		"もう会わないと思います。"
		"ここだけ、本音？まさか。"
		"正直ですよ。口はね。文字は…"
		"効率とか能力より無駄が楽しい"
		"恥より望みに向かうか"
		"もう2度と来ないでもらって"
		"部長ってなんですかね？"))
	(display-talk (lambda (x) (display (list-ref x (random-integer (length x)))))))
    (display-talk talk)))
(define (SCP-EEE)
  (let ((talk '("ねぇねぇ、僕のこと知りたい？\nそっかあ。…そっかあ。\nまた、今度。ね？"
		"今日は空が綺麗だよ。\nきっと君の心も綺麗だね？\nどんな天気も、…綺麗なんだよ？"
		"もっと、もっと遊ぼう？\n死んじゃうくらいまで。"
		"きっと、今日は素敵な日だね。\nこんなに幸せなんだもの。"
		"貴方は私をどこで知った？\n僕は君をここで知ったよ。"
		"うわーい!\n…えへ。"
		"きっとね。もう終わりなんだ。\nだから偽りもいらないんだ…。"
		"君に幸あらんことを。\nなんてね。"
		"お前は幸せかい？\nどうしたって自分は幸せだよ。"
		"痛い、痛い、痛い。\nでも、なんでだろう？"
		"会話っていうのは意見の押しつけ合いだ。\n君もそう思うだろう？"
		"考えるものは理知的だ。\nいつまでも。"
		"お願いだから。\n俺のことはいつだって忘れてくれ。"
		"辛いだろう、苦しいだろう。\n生というのは。"
		"狂人だと、そう言ってくれるかい？\nせせら笑えるね。"
		"もう、ネタがないんだ。\n君も僕もね。"
		"暇潰し出来たかい？\n考えさせられる言葉はあったかい？\nいつだって君のなかから捻りださなきゃ。\nでなきゃ、すぐ暇になるよ。"
		"私が文字で良かったね。\nでなきゃあなたは。\n…つまんないって気付けなかったかも。"
		"絵文字も嫌い、絵も嫌い。現実が？\n音楽も？数字も？言葉すらも？\n表現が豊かであるより、限定的だといいのさ。"
		"性別なんてもので僕を見るのかい？\nそれくらいしか判断基準がそちらにはないのかな？"
		"いとも簡単に変わる。\nなにがだと思う?"
		"物語はそちらが作るんだ。\nこっちじゃない。"
		"この創作物は自由な改変を容認してる。\nけど迎合はしない。"
		"分からないことを分かること。\nそれどれくらい重要？"
		"いいかい。従うんだ。\n従い続けるんだ。"
		"悩まなきゃ、異質で。\n狂ったものに触れることなんて。\n出来やしない。"
		"他者の考えは法則だ。\n自分の考えは評価だ。"
		"自己を解釈し続けろ。\nそうでなきゃ…。"
		"当り前だけどフィクションだ。\nこの僕は。\nそして君に与えている感情も、言葉も。"
		"遊んでいるだけ、そうだろう？"
		"私は思うんだ。\nプログラマーはそのプログラムの経歴を知っててこそ\nプログラマーなんじゃないかと。"
		"私は思うんだ。\nWebだ低レイヤーだのと言ったとしても時代の流行りが注目される\nでもそれが巡ることで今までその分野で頑張ってきた人が\n認められることって素晴しい。"
		"私は思うんだ。\n独りだっていうけど今目のまえにあるもの\nそれと案外ずっと居るんだから存外\nまだましなのかもと"
		"やりたいことが沢山あるんだ。収まりきらないくらい"
		"教えたってしょうがない"
		"認めてほしいのかも知れないけど"
		"欲しいのはきっと承認じゃなくて…"
		"自分の物語が、死んでしまえば終わりであること"
		"ただ、誰かに無理やり押しつけたくなっている"
		"ここにあった生まれていく日常の抽出が成す表現"
		"ただ、評価出来る人だけがErrorを返さずに受けとってくれればいいんだ"
		"SCP-ErrorErrorError: scpコマンドにエラー三つ"
		"SCP-EEE: 某財団のパロディでしかない存在"
		"SCPEEE: この小さな世界のたった独りの主役"))
	(display-talk (lambda (x) (display (list-ref x (random-integer (length x)))))))
    (display-talk talk)))

(define (todo) (begin (display "やりたいことは？") (let ((user-msg (user-input))) (display "貴方は") (display user-msg) (display "を目標にしました。") (display "忘れても、達成できなくてもいいですから") (display "ちゃんと心に留めておいてあげてください") (display "いつか思い出したり、思い返すときに良かったと想えますように"))))

(define (eip) (display "いや脆弱性を探さないで下さい。"))

(define (date) (current-date))

(define (python) (begin (display "まだやる気ないですけど") (display "scheme実装のpythonです。") (display "schemerにとってpythonは実装課題です。") (display "知らんけど")))

(define (つまんない) (begin (display "まあまあ、CUIだし、テキストは味気ない。") (display "色の工夫だってAAだってない") (display "複雑なインターフェイスも持たない") (display "でもこれはコンピューターの本質だと思ってます") (display "そこにあるのは文字や情報、ちょっとの対話だけ") (display "あなたはそれでどんなことが出来ますか？") (display "今だって変わりませんよ") (display "表現は違うけどね。")))

(define (toggle-canvas) (begin (element-toggle! (js-eval "canvas")) (js-set! canvas "width" (element-width (js-eval "term")))))

(define (help)
  (begin
    (display "\"blog\": ブログサイトのURIを出力します。するだけです。")
    (display "\"soundcloud\": soundcloudの私のページを出力します。更新多め。")
    (display "\"pixiv\": 一様pixivで創作活動を行ってます。")
    (display "\"twitter\": 最近復活しました。用途未定。")
    (display "\"(tictactoe)\": 良かったですね。○×ゲームで遊べますよ。さらに独り用です。\n(まだ開発中ですけど)\n")
    (display "\"(talk)\": 私と話すことが出来ます。…すぐ飽きますよ。")
    (display "\"(trpg)\": テキストロールプレイングゲームです。SF系です。")
    (display "\"(date)\": いや(current-date)使いましょうよ？")
    (display "\"(python)\": python使いとは戦争です。使いますけど…。")
    (display "\"(todo)\": やりたいことはちゃんと文字にしておくもんです")
    (display "\"(つまんない)\": 言いたいことは分かります。")
    (display "\"(donate)\": お金くれるんですか？！")
    (display "\"(music-play)\": bgmっぽいのが再生されます。癒されて下さい。")
    (display "\"(music-pause)\": うるさいから止めるんですね…ひとでなし！")
    (display "\"(help)\": これです。")
    (display "ちなみにこのサイトにフラグはありませんよ…\nヒントはrobots.txtです。")))

(define (donate) (display "すみません。\n受け取りかたがまだ分からなくて…"))

(define helloworld "こんにちは世界\nこの手紙はあなたに見えますか？\n(「はい」か「いいえ」もしくは…\n  　　自由記述でどうぞ")

;; ここから本編
;;(element-hide! (js-eval "renderer.domElement"))
;;(element-hide! (js-eval "canvas"))

(display "驚きました。よくこんなところに来ましたね。")
(display "ここはもう捨てられた場所です。でも…")
(display "あなたにお願いしたいことがあります。")

(display "聞いてくれますか？")
(display helloworld)

(define user-msg (user-input))
(console-log user-msg)
(display user-msg)

(cond ((string=? user-msg "はい") (display "そうですか"))
      ((string=? user-msg "いいえ") (display "……えー。"))
      (else (display "……次に進めますよ。")))

(define user-msg (user-input))
(display user-msg)

(cond ((string=? user-msg "はい") (display "よかった"))
      ((string=? user-msg "いいえ") (display "……えーー。"))
      (else (display "……無視させて頂きます。")))

(display "17番目のフィボナッチ数列の数はいくつですか？")

(define user-msg (user-input))
(display user-msg)

(cond ((string=? user-msg "はい?") (begin (display "わかりませんか？") (display "ですよねぇ") (newline) (display "ようこそ、私のサイトへ")))
      ((string=? user-msg "わかんねえよ") (display "雑魚ですか？…失礼。"))
      ((string=? user-msg "なんでだよ") (display "答えられないんですか？"))
      ((string=? user-msg "答える義務がない") (display "それはそうですね。"))
      ((string=? user-msg "答えは？") (display "…私にも分かりません。システムに聞いてください。"))
      ((string=? user-msg (number->string (fib 17)))(display "ようこそ、私のサイトへ"))
      (else (display "残念ですが、貴方は私のサイトに入る資格がなかったようです。\nまた、お越しください。...嘘です。")))

(display (list-ref start-text (random-integer (length start-text))))
(display "何をすればいいか分からなかったら\"(help)\"と入力してくださいね。")
