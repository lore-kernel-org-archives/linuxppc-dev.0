Return-Path: <Jogi95@web.de>
Received: from fmmailgate04.web.de (fmmailgate04.web.de [217.72.192.242])
	by ozlabs.org (Postfix) with ESMTP id 85C13DDEC4
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  8 Jan 2008 07:41:25 +1100 (EST)
Received: from web.de
	by fmmailgate04.web.de (Postfix) with SMTP id A69A941EB97E
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  7 Jan 2008 21:41:22 +0100 (CET)
Date: Mon, 07 Jan 2008 21:41:22 +0100
Message-Id: <520220685@web.de>
MIME-Version: 1.0
From: Joachim Meyer <Jogi95@web.de>
To: linuxppc-embedded@ozlabs.org
Subject: Linux for ml310
Content-Type: text/plain; charset=iso-8859-15
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi

I'm trying to run a Linux System on a ml310
I'm using the Kernel 2.4.26 from Bitkeeper und and EDK9.1 Sp2
I can compile my Kernel without Errors, with a Crosscompiler made by crosstools, if I don't copy the BSP files in the Kernel Directory.
If I do so, I can't compile. It aborts with the error:
serial.c:4040: error: 'XPAR_UARTNS550_0_CLOCK_FREQ_HZ' undeclared (first use in this function)
If I don't use the UART in my Kernel config I get other errors like:
adapter.c:96: error: `XPAR_XEMAC_NUM_INSTANCES' undeclared (first use in this function)
I don't really know what to do now. Where should I look for the solution?
Did I something wrong by generating the BSP or do I have to use an older version of the edk/ise?

When I was trying to find a solution I read some of the things in this mailing list, and now I'm concered about these 2 points
-Board
-Kernel Version
Is it a good idea to use the ml310?
I want a Linux, an ethernet device, a RS232 device and system-ace. Later I would try to patch the Linux with rtai for real-time-support.
I read about troubles with the ethernet device on the ml310 because of troubles with the pci bus. Would it be much easier to use an XUP-Board?
Would it be easier to use the kernel 2.6.x? Has anybody experience in running an rtai-patched Linux on an ml310 - bzw XUP Board?

Greetings & THX Joachim
______________________________________________________________________
XXL-Speicher, PC-Virenschutz, Spartarife & mehr: Nur im WEB.DE Club!		
Jetzt testen! http://produkte.web.de/club/?mc=021130
