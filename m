Return-Path: <st@iss.tu-darmstadt.de>
Received: from lnx130.hrz.tu-darmstadt.de (lnx130.hrz.tu-darmstadt.de
	[130.83.174.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 02D4A67B8F
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 29 Nov 2006 21:08:11 +1100 (EST)
Received: from mailserver3.hrz.tu-darmstadt.de (lnx116.hrz.tu-darmstadt.de
	[130.83.174.28])
	by lnx130.hrz.tu-darmstadt.de (8.13.4/8.12.10) with ESMTP id
	kAT9sIoR021561
	for <linuxppc-embedded@ozlabs.org>; Wed, 29 Nov 2006 10:54:18 +0100
Received: from [130.83.164.10] (helo=iss10.vlsi.informatik.tu-darmstadt.de)
	by mailserver3.hrz.tu-darmstadt.de with esmtpsa
	(TLS-1.0:DHE_RSA_AES_128_CBC_SHA1:16) (Exim 4.60)
	(envelope-from <st@iss.tu-darmstadt.de>) id 1GpM8w-0004XS-AS
	for linuxppc-embedded@ozlabs.org; Wed, 29 Nov 2006 10:54:18 +0100
From: Silken Tiger <st@iss.tu-darmstadt.de>
To: linuxppc-embedded@ozlabs.org
Subject: xilinx xup + 2.6.19-rc6 uartlite
Date: Wed, 29 Nov 2006 10:54:14 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200611291054.14913.st@iss.tu-darmstadt.de>
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

I was trying to get linux with the uartlite patches on a Xilinx XUP board 
running. Unfortunatly i get no output on the serial line. I have a other 2.6. 
Kernel running with serial output on this board. 

I have not given the uartlite the address of the uartlite address in my 
design, so i suppose it can not work. So how do i give the uartlite driver an 
idea where to find its Hardware? I think it could be done via kernel cmd line 
parameters?

.config settings:
CONFIG_UART0_TTYS0=y
CONFIG_SERIAL_UARTLITE=y
# CONFIG_SERIAL_8250 is not set
CONFIG_SERIAL_UARTLITE_CONSOLE=y
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y

Thanks 
ST

PS: please cc me as i am currently not subscribed to the list.
