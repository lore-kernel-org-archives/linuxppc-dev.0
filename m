Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9FE8CDDE07
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 07:20:03 +1000 (EST)
In-Reply-To: <200707112233.51899.arnd@arndb.de>
References: <20070616000511.712667424@arndb.de>
	<20070616000618.183462070@arndb.de>
	<20070711153542.GB11516@mag.az.mvista.com>
	<200707112233.51899.arnd@arndb.de>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <36404B9A-D091-493C-85B7-3B261A74B7CE@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [patch 1/9] move 82xx/83xx/86xx Kconfig options to platform
	selection
Date: Wed, 11 Jul 2007 23:19:05 +0200
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Which systems in particular should allow CONFIG_TAU? Is there a more
> specific dependency than (6xx && !(82xx || 83xx || 86xx || 52xx))?

7xx and 7xxx CPUs (G3 and G4).  Nothing earlier (according to
the IEEE article introducing the TAU), maybe some later units
have it though (but I think they have incompatible things with
a similar function).

TAU is broken on many CPU models btw (it works, just gives
back nonsense results).


Segher
