Message-ID: <000d01c10a1e$a7fda880$0401a8c0@trex>
From: "Jeff Rugen" <jprugen@earthlink.net>
To: "linuxppc-dev" <linuxppc-dev@lists.linuxppc.org>
Subject: Undefined symbols that are in System.map?
Date: Wed, 11 Jul 2001 08:32:08 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have a 2.2.20pre6 kernel (from vger.samba.org rsync). I've compiled the
clgen framebuffer as a module, and have the VGA console built in.  When I
try to modprobe clgenfb, I am notified that vga_con and conswitchp are
unresolved, so the various fbcon-cfb*.o modules won't install. fbgen.o will
install manually.

vga_con and conswitchp are both in my System.map file:
c017ac94 D vga_con
c017b22d D conswitchp

When I run 2.4.6, compiled with a VGA console built in, and clgen as a
module, it allows me to modprobe clgenfb.  That System.map file looks like:
c0146554 R vga_con
c01ba4d4 B conswitchp

I'm noting them both because of the difference in location of the symbols
(uninitialized data, initialized data, read only data).  What would be
causing this?  I haven't tried ignoring the errors.

Thanks.

Jeff Rugen


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
