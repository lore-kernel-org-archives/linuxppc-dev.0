Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 85677DDEBB
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 17:48:03 +1100 (EST)
Date: Fri, 18 Jan 2008 00:45:40 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: Re: [PATCH 1/3] [NET] phy/fixed.c: rework to not duplicate PHY layer
	functionality
In-Reply-To: <20071206225121.31080.86606.stgit@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0801180045230.16260@blarg.am.freescale.net>
References: <20071206225121.31080.86606.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: netdev@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 7 Dec 2007, Vitaly Bordug wrote:

>
> With that patch fixed.c now fully emulates MDIO bus, thus no need
> to duplicate PHY layer functionality. That, in turn, drastically
> simplifies the code, and drops down line count.
>
> As an additional bonus, now there is no need to register MDIO bus
> for each PHY, all emulated PHYs placed on the platform fixed MDIO bus.
> There is also no more need to pre-allocate PHYs via .config option,
> this is all now handled dynamically.
>
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> Signed-off-by: Vitaly Bordug <vitb@kernel.crashing.org>
> Acked-by: Jeff Garzik <jeff@garzik.org>
>
> ---
>
>  drivers/net/phy/Kconfig   |   32 +--
>  drivers/net/phy/fixed.c   |  445 +++++++++++++++++----------------------------
>  include/linux/phy_fixed.h |   51 ++---
>  3 files changed, 195 insertions(+), 333 deletions(-)
>

applied.

- k
