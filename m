Message-ID: <37D9E860.B1B5ED41@loomer.com>
Date: Fri, 10 Sep 1999 22:28:01 -0700
From: Hugh Caley <hcaley@loomer.com>
MIME-Version: 1.0
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
        linuxppc-dev@lists.linuxppc.org
Subject: Problems with atyfb, 32 bit color, Lombard
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello, Geert.  If you are not the correct person to contact about this, please
let me know.

Those of use using atyfb on Apple "Lombard" laptops are having an odd problem
with X.  Small lines are not being drawn at the correct angles, so things like
arrows in menus and checkboxes are not being drawn correctly.  For example,
the little arrows in the menus in WindowMaker end up looking like squares.

This doesn't seem to be related to window managers, I get the same problems
with window managers and programs that use completely different libraries.

It only seems to happen with 32-bit color, and happens both with XF68_FBDev
and Xpmac.  It only happens when using atyfb.

I'm using kernel args (in bootx):

video=atyfb:vmode:16,cmode:32,mclk:67; I've also tried vmode 14, cmode 16 and
mclk 100.

The latest version of atyfb.c I'm using:

[root@hugh video]# more atyfb.c
/*  $Id: atyfb.c,v 1.106.2.4 1999/09/02 06:34:46 paulus Exp $
 *  linux/drivers/video/atyfb.c -- Frame buffer device for ATI Mach64


Hugh

--
Hugh Caley, Unix Administrator
Babcock & Brown, San Francisco
510-524-1672
hughc@babcockbrown.com


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
