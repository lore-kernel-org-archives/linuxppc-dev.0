Date: Fri, 23 Jul 1999 18:18:31 +0200
To: linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: sl82c105.c cleanup
Message-Id: <19990723181831.020978@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi !

I'm working on an ARM-based board using the 553 winbond chipset. I'm
using some netwinder-specific patches to the file sl82c105.c that I'm
fixing for correct handling of both channels. Those patches add a tune
function for pio mode > 0.

I've seen some ppc and MBX specific code there too, so if you are
actually working on this file or have patches for this, please tell me so
we can sync. I'd like also to know what's the purpose of the current code.


-- 
           Perso. e-mail: <mailto:bh40@calva.net>
           Work   e-mail: <mailto:benh@mipsys.com>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>




[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
