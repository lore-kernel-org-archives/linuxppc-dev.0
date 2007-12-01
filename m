Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1F391DDD04
	for <linuxppc-dev@ozlabs.org>; Sun,  2 Dec 2007 08:59:56 +1100 (EST)
Message-ID: <4751D958.6060500@garzik.org>
Date: Sat, 01 Dec 2007 16:59:52 -0500
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: Re: [PATCH 1/3] [NET] phy/fixed.c: rework to not duplicate PHY layer
	functionality
References: <20071126142906.19642.45540.stgit@localhost.localdomain>
In-Reply-To: <20071126142906.19642.45540.stgit@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Vitaly Bordug wrote:
> With that patch fixed.c now fully emulates MDIO bus, thus no need
> to duplicate PHY layer functionality. That, in turn, drastically
> simplifies the code, and drops down line count.
> 
> As an additional bonus, now there is no need to register MDIO bus
> for each PHY, all emulated PHYs placed on the platform fixed MDIO bus.
> There is also no more need to pre-allocate PHYs via .config option,
> this is all now handled dynamically.
> 
> p.s. Don't even try to understand patch content! Better: apply patch
> and look into resulting drivers/net/phy/fixed.c.
> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> Signed-off-by: Vitaly Bordug <vitb@kernel.crashing.org>

what's the context of this patchset?  2.6.25?

it's late for 2.6.24-rc, IMO.

Do I have the latest version (sent Nov 26 @ 9:29am)?

	Jeff
