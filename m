Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5BAE1DDE37
	for <linuxppc-dev@ozlabs.org>; Wed,  9 May 2007 09:24:10 +1000 (EST)
Subject: Re: [PATCH 1/4] Add support for 750CL Holly board
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200705051308.11457.arnd@arndb.de>
References: <1178302414.3026.202.camel@zod.rchland.ibm.com>
	<200705042144.31194.arnd@arndb.de>
	<1178308913.3026.238.camel@zod.rchland.ibm.com>
	<200705051308.11457.arnd@arndb.de>
Content-Type: text/plain
Date: Wed, 09 May 2007 09:24:01 +1000
Message-Id: <1178666641.14928.124.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> A Kconfig option won't help at all. The phy should come as a device node
> below the ethernet device. When probing the device, look at the
> "compatible" and "reg" properties in there.

That's overkill. You don't need that unless you add specific
config/setup informations for the PHY. PHYs can be probed easily enough.

Ben.
