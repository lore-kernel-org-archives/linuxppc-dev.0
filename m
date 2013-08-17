Return-Path: <sha@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 1CE362C01E6
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Aug 2013 01:00:13 +1000 (EST)
Date: Sat, 17 Aug 2013 17:00:02 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH v5 1/2] ASoC: fsl: Add S/PDIF CPU DAI driver
Message-ID: <20130817150002.GU26614@pengutronix.de>
References: <cover.1376565456.git.b42378@freescale.com>
 <20130816080124.GE1846@MrMyself>
 <20130816085632.GO26614@pengutronix.de>
 <137675716.iLf1T1CVZo@flatron>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <137675716.iLf1T1CVZo@flatron>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, lars@metafoo.de, ian.campbell@citrix.com,
 pawel.moll@arm.com, swarren@wwwdotorg.org, festevam@gmail.com,
 Nicolin Chen <b42378@freescale.com>, timur@tabi.org, rob.herring@calxeda.com,
 broonie@kernel.org, p.zabel@pengutronix.de, galak@codeaurora.org,
 shawn.guo@linaro.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Aug 17, 2013 at 02:26:40PM +0200, Tomasz Figa wrote:
> > You mean tx<0-7>.
> > 
> > Also I would make this option required. Use a dummy clock for mux inputs
> > that are grounded for a specific SoC.
> 
> Why do you need a dummy clock?
> 
> The driver can simply try to grab all the possible clocks and discard 
> those that failed, so you can just keep those grounded clocks unspecified.

We don't need dummy clocks. My motivation saying this that I was afraid
people try to configure the driver by skipping the clocks they don't
want from the devicetree.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
