Message-Id: <200108190938.LAA00865@piglet.grunz.lu>
Date: Sun, 19 Aug 2001 11:38:14 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Strange OF display while booting
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

With recent BenH kernels, the early boot messages (before switching to
aty128fb in my case) are messed up. The first few messages start in the
middle of the top row, with some white areas to the left of the
messages, then at the middle hight of the screen there's a white area
spannig all the width, and below that the text messages are aligned
correctly again to the left edge of the screen.

FWIW, this was not the case with older kernels (2.4.5-pre3 comes to
mind).

Maybe somenody will know what changed...

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
