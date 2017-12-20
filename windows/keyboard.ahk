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
~Capslock & Backspace::SendInput {Blind}{Delete}

; Tab
;~Capslock & Space::SendInput {Blind}{Tab}
~Capslock & Esc::SendInput {Blind}{Tab}

; Return
;Capslock & `;::SendInput {Blind}{Return}
;+Space::SendInput {Blind}{Enter}
~Capslock & Space::SendInput {Blind}{Enter}

; ;
;+,::SendInput {;} ;unable to use Blind here since shift-; => :
+,::SendInput {Blind}{U+003B}

; :
+.::SendInput {Blind}{:}

; ----------------------------
; ---------TOP ROW------------
; ----------------------------

; 1
~Capslock & q::SendInput {Blind}{1}

; 2
~Capslock & w::SendInput {Blind}{2}

; 3
~Capslock & e::SendInput {Blind}{3}

; 4
~Capslock & r::SendInput {Blind}{4}

; 5
~Capslock & t::SendInput {Blind}{5}

; @
~Capslock & y::SendInput {Blind}{@}

; { [
~CapsLock & u::
       if getkeystate("shift")
               SendInput {Blind}{[}
       else
               SendInput {Blind}{{}
return

; } ]
~CapsLock & i::
       if getkeystate("shift")
               SendInput {Blind}{]}
       else
               SendInput {Blind}{}}
return

; + %
~CapsLock & o::
       if getkeystate("shift")
               SendInput {Blind}{`%}
       else
               SendInput {Blind}{+}
return

; *
~Capslock & p::SendInput {Blind}{*}

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
               SendInput {Blind}{&}
       else
               SendInput {Blind}{$}
return

; = #
~CapsLock & h::
       if getkeystate("shift")
               SendInput {Blind}{#}
       else
               SendInput {Blind}{=}
return

; ( <
~CapsLock & j::
       if getkeystate("shift")
               ;SendInput {<} ;conflicts with shift ,
               SendInput {Blind}{U+003C}
       else
               SendInput {Blind}{(}
return

; ) >
~CapsLock & k::
       if getkeystate("shift")
               ;SendInput {>} ;conflicts with shift .
               SendInput {Blind}{U+003E}
       else
               SendInput {Blind}{)}
return

; - ~
~CapsLock & l::
       if getkeystate("shift")
               SendInput {Blind}{~}
       else
               SendInput {Blind}{-}
return

; `
~Capslock & '::SendInput {Blind}{``}

; ----------------------------
; ---------BOTTOM ROW---------
; ----------------------------

; 6
~Capslock & z::SendInput {Blind}{6}

; 7
~Capslock & x::SendInput {Blind}{7}

; 8
~Capslock & c::SendInput {Blind}{8}

; 9
~Capslock & v::SendInput {Blind}{9}

; 0
~Capslock & b::SendInput {Blind}{0}

; _ |
~CapsLock & n::
       if getkeystate("shift")
               SendInput {Blind}{|}
       else
               SendInput {Blind}{_}
return

; / \
~CapsLock & m::
       if getkeystate("shift")
               SendInput {Blind}{\}
       else
               SendInput {Blind}{/}
return

; ? ^
~CapsLock & ,::
       if getkeystate("shift")
               SendInput {Blind}{^}
       else
               SendInput {Blind}{?}
return

; !
~Capslock & .::SendInput {Blind}{!}

; ----------------------------
; ---------OTHERS-------------
; ----------------------------

*Capslock::SetCapsLockState, AlwaysOff

; disable Win launching start menu all the damn time
; thanks to https://autohotkey.com/board/topic/51631-disable-windows-key-start-menu-but-not-shortcuts/page-2 and https://autohotkey.com/board/topic/59520-raltappskey-only-for-single-ralt-press-not-combinatios/
LWin & vk07::return ; vk07 is "unassigned", i.e. doesn't belong to any key. The hotkey itself should never fire, but the use of RAlt in a custom combination turns it into a "prefix key". In other words, it changes the RAlt:: hotkey to fire only on release and only if no other key was pressed.
LWin::return

; Win-Space launches start menu
LWin & Space::
  SendInput {LWin up} ;LWin up step is crucial
  KeyWait LWin ;Make sure it is actually up before sending next
  SendInput ^{Esc}
return

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