Return-Path: <rsc@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4BFE5B7199
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 10 Aug 2011 18:15:41 +1000 (EST)
Date: Wed, 10 Aug 2011 10:15:26 +0200
From: Robert Schwebel <r.schwebel@pengutronix.de>
To: Robin Holt <holt@sgi.com>
Subject: Re: [PATCH v10 5/5] [powerpc] Fix up fsl-flexcan device tree binding.
Message-ID: <20110810081526.GW31398@pengutronix.de>
References: <1312945564-6626-1-git-send-email-holt@sgi.com>
	<1312945564-6626-6-git-send-email-holt@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <1312945564-6626-6-git-send-email-holt@sgi.com>
Cc: netdev@vger.kernel.org, U Bhaskar-B22300 <B22300@freescale.com>,
	socketcan-core@lists.berlios.de, Scott Wood <scottwood@freescale.com>,
	PPC list <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Robin,

On Tue, Aug 09, 2011 at 10:06:04PM -0500, Robin Holt wrote:
> In working with the socketcan developers, we have come to the conclusion
> the Documentation...fsl-flexcan.txt device tree documentation needs to
> be cleaned up.  The driver does not depend upon any properties other
> than the required properties so we are removing the file.  Additionally,
> the p1010*dts* files are not following the standard for node naming in
> that they have a trailing -v1.0.
>
> Signed-off-by: Robin Holt <holt@sgi.com>
> To: Marc Kleine-Budde <mkl@pengutronix.de>,
> To: Wolfgang Grandegger <wg@grandegger.com>,
> To: U Bhaskar-B22300 <B22300@freescale.com>
> To: Scott Wood <scottwood@freescale.com>
> Cc: socketcan-core@lists.berlios.de,
> Cc: netdev@vger.kernel.org,
> Cc: PPC list <linuxppc-dev@lists.ozlabs.org>
> Cc: Kumar Gala <galak@kernel.crashing.org>
> ---
>  .../devicetree/bindings/net/can/fsl-flexcan.txt    |   61 --------------------
>  arch/powerpc/boot/dts/p1010rdb.dts                 |    8 ---
>  arch/powerpc/boot/dts/p1010si.dtsi                 |    8 +-
>  3 files changed, 4 insertions(+), 73 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/net/can/fsl-flexcan.txt

I suggest that you set devicetree-discuss@lists.ozlabs.org and Grant
Likely on Cc: for this patch.

rsc
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
