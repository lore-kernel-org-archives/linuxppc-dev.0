From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15363.31192.101536.919771@gargle.gargle.HOWL>
Date: Tue, 27 Nov 2001 22:32:40 +1100 (EST)
To: linuxppc-dev@lists.linuxppc.org
Subject: include/asm-ppc/platforms/
Reply-To: paulus@samba.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I want to create a new directory, include/asm-ppc/platforms, for those
files which mainly contain configuration information for specific
platforms, such as address and IRQ assignments for on-board devices.
The files that I want to move into include/asm-ppc/platforms are:

bseip.h		  ibm405gp.h	    mvme5100_serial.h	  rpxclassic.h
ccm.h		  ibmnp405.h	    oak.h		  rpxhiox.h
ceder.h		  ibmstbx.h	    pcu_e.h		  rpxlite.h
cpci405.h	  ip860.h	    powerpmc250.h	  sandpoint_serial.h
ep405.h		  ivms8.h	    powerpmc250_serial.h  spd8xx.h
est8260.h	  lantec.h	    ppc4xx_serial.h	  spruce.h
ev64260_serial.h  lopec_serial.h    prpmc750.h		  spruce_serial.h
fads.h		  lwmon.h	    prpmc750_serial.h	  tqm8260.h
gemini.h	  mbx.h		    prpmc800.h		  tqm8xx.h
gemini_serial.h   mcpn765_serial.h  prpmc800_serial.h	  walnut.h
hermes.h	  mvme5100.h	    redwood.h		  zx4500_serial.h

This requires corresponding minor changes to 14 files in
arch/ppc/platforms and 5 files in include/asm-ppc, plus some changes
in the files that move to include/asm-ppc/platforms.

Does anyone have any comments or objections?

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
