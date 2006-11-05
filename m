Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E6FCA67BEA
	for <linuxppc-dev@ozlabs.org>; Sun,  5 Nov 2006 23:59:13 +1100 (EST)
Subject: Re: [Fwd: [Bug 7431] New: ohci1394 Oops after a rmmod/modprobe	cycle]
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
In-Reply-To: <454DCCE8.4020402@s5r6.in-berlin.de>
References: <454DBFE7.3090800@s5r6.in-berlin.de>
	<1162724083.28571.235.camel@localhost.localdomain>
	<454DC985.2020203@s5r6.in-berlin.de>
	<454DCCE8.4020402@s5r6.in-berlin.de>
Content-Type: text/plain
Date: Sun, 05 Nov 2006 23:59:04 +1100
Message-Id: <1162731544.28571.237.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Gioele Barabucci <dev@gioelebarabucci.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Hm. There is the following comment in ohci1394_pci_remove():
> 
> 	/* On UniNorth, power down the cable and turn off the chip
> 	 * clock when the module is removed to save power on
> 	 * laptops. Turning it back ON is done by the arch code when
> 	 * pci_enable_device() is called */
> 
> Is this true or wrong in current kernels?

Might have bitrotted.... I'll have a look.

Ben.
