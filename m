From: "dong in kang" <dkang@east.isi.edu>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Need opinions: Porting PPC linux for a custom Prep board.
Date: Fri, 11 Jul 2003 11:50:49 -0400
Message-ID: <000901c347c4$33488a60$45a97241@Minjoo>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-reply-to: <20030711153310.7DD2FC6D82@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


 Hello,

 I'm trying to port MontaVista Linux for a custom Prep board.
The CPU is a variant of IBM PPC750, and the PCI bridge chip is a variant of
MPC106.
The architecture of the CPU is same as IBM PPC750.
The architecture of the bdidge chip is a superset of MPC106.
Any suggestion which code should I start with?

 I found some prep specific routines under arch/ppc/platform directory.
The codes seem to work for two targets, IBM prep and Motorolla prep.
If I had better start with one of them, which would be better?

 Thank you,

 Dong-In


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
