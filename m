Date: Tue, 27 Jul 2004 12:32:43 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: [PATCH] add reserved and smc_rpbase field to smc_uart
Message-ID: <Pine.LNX.4.60.0407271230520.5926@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


   first patch to add the required reloc field for SMC1 relocation --
is this the appropriate format?


--- linuxppc-2.5/include/asm-ppc/commproc.h 2004-07-27 12:23:32.723864264 -0400
+++ linuxppc-2.5.new/include/asm-ppc/commproc.h	2004-07-27 12:29:27.609913384 -0400
@@ -145,6 +145,8 @@
  	ushort	smc_brkec;	/* rcv'd break condition counter */
  	ushort	smc_brkcr;	/* xmt break count register */
  	ushort	smc_rmask;	/* Temporary bit mask */
+	uchar	smc_res[8];	/* Reserved to push next field to 0x3C */
+	ushort	smc_rpbase;	/* Relocation pointer */
  } smc_uart_t;

  /* Function code bits.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
