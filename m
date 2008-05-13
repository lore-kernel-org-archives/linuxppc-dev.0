Return-Path: <SEW_S@tqs.de>
Received: from mail.tqs.de (mail.tqs.de [62.157.136.17])
	by ozlabs.org (Postfix) with ESMTP id 4E280DE039
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 May 2008 02:25:35 +1000 (EST)
Received: from tq-mailsrv.tq-net.de (tq-mailsrv.tqs.de [172.20.1.2])
	by mail.tqs.de (Postfix) with ESMTP id 18A50E4B3
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 13 May 2008 18:04:42 +0200 (CEST)
Message-ID: <4829BC19.5000909@tqs.de>
Date: Tue, 13 May 2008 18:04:41 +0200
From: Jens Gehrlein <sew_s@tqs.de>
MIME-Version: 1.0
To: linuxppc-embedded Mailinglist <linuxppc-embedded@ozlabs.org>
Subject: smc911x: how to call the driver?
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

on our board a SMSC LAN9215i is connected to an i.MX31 ARM processor. My 
hope is to get the smc911x driver run on this chip. The LAN921x data 
sheets say that existing 911x drivers should work.

The first I had to patch was the Kconfig file, in which the smc911x 
driver is only available on PXA architecture:
- depends on NET_ETHERNET && ARCH_PXA
+ depends on NET_ETHERNET && (ARCH_PXA || ARCH_MXC)
So the driver got at least compiled.

My next problem is:
Where and when get the functions smc911x_drv_probe() and smc911x_init() 
called? Any hints?

Thank you in advance.

Best Regards,
Jens
