Message-ID: <19990904001345.11766.qmail@www0m.netaddress.usa.net>
Date: 3 Sep 99 19:13:45 CDT
From: jeramy b smith <ultrapenguin@netscape.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: Possible Bug in XFree3.3.5
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I downloaded the 3.3.5 rpms from Tom's directory and installed them. I have a
2meg ati rage IIc. Before upgrading the rpm, I was using vmode 18 and cmode 16
and the same for my X resolution (1152x864@16bpp). However, trying to startx
with this configuration would crash.

Changing the depth in to 8bpp in XF86config solved this. I tried setting the
the resolution to 800x600 and bumping the colors up to 16bpp. XFB initializes
the accel code, reports the font and pixmap caches are disabled. Then I get
the BBdebug message that it is setting up gnome support. I catch the signal
11. blackbox then tells me:

X Error of failed request:   16 Badlength (poly request too large or internal
Xlib length error
Major/minor opcode of failed request: 72 / 0
Resource id in failed request: 0x8000014

I tried Xconfigurator to rule out window manager/extraneous errors and
Xconfigurator would promptly quit when it would try to test these modes.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
