Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 76B4ADDE10
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Jun 2008 02:32:29 +1000 (EST)
Date: Mon, 2 Jun 2008 11:32:15 -0500
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] phylib: Don't allow core of phylib to build as a module
Message-ID: <20080602163215.GA3400@loki.buserror.net>
References: <Pine.LNX.4.64.0806021019540.22439@blarg.am.freescale.net>
	<484419EE.5040503@garzik.org>
	<1E4EB64C-0618-497E-AABC-74EB7D74B97F@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1E4EB64C-0618-497E-AABC-74EB7D74B97F@kernel.crashing.org>
Cc: netdev@vger.kernel.org, Jeff Garzik <jeff@garzik.org>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jun 02, 2008 at 11:25:14AM -0500, Kumar Gala wrote:
> The core provides functions like phy_read/phy_write.  Andy has recently 
> introduced board level workaround/fixups.  The problem is these 
> workarounds tend to use phy_read/phy_write and the board/platform code is 
> not built as modules.

So why not have those platforms select PHYLIB?

-Scott
