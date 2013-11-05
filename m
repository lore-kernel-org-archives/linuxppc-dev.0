Return-Path: <B47053@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe004.messaging.microsoft.com [213.199.154.207])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 13F032C0094
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Nov 2013 17:17:43 +1100 (EST)
From: Li Xiubo <B47053@freescale.com>
To: Shawn Guo <shawn.guo@linaro.org>, Guangyu Chen <B42378@freescale.com>
Subject: RE: [PATCHv2 6/8] ASoC: fsl: add SGTL5000 based audio machine driver.
Date: Tue, 5 Nov 2013 06:17:32 +0000
Message-ID: <1DD289F6464F0949A2FCA5AA6DC23F8287564A@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1383289495-24523-1-git-send-email-Li.Xiubo@freescale.com>
 <1383289495-24523-7-git-send-email-Li.Xiubo@freescale.com>
 <20131101102805.GG28401@MrMyself>
 <20131101120700.GE10324@S2101-09.ap.freescale.net>
In-Reply-To: <20131101120700.GE10324@S2101-09.ap.freescale.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "tiwai@suse.de" <tiwai@suse.de>, Huan Wang <B18965@freescale.com>,
 "timur@tabi.org" <timur@tabi.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Shawn Guo <r65073@freescale.com>,
 "LW@KARO-electronics.de" <LW@KARO-electronics.de>,
 "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "grant.likely@linaro.org" <grant.likely@linaro.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "ian.campbell@citrix.com" <ian.campbell@citrix.com>,
 "pawel.moll@arm.com" <pawel.moll@arm.com>,
 "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>,
 "rob.herring@calxeda.com" <rob.herring@calxeda.com>,
 "broonie@kernel.org" <broonie@kernel.org>, "perex@perex.cz" <perex@perex.cz>,
 "oskar@scara.com" <oskar@scara.com>, Fabio Estevam <r49496@freescale.com>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
 "rob@landley.net" <rob@landley.net>, Zhengxiong Jin <R64188@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> > >  sound/soc/fsl/fsl-sgtl5000-vf610.c | 208
> > > +++++++++++++++++++++++++++++++++++++
> >
> > I just doubt if this file naming is appropriate. Even if we might not
> > have rigor rule for the file names, according to existing ones, they
> > are all in a same pattern: [SoC name]-[codec name].c
> >
> > "imx-sgtl5000.c" for example
> >
> > I think it would make user less confused about what this file exactly
> > is if this machine driver also follow the pattern: vf610-sgtl5000.c
> >
> >
> > @Shawn
> >
> > What do you think about the file name?
>=20
> Yeah, it would be better to name the file following the existing the
> pattern.
>=20

Please see the next version.

Best Regards,
Xiubo
