Date: Wed, 30 Jun 1999 15:14:55 +0200
To: linuxppc-dev@lists.linuxppc.org
CC: Geert.Uytterhoeven@cs.kuleuven.ac.be, Christian.Bauer@uni-mainz.de
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: DGA applications not working
Message-Id: <19990630151455.027635@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


HI !

I'm having a problem with the XFBDev server that comes bundled with
linuxppc R5, and I really don't know what's going on and how I can fix
that. Basically, when I try to use a DGA-based application, I get an
error message in the console saying:

"XF86DGAGetVideo: failed to mmap /dev/kmem (Device not configured)"

I'm using a 2.2.10 kernel with controlfb.

If someone what to test this, a DGA application that fails is Basilic II
(Mac 68k emulator) that can be found at <http://www.uni-mainz.de/~bauec002/>

Any clues ?


-- 
           Perso. e-mail: <mailto:bh40@calva.net>
           Work   e-mail: <mailto:benh@mipsys.com>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>




[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
