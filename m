Message-ID: <38899196.9B46B7F4@denise.shiny.it>
Date: Sat, 22 Jan 2000 12:16:38 +0100
From: Giuliano Pochini <pochini@denise.shiny.it>
MIME-Version: 1.0
To: Robert Neugebauer <rneugeba@undergrad.math.uwaterloo.ca>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: RS6000 to G4 assembly changes
References: <Pine.SOL.3.96.1000121133401.17001B-100000@bacon.math.uwaterloo.ca>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



> I am trying to compile a compiler used by my university for my linuxppc
> machine. The compiler supports various architecture including rs6000 and i
> 386 linux.

gcc ?

> By my limited understanding, rs6000 assembler is very similar to powerpc
> assembler

RS6000 computers use PowerPC processors. I don't know if Power processors
(64 bit version of ppc) are supported.


> Anyway, in attempting to compile
> this, gcc complains about an unrecognized opcode movl.

"movl" is an x86 opcode. ppc have l* and st*.

Bye.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
