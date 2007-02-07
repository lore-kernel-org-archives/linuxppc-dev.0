Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 31C7CDDE43
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Feb 2007 09:07:22 +1100 (EST)
Subject: Re: mac-address vs. local-mac-address
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Timur Tabi <timur@freescale.com>
In-Reply-To: <45CA47AB.1000302@freescale.com>
References: <45CA41F7.6020700@freescale.com>
	<1170883956.2620.305.camel@localhost.localdomain>
	<45CA47AB.1000302@freescale.com>
Content-Type: text/plain
Date: Thu, 08 Feb 2007 09:07:12 +1100
Message-Id: <1170886032.2620.309.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Without a firmware device tree, there's no way to update the device tree and 
> have that new tree retained over a reboot.

I don't think it was ever question to update it over reboot...
mac-address is a runtime property that is lost at reboot, at least
that's my understanding of the OF behaviour. That's where your confusion
is.

Ben.
