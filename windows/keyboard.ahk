; To start this on login, see https://www.maketecheasier.com/schedule-autohotkey-startup-windows/

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
               SendInput {Media_Play_Pause}
       else
               SendInput {F1}
return

; Delete
~Capslock & Backspace::SendInput {Delete}

; Tab
~Capslock & Space::SendInput {Tab}
~Capslock & Esc::SendInput {Tab}

; Return
;Capslock & `;::SendInput {Return}
+Space::SendInput {Return}

; ;
+,::SendInput {;}

; :
+.::SendInput {:}

; ----------------------------
; ---------TOP ROW------------
; ----------------------------

; 1
~Capslock & q::SendInput {1}

; 2
~Capslock & w::SendInput {2}

; 3
~Capslock & e::SendInput {3}

; 4
~Capslock & r::SendInput {4}

; 5
~Capslock & t::SendInput {5}

; @
~Capslock & y::SendInput {@}

; { [
~CapsLock & u::
       if getkeystate("shift")
               SendInput {[}
       else
               SendInput {{}
return

; } ]
~CapsLock & i::
       if getkeystate("shift")
               SendInput {]}
       else
               SendInput {}}
return

; + %
~CapsLock & o::
       if getkeystate("shift")
               SendInput {`%}
       else
               SendInput {+}
return

; *
~Capslock & p::SendInput {*}

; ----------------------------
; ---------HOME ROW-----------
; ----------------------------

; Left
~CapsLock & a::
       if getkeystate("ctrl")
               SendInput ^{Left}
       else if getkeystate("shift")
               SendInput +{Left}
       else if getkeystate("alt")
               SendInput {Home}
       else
               SendInput {Left}
return

; Up
~CapsLock & s::
       if getkeystate("ctrl")
               SendInput {PgUp}
       else if getkeystate("shift")
               SendInput +{Up}
       else
               SendInput {Up}
return

; Down
~CapsLock & d::
       if getkeystate("ctrl")
               SendInput {PgDn}
       else if getkeystate("shift")
               SendInput +{Down}
       else
               SendInput {Down}
return


; Right
~CapsLock & f::
       if getkeystate("ctrl")
               SendInput ^{Right}
       else if getkeystate("shift")
               SendInput +{Right}
       else if getkeystate("alt")
               SendInput {End}
       else
               SendInput {Right}
return

; $ &
~CapsLock & g::
       if getkeystate("shift")
               SendInput {&}
       else
               SendInput {$}
return

; = #
~CapsLock & h::
       if getkeystate("shift")
               SendInput {#}
       else
               SendInput {=}
return

; ( <
~CapsLock & j::
       if getkeystate("shift")
               ;SendInput {<} ;conflicts with shift ,
               SendInput {U+003C}
       else
               SendInput {(}
return

; ) >
~CapsLock & k::
       if getkeystate("shift")
               ;SendInput {>} ;conflicts with shift .
               SendInput {U+003E}
       else
               SendInput {)}
return

; - ~
~CapsLock & l::
       if getkeystate("shift")
               SendInput {~}
       else
               SendInput {-}
return

; `
~Capslock & '::SendInput {``}

; ----------------------------
; ---------BOTTOM ROW---------
; ----------------------------

; 6
~Capslock & z::SendInput {6}

; 7
~Capslock & x::SendInput {7}

; 8
~Capslock & c::SendInput {8}

; 9
~Capslock & v::SendInput {9}

; 0
~Capslock & b::SendInput {0}

; _ |
~CapsLock & n::
       if getkeystate("shift")
               SendInput {|}
       else
               SendInput {_}
return

; / \
~CapsLock & m::
       if getkeystate("shift")
               SendInput {\}
       else
               SendInput {/}
return

; ? ^
~CapsLock & ,::
       if getkeystate("shift")
               SendInput {^}
       else
               SendInput {?}
return

; !
~Capslock & .::SendInput {!}

; ----------------------------
; ---------OTHERS-------------
; ----------------------------

*Capslock::SetCapsLockState, AlwaysOff

; disable Win launching start menu all the damn time
; thanks to https://autohotkey.com/board/topic/51631-disable-windows-key-start-menu-but-not-shortcuts/page-2 and https://autohotkey.com/board/topic/59520-raltappskey-only-for-single-ralt-press-not-combinatios/
LWin & vk07::return ; vk07 is "unassigned", i.e. doesn't belong to any key. The hotkey itself should never fire, but the use of RAlt in a custom combination turns it into a "prefix key". In other words, it changes the RAlt:: hotkey to fire only on release and only if no other key was pressed.
LWin::return ; (or run Launchy)

; Win-Space launches start menu
LWin & Space::SendInput ^{Esc}

; Ctrl-Tab
#a::+^Tab
#f::^Tab

; Alt-Tab
LWin & s::ShiftAltTab
LWin & d::AltTab

; Close App
#Esc::SendInput !{F4}

; Close Tab
#w::SendInput ^{w}

; New Tab
#t::SendInput ^{t}

; Re-Open Tab
#+t::SendInput ^+{t}

; Copy
#c::SendInput ^{c}

; Paste
#v::SendInput ^{v}

; Select All
;#+a::^a

/*
#a::
       if getkeystate("shift")
               SendInput ^a
       else
               SendInput +^{Tab}
return
/*