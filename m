Return-Path: <ukl@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4746B1A3178
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2015 17:40:34 +1000 (AEST)
Date: Wed, 15 Jul 2015 09:40:19 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linux-spi@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 kernel@pengutronix.de, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] spi: mpc512x-psc: add support for Freescale MPC5125
Message-ID: <20150715074018.GD1426@pengutronix.de>
References: <1436865596-9592-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20150714095442.GO11162@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20150714095442.GO11162@sirena.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 14, 2015 at 10:54:42AM +0100, Mark Brown wrote:
> On Tue, Jul 14, 2015 at 11:19:56AM +0200, Uwe Kleine-König wrote:
> 
> >  static const struct of_device_id mpc512x_psc_spi_of_match[] = {
> > -	{ .compatible = "fsl,mpc5121-psc-spi", },
> > +	{ .compatible = "fsl,mpc5121-psc-spi", .data = (void *)TYPE_MPC5121 },
> > +	{ .compatible = "fsl,mpc5125-psc-spi", .data = (void *)TYPE_MPC5125 },
> >  	{},
> 
> The code seems fine but this should update the binding document to
> include the new compatible string.
I don't find fsl,mpc5121-psc-spi documented either. The best I found is
ocumentation/devicetree/bindings/powerpc/fsl/mpc5121-psc.txt which
describes fsl,mpc5121-psc-uart and fsl,mpc5121-psc.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
