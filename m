Message-Id: <199908262105.XAA03192@piglet.cpu.lu>
Date: Thu, 26 Aug 1999 23:05:40 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: bug in l2cr status display?
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

While playing with the l2cr in order to set it manually after OF
booting, I've come across the following.

It seems that the effect of the L2CR[DO] bit isn't clear. In the 750
user manual, in the table describing l2cr, it says '... setting  this
bit enables the caching of instructions'. This doesn't corrsspond to
the name of the register, nor to what I see with my G3 upgrade card: in
normal operation, L2CR[DO] isn't set, but it makes no sense to disable
instruction caching excpet for test purposes.

So, what's happening? Is the user manual wrong? In that case, we should
correct arch/ppc/kernel/ppc_htab.c accordingly.

Any Motorola engineer around? Others with better docs? FWIW, I checked
the 750 errata already... nothing.

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
