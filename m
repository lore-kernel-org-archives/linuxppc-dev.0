Message-ID: <A3E34B558F5CD211B4980008C7A4A99003C58441@sparrow.eng.gilbarco.com>
From: "Williams, Kevin M." <kevin.m.williams@marconi.com>
To: "'Tom Rini'" <trini@kernel.crashing.org>
Cc: embarque ppc <linuxppc-embedded@lists.linuxppc.org>
Subject: minor commproc.h fix
Date: Thu, 27 Sep 2001 13:35:32 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Can you please make the following change to the linuxppc_2_4 tree:

3 is odd parity, 2 is even. See page 22-14 of the MPC850 user's manual.
Thanks!

Kevin

Index: commproc.h
===================================================================
file: /include/asm-ppc/commproc.h
760c760
-#define SCU_PMSR_TEVP		((ushort)0x0003)
+#define SCU_PMSR_TEVP		((ushort)0x0002)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
