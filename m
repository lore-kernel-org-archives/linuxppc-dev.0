Message-Id: <200008080036.e780a4X11121@skywarn.dr.lucent.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Why all the SAVE_ macros in transfer_to_handler (head.S)?
Date: Mon, 07 Aug 2000 18:36:04 -0600
From: William Kucharski <wkucharski@lucent.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is likely a FAQ, but does anyone know of any particular reason
transfer_to_handler() (in head.S) uses the three SAVE_ macros (SAVE_4GPRS,
SAVE_8GPRs, SAVE_8GPRS) rather than just the single instruction

    stmw  r8,(GPR8)r21

Yeah, I know the green book says this can have greater latency and take MUCH
longer to execute than separate instructions, but I've yet to find a CPU for
which this is actually true.

So, the question stands, anyone know the original rationale?  Historical
reasons?  To avoid case(s) in which it is true?  To avoid the POWER heritage of
the instruction?  Coding style differences?

					Thanks,
					    William Kucharski
					    wkucharski@lucent.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
