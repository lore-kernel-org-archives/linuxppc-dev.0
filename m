Date: Thu, 18 Mar 1999 18:12:41 +0100
To: Cort Dougan <cort@ladron.cs.nmt.edu>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Little compile fixes and pmac_ide.c
Message-Id: <19990318181241.023562@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'm getting back to vger and discovering all that has changed while I was
not playing with the kernel ;-)

I had to fix one or two things to get it compile (mostly include
asm/hydra.h and remove the bogus extern declaration of hydra_init() in
chrp_setup.c and declare xmon_irq) and I'll send you a little patch, but
I have a question:

All those pmac_ide_xxxx stubs in pmac_setup.c, is there a good reason for
keeping them here or could they be just moved to driver/block/ide-pmac.c ?


-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>




[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
