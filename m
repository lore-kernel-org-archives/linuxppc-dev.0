Message-Id: <m12mMrg-001SyZC@bucks>
From: diekema@bucks.si.com (diekema_jon)
Subject: Need R3 value passed into _start on the SBC8260
To: linuxppc-embedded@lists.linuxppc.org, dan@netx4.com
Date: Mon, 1 May 2000 16:32:23 -0400 (EDT)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


	In arch/ppc/mbxboot/head_8260.S, _start assumes that R3 is
	pointing to the board configuration data.  What does the
	MontaVista custom ROM on the EST SBC8260 board set R3 to before it
	jumps to _start?

	start_:
        mr      r11,r3          /* Save pointer to residual/board data */
        mr      r25,r5          /* Save OFW pointer */

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
