Date: Tue, 17 Apr 2001 22:14:22 +0100
Subject: XF4, SysRq, VT, mouse buttons, Keymaps and all that
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="utf-8"
Message-Id: <20010417211637.DEDEEDBA73@atlas.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Thanks to those who gave help in getting XF4 (basically) going.

I haven't been able to try Ani's patch yet - the xfree86.org cvs server
pings - but no response yet today to cvs login :-(

ati (mach64): (G3/beige, 2.4.4-pre3)

a kludge of putting the 4.0.99.1-0f libfbdevhw.a library into the latest
code gives me ati accel.  Thanks Kaoru & Scott. (Will try Ani's proper fix
as soon as I can co the XFree86 tree).

Michel's advice to "option XkbDisable" gives partial functionality (VT
switches, server re-start).... but... with no mouse button emulation or
SysRq. (haven't tried MoL yet).

===

I may be going blind - but I can't see _any_ locale-specific mac keycode
tables in the X11R6 tree...

So the next question set is...

1/ Is there a description anywhere of the flow of keycode translation
   adb -> linux_keycodes -> X  (there isn't in linux/Documentation AFAICT).
Especially:
    where to look for the tables to edit at each stage - and
    what exists to examine the codes.

2/ the (ISO Mac Keyboard) SysRq key is no longer a single value (according
to showkey it sends two codes) but this needs to be caught earlier on (in
the kernel) - so is this supposed to be before or after the translation
adb->linux_keycodes? ... or how can I find the value to modify the match
code in the kernel?  AFAICT SysRq is not working.

3/ how does one find the keycode values for <option>-key combinations so
that the mouse_button2 & 3 keycodes can be re-assigned (it is really
irritating losing them)...  [the kernel build has this emulation enabled]

4/ Notwithstanding the PMac-specific nature of some of these questions - Is
there a HOW-to on creating a keymap (I'm happy to do one for the UK keyboard
if someone can point at the mechanism).

5/ num-lock never worked for me (even under 3.3.6 - it put the keyboard
light on but made no difference to the retured codes) I'd like to get this
fixed because some apps (like cdp) use the keypad.

any pointers appreciated and thanks again for the help so far,
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
