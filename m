Message-Id: <200010032004.WAA09422@piglet.grunz.lu>
Date: Tue, 3 Oct 2000 22:04:33 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: l2cr function corrections for G4
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Ben,

Attached are two patches that fix handling of G4 processors in the
_get/_set_L2CR() functions. Nothing fancy; basically just a branch that
got lost.

You might want to push this into both 2.2 and 2.4 trees asap...

Cheers

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
