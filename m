Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (dsl027-180-168.sfo1.dsl.speakeasy.net
	[216.27.180.168]) by ozlabs.org (Postfix) with ESMTP id A3A4767B67
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Aug 2006 08:29:50 +1000 (EST)
Date: Wed, 16 Aug 2006 15:29:19 -0700 (PDT)
Message-Id: <20060816.152919.88472383.davem@davemloft.net>
To: arnd@arndb.de
Subject: Re: [PATCH 1/2]: powerpc/cell spidernet bottom half
From: David Miller <davem@davemloft.net>
In-Reply-To: <200608170016.47072.arnd@arndb.de>
References: <200608162324.47235.arnd@arndb.de>
	<20060816.143203.11626235.davem@davemloft.net>
	<200608170016.47072.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Cc: akpm@osdl.org, jeff@garzik.org, netdev@vger.kernel.org, jklewis@us.ibm.com,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Jens.Osterkamp@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 17 Aug 2006 00:16:46 +0200

> Am Wednesday 16 August 2006 23:32 schrieb David Miller:
> > Can spidernet be told these kinds of parameters? =A0"N packets or
> > X usecs"?
> =

> It can not do exactly this but probably we can get close to it by

Oh, you can only control TX packet counts using bits in the TX ring
entries :(

Tigon3 can even be told to use different interrupt mitigation
parameters when the cpu is actively servicing an interrupt for
the chip.

Didn't you say spidernet's facilities were sophisticated? :)
This Tigon3 stuff is like 5+ year old technology.
