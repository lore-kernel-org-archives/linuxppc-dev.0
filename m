Return-Path: <SEW_S@tqs.de>
Received: from mail.tqs.de (mail.tqs.de [62.157.136.17])
	by ozlabs.org (Postfix) with ESMTP id 8DADCDE1DA
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 30 Oct 2007 20:19:27 +1100 (EST)
Received: from tq-mailsrv.tq-net.de (tq-mailsrv.tqs.de [172.20.1.2])
	by mail.tqs.de (Postfix) with ESMTP id 18322A71B
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 30 Oct 2007 09:50:45 +0100 (CET)
Message-ID: <4726F065.5050702@tqs.de>
Date: Tue, 30 Oct 2007 09:50:45 +0100
From: Jens Gehrlein <sew_s@tqs.de>
MIME-Version: 1.0
To: linuxppc-embedded Mailinglist <linuxppc-embedded@ozlabs.org>
Subject: MPC8360: Support for two SDRAM banks in the Kernel memory management?
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

the MPC8360 has two DDR SDRAM controllers. In the 2x32 bit mode
data transfers from/to the SDRAM can be handled by the MPC and the
QUICC Engine independently. For instance, the core can access one
bank and the QUICC Engine can access the other bank via DMA for
lookup tables, temporary buffers, etc. in the same time.

IMHO the Linux Kernel supports only one linear virtual address space.
So how could the kernel memory management (DMA, alloc, etc.) ensure,
that data transfers go from/to the QUICC Engine to/from the second
SDRAM bank?

Does anybody know if bank-separated memory management is supported
by the Linux Kernel, especially for the MPC8360?

Thanks in advance
   Jens
