#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
/*
  ; WARNING: Programs that use User32\LockWorkStation (i.e. programmatically locking the operating system) may not work correctly! 
  ; This includes Windows itself (i.e. using start menu or task manager to lock will also not work).
  ; Script changes Win-L to show a msgbox and Ctrl-Alt-L to lock windows

  ; The following 3 code lines are auto-executed upon script run, the return line marks an end to the auto-executed code section.
  ; Register user defined subroutine 'OnExitSub' to be executed when this script is terminating
  OnExit, OnExitSub

  ; Disable LockWorkStation, so Windows doesn't intercept Win+L and this script can act on that key combination 
  SetDisableLockWorkstationRegKeyValue( 1 )
return
/*

SetCapsLockState, AlwaysOff

/*
; df - up,down | jk - left,right

; Down
~CapsLock & d::
       if getkeystate("ctrl")
               Send {PgDn}
       else if getkeystate("shift")
               Send +{Down}
       else
               Send {Down}
return

; Up
~CapsLock & f::
       if getkeystate("ctrl")
               Send {PgUp}
       else if getkeystate("shift")
               Send +{Up}
       else				
               Send {Up}
return

; Left
~CapsLock & j::
       if getkeystate("ctrl")
               Send ^{Left}
       else if getkeystate("shift")
               Send +{Left}
       else if getkeystate("alt")
               Send {Home}
       else
               Send {Left}
return

; Right
~CapsLock & k::
       if getkeystate("ctrl")
               Send ^{Right}
       else if getkeystate("shift")
               Send +{Right}
       else if getkeystate("alt")
               Send {End}
       else
               Send {Right}
return
*/

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

; $ &
~CapsLock & h::
       if getkeystate("shift")
               Send {#}
       else
               Send {=}
return

; $ &
~CapsLock & j::
       if getkeystate("shift")
               Send {<}
       else
               Send {(}
return

; ) :
~CapsLock & k::
       if getkeystate("shift")
               Send {>}
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
~Capslock & '::Send {`}

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
~CapsLock & ,::
       if getkeystate("shift")
               Send {^}
       else
               Send {?}
return

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

^!l::
  ; Ctrl-Alt-L 
  ; Temporary enable locking
  SetDisableLockWorkstationRegKeyValue( 0 )
  ; Lock
  DllCall( "User32\LockWorkStation" )
  ; Disable locking again 
	sleep, 1000
  SetDisableLockWorkstationRegKeyValue( 1 )
return

OnExitSub:
  ; Enable LockWorkStation, because this script is ending (so other applications aren't further disturbed)
  SetDisableLockWorkstationRegKeyValue( 0 )
  ExitApp
return

SetDisableLockWorkstationRegKeyValue( value )
  {
  RegWrite, REG_DWORD, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Policies\System, DisableLockWorkstation, %value%
  }

; # -> win
; ^ -> ctrl
; ! -> alt
; + -> shift

;~LWin Up:: return
;~RWin Up:: return

;#Space:: Send ^{Esc}

/*
LWin & Tab::AltTab

#j::Send {Left}
+#j::Send +{Left}
^#j::Send ^{Left}
+^#j::Send +^{Left}
!#j::Send {Home}
+!#j::Send +{Home}

#k::Send {Right}
#^k::Send ^{Right}
#!k::Send {End}

#d::Send {Down}
#^d::Send {PgDn}

#f::Send {Up}
#^f::Send {PgUp}

;#Esc::
;  RegWrite, REG_DWORD, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Policies\System, DisableLockWorkstation, 0
;	sleep, 1000
;	DllCall("LockWorkStation")
;	sleep, 1000
;	RegWrite, REG_DWORD, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Policies\System, DisableLockWorkstation, 1
;return
/*

; hjkl

;#h::Send {Left}
;+#h::Send +{Left}
;^#h::Send ^{Left}
;+^#h::Send +^{Left}
;!#h::Send {Home}
;+!#h::Send +{Home}

;#j::Send {Down}
;+#j::Send +{Down}
;^#j::Send ^{PgDn}
;+^#j::Send +^{PgDn}
;; !#j::Send {Home}
;; +!#j::Send +{Home}

;#k::Send {Up}
;+#k::Send +{Up}
;^#k::Send ^{PgUp}
;+^#k::Send +^{PgUp
;; !#k::Send {Home}
;; +!#k::Send +{Home}


;;#l::Send {Right}
;+#l::Send +{Right}
;^#l::Send ^{Right}
;+^#l::Send +^{Right}
;!#l::Send {End}
;+!#l::Send +{End}