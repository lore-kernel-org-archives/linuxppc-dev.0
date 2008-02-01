Return-Path: <marco.stornelli@coritel.it>
Received: from nausicaa2.coritel.it
	(host254-130-static.190-82-b.business.telecomitalia.it
	[82.190.130.254]) by ozlabs.org (Postfix) with ESMTP id 87E97DDDF5
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Feb 2008 19:31:43 +1100 (EST)
Received: from localhost (nausicaa2.coritel.it [127.0.0.1])
	by nausicaa2.coritel.it (Postfix) with ESMTP id 1317A434002
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Feb 2008 09:04:58 +0100 (CET)
Received: from nausicaa2.coritel.it ([127.0.0.1])
	by localhost (nausicaa2.coritel.it [127.0.0.1]) (amavisd-new,
	port 10024)
	with ESMTP id iOz-tJ3WMj2Z for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Feb 2008 09:04:57 +0100 (CET)
Received: from [192.168.2.2] (217-133-82-13.b2b.tiscali.it [217.133.82.13])
	by nausicaa2.coritel.it (Postfix) with ESMTP id 2526D434001
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Feb 2008 09:04:57 +0100 (CET)
Message-ID: <47A2D424.3090903@coritel.it>
Date: Fri, 01 Feb 2008 09:11:16 +0100
From: Marco Stornelli <marco.stornelli@coritel.it>
MIME-Version: 1.0
To: Linuxppc Embedded Mailing List <linuxppc-embedded@ozlabs.org>
Subject: External Interrupt
Content-Type: text/plain; charset=ISO-8859-15
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

I used the linux kernel 2.6.10 with a processor MPC8548E. I wrote a
driver for a device connected with the local bus. This device has an
external interrupt. In the local bus driver I have used the macro
MPC85xx_IRQ_EXT<X> to get the interrupt number and pass it to the
driver and after that register the ISR. Now with a kernel 2.6.21 this
macro isn't available because in the header file irq.h there is the
option CONFIG_PPC_MERGE that disable those options. I think this
problem is related to the migration of ppc code towards powerpc. I
know that now there is the new device tree source file where I can add
a device and its interrupt number  but I think in this file I should
describe only the platform device, and this device is not a platform
device. Then, how can I get now this  value? Is there some function to
call? How can I perform this operation?

Thanks in advance.

Marco
