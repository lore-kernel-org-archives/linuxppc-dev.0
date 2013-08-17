Return-Path: <tomasz.figa@gmail.com>
Received: from mail-bk0-x22d.google.com (mail-bk0-x22d.google.com
 [IPv6:2a00:1450:4008:c01::22d])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8D6972C01F6
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Aug 2013 01:13:34 +1000 (EST)
Received: by mail-bk0-f45.google.com with SMTP id mx11so984969bkb.32
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Aug 2013 08:13:25 -0700 (PDT)
From: Tomasz Figa <tomasz.figa@gmail.com>
To: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v5 1/2] ASoC: fsl: Add S/PDIF CPU DAI driver
Date: Sat, 17 Aug 2013 17:13:20 +0200
Message-ID: <2782793.dUculLxO6S@flatron>
In-Reply-To: <20130817150002.GU26614@pengutronix.de>
References: <cover.1376565456.git.b42378@freescale.com>
 <137675716.iLf1T1CVZo@flatron> <20130817150002.GU26614@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
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

On Saturday 17 of August 2013 17:00:02 Sascha Hauer wrote:
> On Sat, Aug 17, 2013 at 02:26:40PM +0200, Tomasz Figa wrote:
> > > You mean tx<0-7>.
> > > 
> > > Also I would make this option required. Use a dummy clock for mux
> > > inputs that are grounded for a specific SoC.
> > 
> > Why do you need a dummy clock?
> > 
> > The driver can simply try to grab all the possible clocks and discard
> > those that failed, so you can just keep those grounded clocks
> > unspecified.
> We don't need dummy clocks. My motivation saying this that I was afraid
> people try to configure the driver by skipping the clocks they don't
> want from the devicetree.

I'm not really sure if the same abuse couldn't be easily achieved by 
putting dummy clocks in place of those skipped clocks.

Adding a note in binding documentation that says that all clocks that are 
fed to the IP shall be specified should be fine IMHO.

Best regards,
Tomasz
