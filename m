Date: Fri, 21 Jan 2000 13:40:14 -0500 (EST)
From: Robert Neugebauer <rneugeba@undergrad.math.uwaterloo.ca>
To: linuxppc-dev@lists.linuxppc.org
Subject: RS6000 to G4 assembly changes
Message-ID: <Pine.SOL.3.96.1000121133401.17001B-100000@bacon.math.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I am trying to compile a compiler used by my university for my linuxppc
machine. The compiler supports various architecture including rs6000 and i
386 linux.

By my limited understanding, rs6000 assembler is very similar to powerpc
assembler, they are both RISC computers. Anyway, in attempting to compile
this, gcc complains about an unrecognized opcode movl. This is the only
opcode that it has complained about so far.

If anyone knows what this should be changed to, that would be very much
appreciated. Also if anyone can think of any other issues that might
arrise, I would appreciate that as well.

Bob Neugebauer


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
