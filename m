Return-Path: <tomasz.figa@gmail.com>
Received: from mail-bk0-x22d.google.com (mail-bk0-x22d.google.com
 [IPv6:2a00:1450:4008:c01::22d])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 99F312C0233
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Aug 2013 01:17:26 +1000 (EST)
Received: by mail-bk0-f45.google.com with SMTP id mx11so946252bkb.18
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Aug 2013 08:17:22 -0700 (PDT)
From: Tomasz Figa <tomasz.figa@gmail.com>
To: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v5 1/2] ASoC: fsl: Add S/PDIF CPU DAI driver
Date: Sat, 17 Aug 2013 17:17:18 +0200
Message-ID: <8770601.066pCcRnTh@flatron>
In-Reply-To: <20130817145316.GT26614@pengutronix.de>
References: <cover.1376565456.git.b42378@freescale.com>
 <2805432.jMVhHxhr1m@flatron> <20130817145316.GT26614@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, lars@metafoo.de, mturquette@linaro.org,
 ian.campbell@citrix.com, pawel.moll@arm.com, swarren@wwwdotorg.org,
 festevam@gmail.com, Nicolin Chen <b42378@freescale.com>, timur@tabi.org,
 rob.herring@calxeda.com, broonie@kernel.org, p.zabel@pengutronix.de,
 galak@codeaurora.org, shawn.guo@linaro.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Saturday 17 of August 2013 16:53:16 Sascha Hauer wrote:
> On Sat, Aug 17, 2013 at 02:28:04PM +0200, Tomasz Figa wrote:
> > > > > Also I would make this option required. Use a dummy clock for
> > > > > mux
> > > > > inputs that are grounded for a specific SoC.
> > > > 
> > > > Some clocks are not from CCM and we haven't defined in
> > > > imx6q-clk.txt,
> > > > so in most cases we can't provide a phandle for them, eg:
> > > > spdif_ext.
> > > > I think it's a bit hard to force it to be 'required'. An
> > > > 'optional'
> > > > looks more flexible to me and a default one is ensured even if
> > > > it's
> > > > missing.
> > > 
> > > <&clks 0> is the dummy clock. This can be used for all input clocks
> > > not
> > > defined by the SoC.
> > 
> > Where does this assumption come from? Is it documented anywhere?
> 
> This is how all i.MX clock bindings currently are. See
> Documentation/devicetree/bindings/clock/imx*-clock.txt

OK, thanks.

I guess we need some discussion on dummy clocks vs skipped clocks. I think 
we want some consistency on this, don't we?

If we really need a dummy clock, then we might also want a generic way to 
specify it.

Best regards,
Tomasz
