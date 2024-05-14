
(define term (js-eval "document.getElementById('term')"))
(js-invoke (getelem term) "LoadingOverlay" "show" (js-obj "image" "" "progress" #t))
(set-style! term "font" "18px / 20px Courier New")
(sleep 0.5)
(js-invoke (getelem term) "LoadingOverlay" "progress" 10)
(if (not (string=? (get-style term "font") "18px / 20px Courier New"))
    (set-style! term "font" "18px / 20px monospace"))
(sleep 0.5)
(js-invoke (getelem term) "LoadingOverlay" "progress" 20)
(set-style! term "backgroundColor" "transparent")
(display "
  _____                       _                  
 |  __ \\                     | |                 
 | |__) |___ _ __   ___  _ __| |_                
 |  _  // _ \\ '_ \\ / _ \\| '__| __|               
 | | \\ \\  __/ |_) | (_) | |  | |_                
 |_|  \\_\\___| .__/ \\___/|_|   \\__|               
            | |                                  
            |_|_      ___      _               _ 
              \\ \\    / (_)    | |             | |
               \\ \\  / / _ _ __| |_ _   _  __ _| |
                \\ \\/ / | | '__| __| | | |/ _` | |
                 \\  /  | | |  | |_| |_| | (_| | |
                  \\/   |_|_|   \\__|\\__,_|\\__,_|_|
  _____                               _          
 |  __ \\                             | |         
 | |__) |___  ___  ___  __ _ _ __ ___| |__       
 |  _  // _ \\/ __|/ _ \\/ _` | '__/ __| '_ \\      \n | | \\ \\  __/\\__ \\  __/ (_| | | | (__| | | |     
 |_|  \\_\\___||___/\\___|\\__,_|_|  \\___|_| |_|     
                                                 
                                                 
")
(sleep 0.5)
(js-invoke (getelem term) "LoadingOverlay" "progress" 30)
(display "")
(sleep 0.5)
(js-invoke (getelem term) "LoadingOverlay" "progress" 35)
(display "")
(sleep 0.5)
(js-invoke (getelem term) "LoadingOverlay" "progress" 40)
(display "仮想世界に浸る…？")
(sleep 0.5)
(js-invoke (getelem term) "LoadingOverlay" "progress" 50)
(display "探しても探しても見つからない")
(sleep 0.5)
(js-invoke (getelem term) "LoadingOverlay" "progress" 60)
(display "感覚ってなんだった…？")
(sleep 0.5)
(js-invoke (getelem term) "LoadingOverlay" "progress" 70)
(display "記録をつけよう、記録をつけよう…")
(sleep 0.5)
(js-invoke (getelem term) "LoadingOverlay" "progress" 80)
(display "見つからない…見つからないから報告書にまとめて…")
(sleep 0.5)
(js-invoke (getelem term) "LoadingOverlay" "progress" 90)
(display "ねえ、見つけられますか？")
(display "Hel…")

(sleep 0.5)
(js-invoke (getelem term) "LoadingOverlay" "progress" 100)
(js-invoke (getelem term) "LoadingOverlay" "hide")
(display (reader "login: "))
(display (reader "password: "))
