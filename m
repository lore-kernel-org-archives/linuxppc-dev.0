Date: Fri, 6 Feb 2004 13:47:28 +1100 (EDT)
Message-Id: <200402060247.NAA20760@sprint.tenix.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Interrupts on PPC 405Gr
From: "MERRITT Nigel" <Nigel.Merritt@tenix.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am using an IBM PowerPC 405Gr and have been trying to set up IRQ5 as an interrupt.  My problem is that the UIC0_ER (interrupt enable) register is not being set by the request_irq call.  I have used enable_irq after request_irq but this also has no affect.  As this is from a driver, I have even tried setting the correct bit (bit 30 for IRQ 5) directly, by reading UIC0_ER, ORing bit 30 and writing the value back - reading and writing were performed using mfdcr and mtdcr.
I also use mtmsr to set the general interrupt enable bit (EE - bit 16)) in the MSR register.

Does anyone know of other calls that need to be made in order to allow the interrupt enable register to stay set?

   Nigel Merritt

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
