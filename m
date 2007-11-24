Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4FE52DDDCA
	for <linuxppc-dev@ozlabs.org>; Sun, 25 Nov 2007 09:28:19 +1100 (EST)
Subject: Re: [PATCH 4/5] PowerPC 74xx: Katana Qp base support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200711241952.00186.arnd@arndb.de>
References: <20071116163116.GE25062@ru.mvista.com>
	<200711241952.00186.arnd@arndb.de>
Content-Type: text/plain
Date: Sun, 25 Nov 2007 09:28:04 +1100
Message-Id: <1195943284.7195.63.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sat, 2007-11-24 at 19:51 +0100, Arnd Bergmann wrote:
> 
> This should be done automatically using of_platform_bus_probe().

Not necessarily. of_platform_bus_probe() is an optional facility that is
common used by SoCs that have lots of otherwise non-probable on chip
devices, but for platforms with more classic setups, it's totally
acceptable to have the platform code explicitely register only those
devices it wants exposed.

Ben.
