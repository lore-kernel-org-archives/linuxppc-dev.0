Message-ID: <39835F2B.36C12CC9@denise.shiny.it>
Date: Sat, 29 Jul 2000 18:48:11 -0400
From: Giuliano Pochini <pochini@denise.shiny.it>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: XF4, speed and keyboard problems
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi! I finally installed XF4. It seems faster for most of operations (windows
movement is smothes, xscreensever runs fater, etc), but all visualization
plugins for Alsaplayer and xmms are 30% slower according to CPU usage
(print_a_bitmap_on_the_screen() is slower ??).

Anyway... the real problem in another one: I can't get different codes for
left/right shift control and alt keys :(((
I tried to patch mac_keyb.c to never translate R to L codes (it worked for
XF3) without success. Also, I can't anymore
emulate central mouse button with L_alt+L_button :-(((

I have a Microsoft (bleah) USB keyboard (which do send separate L/R codes in
console) and kernel 2.2.16p)

Help !!

Bye.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
