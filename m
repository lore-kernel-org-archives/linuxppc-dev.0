Message-ID: <35C119252057D511BB9F0003476BF8A208E5BB@freexc01.smartm.com>
From: "Prasad, Siva" <Siva.Prasad@smartm.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: head.S compilation problem
Date: Mon, 24 Sep 2001 15:54:07 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I am trying to build the kernel 2.2.14 that came with HHL CDK 1.2. I am
using the rpm utilities provided with the same CD to build (ppc_7xx-*)

PPC 750.

I get the following errors, which I don't understand how to solve.

head.S: Assember messages:
head.S:534: Error: attempt to .org backwards ignored
make[1]; *** [head.o] Error 1

When I looked at the line # 534 in head.S, it was...
STD_EXCEPTION(0x100, Reset, UnknownException)
which is a macro. I clearly don't understand this.

I thought probably the gnu tools that came with CD are old.. So I used cross
compiler toosl that I built recently. Same error still.
Versions of utils that I built are...
glibc: 2.2.3
gcc-core: 2.95.3
binutils: 2.11

Can some please help me out with this compilation problem.

Thansk in advance.

-- Siva

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
