Message-ID: <412C8C11.4010608@il.marvell.com>
Date: Wed, 25 Aug 2004 15:54:41 +0300
From: Ronen Shitrit <rshitrit@il.marvell.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: graphic card framebuffer
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi

I'm using kernel 2.4.23 with U-boot 1.0.0 as the firmware,
I'm trying to use a graphic card as a frame buffer.
I have a PCI graphic card CIRUUS LOGIC 5446 which is working fine
I get the Linux penguin and I can run startx on it with out any problem.
but when I'm I'm trying to use CIRRUS LOGIC 5464 I only get a blank screen??
when I'm trying to use an invidia RIVA TNT2 the kernel get stuck when
trying to
run accel engine??
when I'm trying to use ATI 3D rage II I get a screen full of vertical line??
I have no special initialization in the U-Boot for the graphic card, and
I compile
the above graphic card as part of the kernel.
Does the kernel drivers based on some bios initializations??
Can I remove the graphic card driver from the kernel and still use the
XFree86 to
initialize the graphic card?? (when I try to do it I get an error that
/dev/fb0 doesn't exist??)

any help will be appreciated
Regards

--
Ronen Shitrit

M.S.I.L
6 Ha'mada St.
Industrial Area
P.O.Box 692
Yokneam  20692  ISRAEL
Tel: +972-4-9091500
Fax: +972-4-9091501


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
