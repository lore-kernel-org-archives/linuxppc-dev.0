Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EAECADDE1B
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Oct 2008 07:15:33 +1100 (EST)
Subject: Re: Connecting to "PCI command write" interrupt on 4xx platforms
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
In-Reply-To: <200810301158.46686.matthias.fuchs@esd-electronics.com>
References: <200810301158.46686.matthias.fuchs@esd-electronics.com>
Content-Type: text/plain
Date: Fri, 31 Oct 2008 07:15:12 +1100
Message-Id: <1225397712.8004.173.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-10-30 at 11:58 +0100, Matthias Fuchs wrote:
> I need to connect to the "PCI command write" interrupt on a 440EPx
> platform. This is UIC0/int#5.
> 
> Where should I add this interrupt in the DT? To the PCI node? In this
> case it will collide with the 
> PCI interrupts.
> 
> My application is a 440EPx on a PCI addon card. So the PCI node is
> disabled in the DT.
> 
> Is there a way to get an interrupt number for request_irq() without
> querying the DT?

What is this interrupt precisely ? What emits it ? If it's coming from
the actual PCI bridge, then you can stick an interrupts property in the
PCI host bridge node in the DT just fine.

Cheers,
Ben.
