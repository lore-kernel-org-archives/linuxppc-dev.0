Return-Path: <laurent.pinchart@technotrade.biz>
From: Laurent Pinchart <laurent.pinchart@technotrade.biz>
To: Linuxppc-embedded@ozlabs.org
Subject: Compiling interrupt controller code as a module
Date: Tue, 17 Apr 2007 17:31:43 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200704171731.43608.laurent.pinchart@technotrade.biz>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi everybody.

I wrote a kernel driver for a custom bus (using arch/ppc). The hardware has a 
cascaded interrupt controller wired to one of the CPU interrupts. The 
interrupt controller IRQ handler calls __do_IRQ() to dispatch interrupts.

Everything worked fine until I tried to compile the code as a module because 
__do_IRQ() is not exported. Is there a way to compile an interrupt controller 
as a module, or must it be included in the kernel ?

Best regards,

Laurent Pinchart
