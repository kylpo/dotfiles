#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

SetCapsLockState, AlwaysOff

; # -> win
; ^ -> ctrl
; ! -> alt
; + -> shift

~CapsLock & 1::
       if getkeystate("shift")
               Send {Media_Play_Pause}
       else
               Send {F1}
return

; Delete
~Capslock & Backspace::Send {Delete}

; Tab
~Capslock & Space::Send {Tab}
~Capslock & Esc::Send {Tab}

; Return
;Capslock & `;::Send {Return}
+Space::Send {Return}

; ;
+,::Send {;}

; :
+.::Send {:}

; ----------------------------
; ---------TOP ROW------------
; ----------------------------

; 1
~Capslock & q::Send {1}

; 2
~Capslock & w::Send {2}

; 3
~Capslock & e::Send {3}

; 4
~Capslock & r::Send {4}

; 5
~Capslock & t::Send {5}

; @
~Capslock & y::Send {@}

; { [
~CapsLock & u::
       if getkeystate("shift")
               Send {[}
       else
               Send {{}
return

; } ]
~CapsLock & i::
       if getkeystate("shift")
               Send {]}
       else
               Send {}}
return

; + %
~CapsLock & o::
       if getkeystate("shift")
               Send {`%}
       else
               Send {+}
return

; *
~Capslock & p::Send {*}

; ----------------------------
; ---------HOME ROW-----------
; ----------------------------

; Left
~CapsLock & a::
       if getkeystate("ctrl")
               Send ^{Left}
       else if getkeystate("shift")
               Send +{Left}
       else if getkeystate("alt")
               Send {Home}
       else
               Send {Left}
return

; Up
~CapsLock & s::
       if getkeystate("ctrl")
               Send {PgUp}
       else if getkeystate("shift")
               Send +{Up}
       else
               Send {Up}
return

; Down
~CapsLock & d::
       if getkeystate("ctrl")
               Send {PgDn}
       else if getkeystate("shift")
               Send +{Down}
       else
               Send {Down}
return


; Right
~CapsLock & f::
       if getkeystate("ctrl")
               Send ^{Right}
       else if getkeystate("shift")
               Send +{Right}
       else if getkeystate("alt")
               Send {End}
       else
               Send {Right}
return

; $ &
~CapsLock & g::
       if getkeystate("shift")
               Send {&}
       else
               Send {$}
return

; = #
~CapsLock & h::
       if getkeystate("shift")
               Send {#}
       else
               Send {=}
return

; ( <
~CapsLock & j::
       if getkeystate("shift")
               ;SendInput {<} ;conflicts with shift ,
               SendInput {U+003C}
       else
               Send {(}
return

; ) >
~CapsLock & k::
       if getkeystate("shift")
               ;SendInput {>} ;conflicts with shift .
               SendInput {U+003E}
       else
               Send {)}
return

; - ~
~CapsLock & l::
       if getkeystate("shift")
               Send {~}
       else
               Send {-}
return

; `
~Capslock & '::Send {``}

; ----------------------------
; ---------BOTTOM ROW---------
; ----------------------------

; 6
~Capslock & z::Send {6}

; 7
~Capslock & x::Send {7}

; 8
~Capslock & c::Send {8}

; 9
~Capslock & v::Send {9}

; 0
~Capslock & b::Send {0}

; _ |
~CapsLock & n::
       if getkeystate("shift")
               Send {|}
       else
               Send {_}
return

; / \
~CapsLock & m::
       if getkeystate("shift")
               Send {\}
       else
               Send {/}
return

; ? ^
;~CapsLock & ,::
       ;if getkeystate("shift")
               ;Send {^}
       ;else
               ;Send {?}
;return

; !
~Capslock & .::Send {!}

*Capslock::SetCapsLockState, AlwaysOff

; Ctrl-Tab
#a::+^Tab
#f::^Tab

; Alt-Tab
LWin & s::ShiftAltTab
LWin & d::AltTab

; Close App
#Esc::Send !{F4}

; Close Tab
#w::Send ^{w}

; New Tab
#t::Send ^{t}

; Re-Open Tab
#+t::Send ^+{t}

; Copy
#c::Send ^{c}

; Paste
#v::Send ^{v}

; Select All
;#+a::^a

/*
#a::
       if getkeystate("shift")
               Send ^a
       else				
               Send +^{Tab}
return
/*