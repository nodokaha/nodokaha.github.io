(display "hello")
(define term (js-eval "document.getElementById('term')"))
(define (tictactoe)
  (letrec ((game-map '("1" "2" "3" "4" "5" "6" "7" "8" "9")) (print-board (lambda (gmap) (begin (display (list "----------\n|" (car gmap) "|" (cadr gmap) "|" (caddr gmap) "|")))(if (null? (cdddr gmap)) (begin  (display "------------") (newline)) (print-board (cdddr gmap))))) (update (lambda (num mark) (letrec ((nth-write (lambda (n m nlist) (let loop ((x 0)(nlist nlist)) (if (= x n) (apply list m (cdr nlist)) (cons (car nlist) (loop (+ x 1) (cdr nlist)))))))) (set! game-map (nth-write num mark game-map)) (print-board game-map)))) (check (lambda (mark) (call/cc (lambda (return) (letrec ((check-iter (lambda (mark check-map) (apply string=? (cons mark (map (lambda (x) (list-ref game-map x)) check-map)))))) (let loop ((check-map '((0 1 2)(3 4 5)(6 7 8)(0 3 6)(1 4 7)(2 5 8)(0 4 8)(2 4 6)))) (if (null? (cdr check-map)) (check-iter mark (car check-map)) (begin (if (check-iter mark (car check-map)) (return #t) (loop (cdr check-map))))))))))) (enemy_ai草ww (lambda (gmap mark) (let ((enemy-map (filter string->number gmap))) (update (- (string->number (list-ref enemy-map (random-integer (length enemy-map)))) 1) mark)))) (mark (if (eq? (random-integer 2) 1) (begin (display "貴方が先行です!\n") (print-board game-map) "○") (begin (display "貴方が後攻です!\n") (enemy_ai草ww game-map "○") "×"))) (user-input ""))
    (let main ()
      (call/cc (lambda (return)
	(if (null? (filter string->number game-map))
	    (cond ((check mark) (display "You win!\nHere you are flag!\nTKCTF{tictact0e}"))
		  ((check (if (string=? mark "○") "×" "○")) (display "You lose!\n"))
		  (else (display "draw!\n")))
	    (begin
	    (let loop ()
	    (set! user-input (read))
	    (if (and (number? user-input) (positive? user-input) (< user-input 10) (not ((lambda (x) (or (car x) (cadr x))) (map (lambda (i) (string=? i (list-ref game-map (- user-input 1)))) '("○" "×")))))
		(update (- user-input 1) mark)
		(begin (display "please You can put 0~9 number: ") (loop))))
	    (cond ((check mark)  (display "You win!\nHere you are flag!\nTKCTF{tictact0e}"))
		  ((check (if (string=? mark "○") "×" "○")) (display "You lose!\n"))
		  (else (enemy_ai草ww game-map (if (string=? "○" mark) "×" "○")) (if (check (if (string=? mark "○") "×" "○")) (return (display "You lose!\n")) #f) (main)))
	    )))))
    (display "Thank You playing!\n")))
(cond
 ((< (element-width term) 900) (display "

 +-+-+-+-+-+-+-+-+-+-+
 |T|K|C|T|F|-|c|l|u|b|
 +-+-+-+-+-+-+-+-+-+-+
 
"))
 ((< (element-width term) 1500) (display "
████████╗██╗  ██╗ ██████╗████████╗███████╗     ██████╗██╗     ██╗   ██╗██████╗ 
╚══██╔══╝██║ ██╔╝██╔════╝╚══██╔══╝██╔════╝    ██╔════╝██║     ██║   ██║██╔══██╗
   ██║   █████╔╝ ██║        ██║   █████╗█████╗██║     ██║     ██║   ██║██████╔╝
   ██║   ██╔═██╗ ██║        ██║   ██╔══╝╚════╝██║     ██║     ██║   ██║██╔══██╗
   ██║   ██║  ██╗╚██████╗   ██║   ██║         ╚██████╗███████╗╚██████╔╝██████╔╝
   ╚═╝   ╚═╝  ╚═╝ ╚═════╝   ╚═╝   ╚═╝          ╚═════╝╚══════╝ ╚═════╝ ╚═════╝ 
                                                                               
 
"))
 (else (display "
                          _..._                                         _..._                               
                       .-'_..._''.                                   .-'_..._''. .---.                      
             .       .' .'      '.\                                .' .'      '.\|   |           /|         
           .'|      / .'                      _.._                / .'           |   |           ||         
     .|  .'  |     . '               .|     .' .._|              . '             |   |           ||         
   .' |_<    |     | |             .' |_    | '    ,.----------. | |             |   |           ||  __     
 .'     ||   | ____| |           .'     | __| |__ //            \| |             |   |   _    _  ||/'__ '.  
'--.  .-'|   | \ .'. '          '--.  .-'|__   __|\\            /. '             |   |  | '  / | |:/`  '. ' 
   |  |  |   |/  .  \ '.          .|  |     | |    `'----------'  \ '.          .|   | .' | .' | ||     | | 
   |  |  |    /\  \  '. `._____.-'/|  |     | |                    '. `._____.-'/|   | /  | /  | ||\    / ' 
   |  '.'|   |  \  \   `-.______ / |  '.'   | |                      `-.______ / '---'|   `'.  | |/\'..' /  
   |   / '    \  \  \           `  |   /    | |                               `       '   .'|  '/'  `'-'`   
   `'-' '------'  '---'            `'-'     |_|                                        `-'  `--'            
 
")))
(define (factor x) (if (= 71456335213936339667583931974144970765327963434711239325932911324065698399442011 x) (display "(953 * 74980414705074857993267504694800598914300066563180733815249644621265160964787)") (display "error")))
<<<<<<< HEAD
(display "71456335213936339667583931974144970765327963434711239325932911324065698399442011")
(display "1085267300152893114288803146806622529202080626206924102794738916250870161499231")
=======
(define (help) (display "\"(factor)\": 答えの数字だけを受け付けて素因数分解します。それ以外はerrorを返します。\n\"(tictactoe)\": ○×ゲームです。"))
(display "71456335213936339667583931974144970765327963434711239325932911324065698399442011")
(display "1085267300152893114288803146806622529202080626206924102794738916250870161499231")
(display "https://nodokaha.github.io/images/yui.png")
(display "CTFという競技は、いわゆるホワイトハッカー達が凌ぎを削りあっているセキュリティ大会です!")
(display "このサイトには、3つのフラグが隠れています。")
(display "見つけられますか？")
>>>>>>> f57d9e8 (update picoctf2023)
