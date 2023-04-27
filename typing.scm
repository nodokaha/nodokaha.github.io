(define (tictactoe)
  (letrec ((game-map '("1" "2" "3" "4" "5" "6" "7" "8" "9")) (print-board (lambda (gmap) (begin (display (list "----------\n|" (car gmap) "|" (cadr gmap) "|" (caddr gmap) "|")))(if (null? (cdddr gmap)) (begin  (display "------------") (newline)) (print-board (cdddr gmap))))) (update (lambda (num mark) (letrec ((nth-write (lambda (n m nlist) (let loop ((x 0)(nlist nlist)) (if (= x n) (apply list m (cdr nlist)) (cons (car nlist) (loop (+ x 1) (cdr nlist)))))))) (set! game-map (nth-write num mark game-map)) (print-board game-map)))) (check (lambda (mark) (call/cc (lambda (return) (letrec ((check-iter (lambda (mark check-map) (apply string=? (cons mark (map (lambda (x) (list-ref game-map x)) check-map)))))) (let loop ((check-map '((0 1 2)(3 4 5)(6 7 8)(0 3 6)(1 4 7)(2 5 8)(0 4 8)(2 4 6)))) (if (null? (cdr check-map)) (check-iter mark (car check-map)) (begin (if (check-iter mark (car check-map)) (return #t) (loop (cdr check-map))))))))))) (enemy_ai草ww (lambda (gmap mark) (let ((enemy-map (filter string->number gmap))) (update (- (string->number (list-ref enemy-map (random-integer (length enemy-map)))) 1) mark)))) (mark (if (eq? (random-integer 2) 1) (begin (display "貴方が先行です!\n") (print-board game-map) "○") (begin (display "貴方が後攻です!\n") (enemy_ai草ww game-map "○") "×"))) (user-input ""))
      (let main ()
      (if (null? (filter string->number game-map))
	  (display "draw!\n")
	  (begin
	    (let loop ()
	    ;; (set! user-input (read))
	    ;; (if (and (number? user-input) (positive? user-input) (< user-input 10) (not ((lambda (x) (or (car x) (cadr x))) (map (lambda (i) (string=? i (list-ref game-map (- user-input 1)))) '("○" "×")))))
	    ;; 	(update (- user-input 1) mark)
	      ;; 	(begin (display "please You can put 0~9 number: ") (loop))))
	      (enemy_ai草ww game-map mark)
	    (cond ((check mark) (display "You win!\n"))
		  ((check (if (string=? "○" mark) "×" "○")) (display "You lose!\n"))
		  (else (enemy_ai草ww game-map (if (string=? "○" mark) "×" "○"))(timer (lambda () (main)) 1)))))))
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


(define (typing-game)
  (toggle-canvas)
  (toggle-canvas)
  (js-invoke ctx "fillRect" 0 0 10 10)
  (js-set! ctx "font" "30px Arial")
  (js-invoke ctx "fillText" "タイピングゲームへようこそ!" 10 50)
  (timer (lambda ()
	   (begin
	     (js-invoke ctx "clearRect" 0 0 500 500)
	     (js-invoke ctx "fillText" "タイピングゲームへようこそ!" 10 50)
	     
	     (toggle-tcanvas)
	     (toggle-tcanvas)
	     (js-set! tctx "font" "30px Arial")
	     (js-invoke tctx "fillText" "サンプルテキストです" 10 80)
	     (js-invoke tctx "fillText" "SANPURUTEKISUTODESU" 10 110)
	     (set! typing-text (string->list "SANPURUTEKISUTODESU"))
	     (typing))) 3))

(define type-char 13)
(define msg-x 10)
(define typing-text (string->list "KONNNITIHA"))
(define (keydown ev)
	     (let ((code (js-ref ev  "keyCode")))
	       (js-invoke tctx "clearRect" msg-x 140 (+ 50 msg-x) 230)
	       (js-invoke tctx "fillText" (string (integer->char code)) msg-x 180)
	       ;; (js-invoke tctx "fillText" (list->string typing-text) 10 330)
	       ;; (wait-for (js-eval "document.body") "keydown")
	       (set! type-char code)
	       (if (eq? (integer->char code) (car typing-text))
		   (begin (display "collect")(set! msg-x (+ msg-x 20))(set! typing-text (cdr typing-text)))
		   (display "bad"))
	       (display type-char)))
;; (if (string=? (string (integer->char code)) (string (car strlist))) (display "collect") (display "bad"))
(define (typing)
  (add-handler! (js-eval "document.body") "keydown" keydown)
  (display "start!"))
;;   (let loop ((msg-x 0)(strlist (string->list msg))(type-char type-char))
;;     ;; (wait-for (js-eval "document.body") "keypress")
;;     ;; (wait-for (js-eval "tcanvas") "keypress")
;;     (display type-char)
;;     (if (eq? (integer->char type-char) (car strlist))
;; 	(display "collect")  (timer (lambda () (display "bad") (loop 0 strlist type-char)) 0.1))))
  ;; (define (alert-msg) (alert "hello"))
;; (add-handler! (js-eval "document.getElementById('show')") "animationend" alert-msg)
;; (define (dorakue)
;;   (js-invoke 
(define (say msg) (if (> msg-y 350) (begin (set! msg-y 40) (toggle-tcanvas)(toggle-tcanvas)) (set! msg-y (+ msg-y msgy-plus))) (js-set! tctx "font" "15px Arial") (js-invoke tctx "fillText" msg 10 msg-y))
(define (chara-say msg) (let ((msgy-plus 20)) (if (> msg-y 350) (begin (set! msg-y 40) (toggle-tcanvas)(toggle-tcanvas)) (set! msg-y (+ msg-y msgy-plus))) (js-set! tctx "font" "15px Arial") (js-invoke tctx "fillText" msg 10 msg-y)))

(define (type msg)
  (if (> (+ msg-y 50) (element-height (js-eval "tcanvas"))) (set! msg-y 50) (set! msg-y (+ msg-y 25)))
  (let ((msg-y msg-y)(time-sec 0.0125)(num '()))
    (let loop ((msg-x 0)(strlist (cons #\▼ (string->list msg))))
      (js-set! tctx "font" "15px Arial")
      (js-invoke tctx "clearRect" 0 msg-y (element-width (js-eval "tcanvas")) (+ msg-y 25))
      (js-invoke tctx "fillText" (string (car strlist)) msg-x msg-y)
      (if (> msg-x (element-width (js-eval "term")))
	  (begin (if (> (+ msg-y 30) (element-height (js-eval "tcanvas")))
		     (begin (set! msg-y 0) (timer (lambda ()  (loop (+ msg-x 20) (cdr strlist))) 3))
		     (set! msg-y (+ msg-y 20)))
		 (timer (lambda () (loop 0 (cdf strlist))) 0.0125))
	  (if (null? (cdr strlist))
	      (if (> (+ msg-y 20) (element-height (js-eval "tcanvas")))
		  (begin (set! msg-y 0)(timer (lambda ()  (loop 0 (cdr strlist))) 3))
		  (begin (set! msg-y (+ msg-y 15)) (set! timer-lock #f)))
	      (timer (lambda () (loop (+ msg-x 15) (cdr strlist))) 0.0125))))
    ))

(define (type-nowait msg) (set! msg-y (+ msg-y 20)) (let loop ((msg-x 0)(strlist (cons #\▼ (string->list msg)))) (js-set! tctx "font" "15px Arial") (js-invoke tctx "clearRect" 0 msg-y (element-width (js-eval "tcanvas")) (+ msg-y 10)) (js-invoke tctx "fillText" (string (car strlist)) msg-x msg-y) (if (> msg-x (element-width (js-eval "term"))) (begin (if (> (+ msg-y 30) (element-height (js-eval "tcanvas"))) (begin (set! msg-y 0) (timer (lambda ()  (loop (+ msg-x 15) (cdr strlist))) 3)) (set! msg-y (+ msg-y 15))) (timer (lambda () (loop 0 (cdf strlist))) 0.0125)) (if (null? (cdr strlist)) (if (> (+ msg-y 20) (element-height (js-eval "tcanvas"))) (begin (set! msg-y 0)(timer (lambda ()  (loop 0 (cdr strlist))) 3)) (set! msg-y (+ msg-y 15))) (timer (lambda () (loop (+ msg-x 15) (cdr strlist))) 0.0125)))))

(define music (js-new "Audio" "audio/BW1043cleartempup.wav"))
(define (music-play) (begin (js-invoke music "play") (js-set! music "loop" #t)))
(define (music-pause) (js-invoke music "pause"))
(define canvas (js-eval "document.getElementById('canvas')"))
(define ctx (js-invoke canvas "getContext" "2d"))

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
  '(""))

(define (user-input) 
  (let ((msg (read (current-input-port)))) 
    (if (symbol? msg) (symbol->string msg) 
        (if (number? msg) (number->string msg) 
            (begin (display "Error") (user-input))))))


(define (toggle-canvas) (begin (element-toggle! (js-eval "canvas")) (js-set! canvas "width" (element-width (js-eval "term")))))

(define tcanvas (js-eval "document.getElementById('tcanvas')"))
(define tctx (js-invoke tcanvas "getContext" "2d"))
(define (toggle-tcanvas) (begin (element-toggle! (js-eval "tcanvas")) (js-set! tcanvas "width" (element-width (js-eval "term")))))

(define msg-y 40)

(define msgy-plus 40)
(define kback (js-new "Image"))
(js-set! kback "src" "background/kback.png")
(define img (js-new "Image"))
(js-set! img "src" "images/image.png")
(define four-img (js-new "Image"))
(js-set! four-img "src" "images/IMG_0192.png")

(define (quize-game)
  (music-play)
  (toggle-canvas)
  (toggle-canvas)
  (js-invoke ctx "fillRect" 0 0 10 10)
  (js-set! ctx "font" "30px Arial")
  (js-invoke ctx "fillText" "クイズゲームへようこそ!" 10 50)
  (timer (lambda ()
	   (begin
	     (js-invoke ctx "clearRect" 0 0 500 500)
	     (js-invoke ctx "fillText" "問題!" 10 50)	     
	     (toggle-tcanvas)
	     (toggle-tcanvas)
	     (js-set! tctx "font" "30px Arial")
	     (js-invoke tctx "fillText" "サンプル問題です!" 10 30)
	     ;; (js-invoke tctx "drawImage" kback 0 0 (element-width (js-eval "tcanvas")) (element-height (js-eval "tcanvas")))
	     ;; (js-invoke tctx "drawImage" img 100 110 300 300)
	     (js-invoke tctx "fillText" "1+1は？!" 70 60))) 1))

(define (gameover)
  (toggle-canvas)
  (toggle-canvas)
    (js-invoke ctx "fillRect" 0 0 10 10)
  (js-set! ctx "font" "30px Arial")
  (js-invoke ctx "fillText" "ゲームオーバー!" 10 50))

(define (game-init)
  (call/cc (lambda (return)
	     (begin
	       (music-play)
	     (toggle-canvas)
	     (toggle-tcanvas)


	     
	     (js-set! ctx "font" "30px Arial")
	     (js-invoke ctx "fillText" "ゲームタイトル" 10 50)
	     (js-invoke ctx "fillText" "プロローグ(クリックして進んでね!)" 10 100)

	     (type "ようこそ。今日は苫小牧高専５７回目の高専祭ですよ！")


	     (type "え？コーセンって何って？")


	     (type "高専というのは、第二次世界大戦後の学制改革による混乱のまま")

	     (type "高度経済成長期に突入し技術者不足に見舞われた日本が")

	     (type "産業界からの要求に応えるべく中学卒業者を対象に")

	     (type "５年一貫の技術教育を提供する学校なんですよ。")


	     (type "え？長いって？")

	     (type "簡単に言えば、頭のいい人がいっぱいいるところです！")

	     (type "学生も教員もめちゃくちゃ数学できます！")

	     (type "英語論文も読めちゃいます！")

	     (type "わが校の教育理念は「技・徳・体」")

	     (type "これは玄関で額縁に入れて掲げられています。")

	     (type "開校から60年間、先輩から私たちに連綿と\n受け継がれてきた大切な理念です。")

	     (type "しかし繁栄を極めたローマ帝国も滅んだようにいかなるものも腐敗し")

	     (type "没落していきます。")

	     (type "わが校も「技・技・技」もしくは「体・体・体」で徳を失い")

	     (type "中庸を欠き始めていることは否めません。")

	     (type "あなたも気を付けてください。")

	     (type "もしかすると危険な高専生に絡まれて人として大切なものを失うかもしれません。")

	     (type "click!")

	     (clear)
	     (toggle-canvas)
	     (toggle-canvas)
	     (toggle-tcanvas)
	     (toggle-tcanvas)
	     (set! msg-y 0)
	     (js-set! ctx "font" "30px Arial")
	     (js-invoke ctx "fillText" "始まりの物語!(アニメーション予定)" 10 50)

	     (type "ナレーション<主人公は高専祭に来ており廊下を歩いていました。>")


	     (type "主人公：さあて、今日はせっかくの学祭だし、回るか。")


	     (type "ナレーション<めんどくさそうに、学祭のブースを回っている主人公>")


	     (toggle-canvas)
	     (toggle-canvas)
	     (js-set! ctx "font" "30px Arial")
	     (js-invoke ctx "fillText" "<<突然何者かが>>" 10 50)
	     (js-invoke ctx "fillText" "<<主人公に話しかけてきた>>" 10 80)
	     (wait-for (js-eval "tcanvas") "click")
	     (toggle-canvas)
	     (toggle-canvas)
	     (js-set! ctx "font" "30px Arial")
	     (js-invoke ctx "fillText" "危険な高専生１" 10 50)
	     (type "危険な学生１(仮四六時中パソコンに没頭している学生)")

	     (type "<俺たちは近代の原始人計算できればそれでいい")

	     (type "ところでお前これ解ける？解けなければお前は、古代の原始人だ。>")

	     (toggle-canvas)
	     (toggle-canvas)
	     (toggle-tcanvas)
	     (toggle-tcanvas)
	     (wait-for (js-eval "tcanvas") "click")
	     (js-invoke tctx "drawImage" kback 0 0 (element-width (js-eval "tcanvas")) (element-height (js-eval "tcanvas")))
	     (js-invoke tctx "drawImage" img (/ (element-width (js-eval "tcanvas")) 3) (/ (element-height (js-eval "tcanvas")) 4) 300 300)
	     (wait-for (js-eval "tcanvas") "click")
	     (quize-game)
	     (music-pause)
	     
	     (let ((usertext (user-input)))
	       (cond ((string=? usertext "2") (toggle-tcanvas)(toggle-tcanvas)(js-set! tctx "font" "30px Arial")(js-invoke tctx "fillText" "正解!" 0 40)(type "危険な高専生１:ふん、じゃあ次は、これだ"))
		     (else (toggle-tcanvas)(toggle-tcanvas)(js-set! tctx "font" "30px Arial")(js-invoke tctx "fillText" "不正解" 0 40)(type "危険な学生１:おいおい、式を雑に扱うな。ニュートンに祟られるぜ。 ")(type "主人公：ちーん")(type "ナレーション：主人公はメンタルが破壊され、人として大切なものを失った。")(return (gameover)))))
	     (quize-game)
	     (music-pause)
	     (let ((usertext (user-input)))
	       (cond ((string=? usertext "2") (toggle-tcanvas)(toggle-tcanvas)(js-set! tctx "font" "30px Arial")(js-invoke tctx "fillText" "正解!" 0 40)(type "危険な学生１:なかなか、やるじゃないか、またな。")(type "ナレーション：学生はそう言いCTFを解きながら去っていった"))
		     (else (toggle-tcanvas)(toggle-tcanvas)(js-set! tctx "font" "30px Arial")(js-invoke tctx "fillText" "不正解" 0 40)(type "危険な学生１:おいおい、式を雑に扱うな。ニュートンに祟られるぜ。 ")(type "主人公：ちーん")(type "ナレーション：主人公はメンタルが破壊され、人として大切なものを失った。")(return (gameover)))))

	     (clear)
	     (toggle-canvas)
	     (toggle-canvas)
	     (toggle-tcanvas)
	     (toggle-tcanvas)
	     (set! msg-y 0)
	     (js-set! ctx "font" "30px Arial")
	     (js-invoke ctx "fillText" "「主人公はなんとか解けた。」" 10 50)

	     (toggle-canvas)
	     (toggle-canvas)
	     (toggle-tcanvas)
	     (toggle-tcanvas)
	     (set! msg-y 0)
	     (js-set! ctx "font" "30px Arial")
	     (js-invoke ctx "fillText" "始まりの物語" 10 50)
	     (type "主人公：変人に絡まれたけど、なんとかなったな。")
	     (type "ナレーション：そうして、主人公が、再度廊下を歩き出し、学祭の新たなブースに行こうとした時")
	     (toggle-canvas)
	     (toggle-canvas)
	     (toggle-tcanvas)
	     (toggle-tcanvas)
	     (set! msg-y 0)
	     (js-set! ctx "font" "30px Arial")
	     (js-invoke ctx "fillText" "目の前に屈強な男(仮)が現れた。" 10 50)
	     (type "屈強な男:ウェーイ")
	     (type "毎日筋トレに励んでいる、脳まで筋肉な屈強な男が現れた。")
	     (js-invoke tctx "drawImage" kback 0 0 (element-width (js-eval "tcanvas")) (element-height (js-eval "tcanvas")))
	     (js-invoke tctx "drawImage" four-img (/ (element-width (js-eval "tcanvas")) 3) (/ (element-height (js-eval "tcanvas")) 4) 300 300)
	     (wait-for (js-eval "tcanvas") "click")
	     (js-set! tctx "font" "20px Arial")
	     (let loop
				   ((msg '("「ミス！相手の腹筋がすごくてダメージをあたえられない!」"
					   "「ミス！相手の上腕二頭筋がすごくて効果がない!」"
					   "「ミス！相手の鍛え上げられた大胸筋によって弾かれた!」")))
				 (toggle-tcanvas)
				 (toggle-tcanvas)
				 (set! msg-y 0)
				 (js-set! tctx "font" "50px Arial")
				 (say "1：こうげき")
				 (say "2：まもる")
				 (let ((usertext (user-input)))
				   (cond
				    ((string=? usertext "1")
				     (toggle-tcanvas)
				     (toggle-tcanvas)
				     (js-set! tctx "font" "30px Arial")
				     (js-invoke tctx "fillText" "ミス!" 0 40)
				     (type (car msg)))

				    (else
				     (toggle-tcanvas)
				     (toggle-tcanvas)
				     (js-set! tctx "font" "30px Arial")
				     (js-invoke tctx "fillText" "ゲームオーバー" 0 40)
				     (type "「だめだ、筋肉によって押し潰された」")
				     (return (gameover)))))
				 (if (null? (cdr msg))
				     (let subloop  ((msg '("開発者の声：ちょっとまずったな。敵を強くしすぎた。"
							   "ちょっとずるだが"
							   "仕方ない")))
				       (if (null? (car msg))
					   (begin
					     (toggle-canvas)
					     (toggle-canvas)
					     (js-set! ctx "font" "30px Arial")
					     (js-invoke ctx "fillText" (car msg) 0 40))
					   (timer (lambda ()
						    (toggle-canvas)
						    (toggle-canvas)
						    (js-set! ctx "font" "30px Arial")
						    (js-invoke ctx "fillText" (car msg) 0 40)
						    (subloop (cdr msg))) 2)))
				     (loop (cdr msg))))
	     (wait-for (js-eval "tcanvas") "click")
	     (typing-game)
	     (let loop () (if (null? typing-text) (type "hello world") (begin (wait-for (js-eval "tcanvas") "click") (loop))))
	     (type "foobar")
	     ;; (remove-handler! 




	     
	       ;; 	     (let loop
	       ;; 	      ((msg '(11100011 10000001 10010011 11100011 10000010 10010011 11100011 10000001 10101010 11100110 10010110 10000111 11100111 10101011 10100000 11101000 10101010 10101101 11100011 10000010 10010011 11100011 10000001 10100111 11100011 10000010 10001011 11100110 10011010 10000111 11100011 10000001 10000010 11100011 10000010 10001011 11100011 10000001 10101110 11101111 10111100 10011111)))

	       ;; (if (null? (car msg))  (begin (toggle-tcanvas) (toggle-canvas)) (timer (lambda ()  (display (list (car msg)))(toggle-tcanvas) (toggle-canvas) (loop (cdr msg))) 0.01)))
	     ;; (tictactoe)
	     

	     ))))
(game-init)
(display "restart?")
