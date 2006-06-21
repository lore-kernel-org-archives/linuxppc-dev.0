Return-Path: <laurent.pinchart@tbox.biz>
Received: from outmx010.isp.belgacom.be (outmx010.isp.belgacom.be
	[195.238.5.233])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7B93367A5F
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 21 Jun 2006 19:44:56 +1000 (EST)
Received: from outmx010.isp.belgacom.be (localhost [127.0.0.1])
	by outmx010.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id k5L9ijQe026454
	for <linuxppc-embedded@ozlabs.org>; Wed, 21 Jun 2006 11:44:46 +0200
	(envelope-from <laurent.pinchart@tbox.biz>)
Received: from servernt.technotrade (49.198-78-194.adsl-fix.skynet.be
	[194.78.198.49])
	by outmx010.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id k5L9iaLv026336
	for <linuxppc-embedded@ozlabs.org>; Wed, 21 Jun 2006 11:44:37 +0200
	(envelope-from <laurent.pinchart@tbox.biz>)
From: Laurent Pinchart <laurent.pinchart@tbox.biz>
To: linuxppc-embedded@ozlabs.org
Subject: Adding an external interrupt controller
Date: Wed, 21 Jun 2006 11:46:34 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200606211146.34720.laurent.pinchart@tbox.biz>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi everybody,

I'm trying to write a driver for a custom extension bus mapped in my MPC8248 
memory space.

The bus has 32 interrupt lines which are handled by an interrupt controller 
connected to a single external interrupt on the MPC8248.

I've had a look at the Linux interrupt management code, but haven't found any 
easy API to add an external interrupt controller. Could someone give me a few 
pointers regarding how to proceed ? I would like to "register" the interrupt 
controller with the interrupt management core, so that 
request_irq()/free_irq() could be used with the extra interrupts.

Thanks in advance for your help.

Best regards,

Laurent Pinchart

PS: If this is not architecture-specific and should be asked on the 
linux-kernel mailing list, please let me know.
