(define term (js-eval "document.getElementById('term')"))
(set-style! term "backgroundColor" "transparent")
(js-invoke (getelem term) "LoadingOverlay" "show")
(display "71456335213936339667583931974144970765327963434711239325932911324065698399442011")
(sleep 0.5)
(display "1085267300152893114288803146806622529202080626206924102794738916250870161499231")
(sleep 0.5)
(display "https://nodokaha.github.io/images/yui.jpg")
(sleep 0.5)
(display "https://nodokaha.github.io/chall.c")
(sleep 0.5)
(display "https://nodokaha.github.io/chall")
(sleep 0.5)
(display "CTFという競技は、いわゆるホワイトハッカー達\nが競い合っているセキュリティ大会です!")
(sleep 0.5)
(display "このサイトには、9つのフラグが隠れています。")
(sleep 0.5)
(display "見つけられますか？")
(sleep 0.5)
(display "\"(help)\"とタイプすると助けを求めれます。")
(js-invoke (getelem term) "LoadingOverlay" "hide")
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
;; (define (display-term x) (let ((temp (string->listf x))) (map (lambda 
(let ((display-talk (lambda (x) (display (list-ref x (random-integer (length x))))))(bigtitle '("
                          _..._                                         _..._                               
                       .-'_..._''.                                   .-'_..._''. .---.                      
             .       .' .'      '.%                                .' .'      '.%|   |           /|         
           .'|      / .'                      _.._                / .'           |   |           ||         
     .|  .'  |     . '               .|     .' .._|              . '             |   |           ||         
   .' |_<    |     | |             .' |_    | '    ,.----------. | |             |   |           ||  __     
 .'     ||   | ____| |           .'     | __| |__ //            %| |             |   |   _    _  ||/'__ '.  
'--.  .-'|   | % .'. '          '--.  .-'|__   __|%%            /. '             |   |  | '  / | |:/`  '. ' 
   |  |  |   |/  .  % '.          .|  |     | |    `'----------'  % '.          .|   | .' | .' | ||     | | 
   |  |  |    /%  %  '. `._____.-'/|  |     | |                    '. `._____.-'/|   | /  | /  | ||%    / ' 
   |  '.'|   |  %  %   `-.______ / |  '.'   | |                      `-.______ / '---'|   `'.  | |/%'..' /  
   |   / '    %  %  %           `  |   /    | |                               `       '   .'|  '/'  `'-'`   
   `'-' '------'  '---'            `'-'     |_|                                        `-'  `--'            
 
   "
												"
        ,----,                              ,----,                                                            
      ,/   .`|       ,--.                 ,/   .`|                                                            
    ,`   .'  :   ,--/  /|  ,----..      ,`   .'  :   ,---,.                    ,--,                           
  ;    ;     /,---,': / ' /   /   \\   ;    ;     / ,'  .' |                  ,--.'|                  ,---,    
.'___,/    ,' :   : '/ / |   :     :.'___,/    ,',---.'   |    ,---,.        |  | :            ,--,,---.'|    
|    :     |  |   '   ,  .   |  ;. /|    :     | |   |   .'  ,'  .' |        :  : '          ,'_ /||   | :    
;    |.';  ;  '   |  /   .   ; /--` ;    |.';  ; :   :  :  ,---.'   , ,---.  |  ' |     .--. |  | ::   : :    
`----'  |  |  |   ;  ;   ;   | ;    `----'  |  | :   |  |-,|   |    |/     \\ '  | |   ,'_ /| :  . |:     |,-. 
    '   :  ;  :   '   \\  |   : |        '   :  ; |   :  ;/|:   :  .'/    / ' |  | :   |  ' | |  . .|   : '  | 
    |   |  '  |   |    ' .   | '___     |   |  ' |   |   .':   |.' .    ' /  '  : |__ |  | ' |  | ||   |  / : 
    '   :  |  '   : |.  \\'   ; : .'|    '   :  | '   :  '  `---'   '   ; :__ |  | '.'|:  | : ;  ; |'   : |: | 
    ;   |.'   |   | '_\\.''   | '/  :    ;   |.'  |   |  |          '   | '.'|;  :    ;'  :  `--'   \\   | '/ : 
    '---'     '   : |    |   :    /     '---'    |   :  \\          |   :    :|  ,   / :  ,      .-./   :    | 
              ;   |,'     \\   \\ .'               |   | ,'           \\   \\  /  ---`-'   `--`----'   /    \\  /  
              '---'        `---`                 `----'              `----'                        `-'----'   
                                                                                                              
"
												
												"\"
.------..------..------..------..------..------..------..------..------..------.
|T.--. ||K.--. ||C.--. ||T.--. ||F.--. ||-.--. ||C.--. ||L.--. ||U.--. ||B.--. |
| :/\\: || :/\\: || :/\\: || :/\\: || :(): || (\\/) || :/\\: || :/\\: || (\\/) || :(): |
| (__) || :\\/: || :\\/: || (__) || ()() || :\\/: || :\\/: || (__) || :\\/: || ()() |
| \'--\'T|| \'--\'K|| \'--\'C|| \'--\'T|| \'--\'F|| \'--\'-|| \'--\'C|| \'--\'L|| \'--\'U|| \'--\'B|
`------\'`------\'`------\'`------\'`------\'`------\'`------\'`------\'`------\'`------\'
\""
												"
,---------. .--.   .--.      _______ ,---------.  ________                  _______    .---.      ___    _  _______    
\\          \\|  | _/  /      /   __  \\\\          \\|        |                /   __  \\   | ,_|    .'   |  | |\\  ____  \\  
 `--.  ,---'| (`' ) /      | ,_/  \\__)`--.  ,---'|   .----'               | ,_/  \\__),-./  )    |   .'  | || |    \\ |  
    |   \\   |(_ ()_)     ,-./  )         |   \\   |  _|____   _ _    _ _ ,-./  )      \\  '_ '`)  .'  '_  | || |____/ /  
    :_ _:   | (_,_)   __ \\  '_ '`)       :_ _:   |_( )_   | ( ' )--( ' )\\  '_ '`)     > (_)  )  '   ( \\.-.||   _ _ '.  
    (_I_)   |  |\\ \\  |  | > (_)  )  __   (_I_)   (_ o._)__|(_{;}_)(_{;}_)> (_)  )  __(  .  .-'  ' (`. _` /||  ( ' )  \\ 
   (_(=)_)  |  | \\ `'   /(  .  .-'_/  ) (_(=)_)  |(_,_)     (_,_)--(_,_)(  .  .-'_/  )`-'`-'|___| (_ (_) _)| (_{;}_) | 
    (_I_)   |  |  \\    /  `-'`-'     /   (_I_)   |   |                   `-'`-'     /  |        \\\\ /  . \\ /|  (_,_)  / 
    '---'   `--'   `'-'     `._____.'    '---'   '---'                     `._____.'   `--------` ``-'`-'' /_______.'  
                                                                                                                       
" "
 .-') _   .-. .-')            .-') _                                                    .-. .-')   
(  OO) )  %  ( OO )          (  OO) )                                                   %  ( OO )  
/     '._ ,--. ,--.   .-----./     '._    ,------.          .-----. ,--.     ,--. ,--.   ;-----.%  
|'--...__)|  .'   /  '  .--./|'--...__)('-| _.---'  .-')   '  .--./ |  |.-') |  | |  |   | .-.  |  
'--.  .--'|      /,  |  |('-.'--.  .--'(OO|(_%    _(  OO)  |  |('-. |  | OO )|  | | .-') | '-' /_) 
   |  |   |     ' _)/_) |OO  )  |  |   /  |  '--.(,------./_) |OO  )|  |`-' ||  |_|( OO )| .-. `.  
   |  |   |  .   %  ||  |`-'|   |  |   %_)|  .--' '------'||  |`-'|(|  '---.'|  | | `-' /| |  %  | 
   |  |   |  |%   %(_'  '--'%   |  |     %|  |_)         (_'  '--'% |      |('  '-'(_.-' | '--'  / 
   `--'   `--' '--'   `-----'   `--'      `--'              `-----' `------'  `-----'    `------'  
")))
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
 (else (map display-talk (list bigtitle)))))
(define (factor x) (if (= 71456335213936339667583931974144970765327963434711239325932911324065698399442011 x) (display "(953 * 74980414705074857993267504694800598914300066563180733815249644621265160964787)") (display "error")))
(define (help) (display "どうも、初めまして。\nあなたが何者か知りませんが、このサイトに訪れたということは\n何かしらの縁があったということです。\n是非とも我々高専の裏組織サークルであるTKCTF-clubに入部下さい…。\nですが、あなたの実力を知らない以上\n容易に高専の裏情報を教える訳にはいけません。\nこのサイトにはいくつかのフラグという情報が隠されています。\nフラグはTKCTF{ほにゃらら}という形になっていますので\n是非とも高専の裏情報を取得する準備運動と思って挑戦してみてください。\n\"(factor)\": 答えの数字だけを受け付けて素因数分解します。それ以外はerrorを返します。\n\"(tictactoe)\": ○×ゲームです。"))
(define (talk)
    (let ((talk '("はい、どうも。"
		  "ヒントとか欲しいですかね？"
		  "正直入ってくれる人なんて居ないだろうなあと"
		  "RSA暗号って知ってますか？"))
	(display-talk (lambda (x) (display (list-ref x (random-integer (length x)))))))
    (display-talk talk)))

