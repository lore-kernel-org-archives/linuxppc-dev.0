Return-Path: <benjamin.collar@siemens.com>
Received: from goliath.siemens.de (goliath.siemens.de [192.35.17.28])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 965632BC0F
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 20 Oct 2004 22:04:48 +1000 (EST)
Received: from mail1.siemens.de (mail1.siemens.de [139.23.33.14])
	by goliath.siemens.de (8.12.6/8.12.6) with ESMTP id i9KC4aP6000290
	for <linuxppc-embedded@ozlabs.org>; Wed, 20 Oct 2004 14:04:36 +0200
Received: from mhpajh5c (mhpajh5c.mchp.siemens.de [139.23.185.152])
	by mail1.siemens.de (8.12.6/8.12.6) with ESMTP id i9KC4Zma006371
	for <linuxppc-embedded@ozlabs.org>; Wed, 20 Oct 2004 14:04:35 +0200
From: Benjamin Collar <benjamin.collar@siemens.com>
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain
Date: Wed, 20 Oct 2004 14:03:11 +0200
Message-Id: <1098273791.26876.44.camel@mhpajh5c>
Mime-Version: 1.0
Subject: Solved: Re: question 1: printk works, outputting to /dev/console
	and/or/dev/ttyS0 doesn't
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Greetings folks

shamefacedly, I will admit I have no idea what I was doing, and was
thus---doing it wrong.

removing CONFIG_SERIAL from the kernel config fixes the problem. Turns
out arch/ppc/8xx_io/uart.c registers the serial device and later
drivers/char/serial.c registers the same device, and thus nothing works.

Thanks for the hints that I did receive.

Ben

-- 
Benjamin Collar
Siemens AG
CT SE 2
Embedded Linux
089-636-53711
