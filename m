Date: Fri, 10 Dec 1999 15:37:08 -0600 (CST)
From: Kumar Gala <kumar@chaos.ph.utexas.edu>
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: 2.3.x builds
Message-ID: <Pine.LNX.4.10.9912101535360.31585-100000@chaos.ph.utexas.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Has anyone built 2.3.x with the latest gcc and binutils?  I am having a
problem with entry.S and issues with alignment padding.  It believe it is
do to the marcros defined in ppc_asm.h for tophys and tovirt that have
.align 1; in them

- kumar



ignorance is bliss.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
