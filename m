Return-Path: <B47053@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe004.messaging.microsoft.com [207.46.163.27])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D1CE32C033F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Oct 2013 20:31:20 +1100 (EST)
From: Xiubo Li-B47053 <B47053@freescale.com>
To: Chen Guangyu-B42378 <B42378@freescale.com>
Subject: RE: [PATCHv1 1/8] ALSA: Add SAI SoC Digital Audio Interface driver.
Date: Tue, 29 Oct 2013 09:31:11 +0000
Message-ID: <1DD289F6464F0949A2FCA5AA6DC23F8286D2E8@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1382000477-17304-1-git-send-email-Li.Xiubo@freescale.com>
 <1382000477-17304-2-git-send-email-Li.Xiubo@freescale.com>
 <20131024110543.GA18506@sirena.org.uk>
 <1DD289F6464F0949A2FCA5AA6DC23F8286BDB5@039-SN2MPN1-013.039d.mgd.msft.net>
 <20131029040209.GC8812@MrMyself>
In-Reply-To: <20131029040209.GC8812@MrMyself>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "tiwai@suse.de" <tiwai@suse.de>, Wang Huan-B18965 <B18965@freescale.com>,
 "timur@tabi.org" <timur@tabi.org>, "perex@perex.cz" <perex@perex.cz>,
 Guo Shawn-R65073 <r65073@freescale.com>,
 "LW@KARO-electronics.de" <LW@KARO-electronics.de>,
 "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "grant.likely@linaro.org" <grant.likely@linaro.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "ian.campbell@citrix.com" <ian.campbell@citrix.com>,
 "pawel.moll@arm.com" <pawel.moll@arm.com>,
 "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>,
 "rob.herring@calxeda.com" <rob.herring@calxeda.com>,
 Mark Brown <broonie@kernel.org>, "oskar@scara.com" <oskar@scara.com>,
 Estevam Fabio-R49496 <r49496@freescale.com>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "rob@landley.net" <rob@landley.net>,
 Jin Zhengxiong-R64188 <R64188@freescale.com>,
 "shawn.guo@linaro.org" <shawn.guo@linaro.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>





> -----Original Message-----
> From: Chen Guangyu-B42378
> Sent: Tuesday, October 29, 2013 12:02 PM
> To: Xiubo Li-B47053
> Cc: Mark Brown; Guo Shawn-R65073; timur@tabi.org; lgirdwood@gmail.com;
> Jin Zhengxiong-R64188; rob.herring@calxeda.com; pawel.moll@arm.com;
> mark.rutland@arm.com; swarren@wwwdotorg.org; ian.campbell@citrix.com;
> rob@landley.net; linux@arm.linux.org.uk; perex@perex.cz; tiwai@suse.de;
> grant.likely@linaro.org; Estevam Fabio-R49496; LW@KARO-electronics.de;
> oskar@scara.com; shawn.guo@linaro.org; Wang Huan-B18965;
> devicetree@vger.kernel.org; linux-doc@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; alsa-
> devel@alsa-project.org; linuxppc-dev@lists.ozlabs.org
> Subject: Re: [PATCHv1 1/8] ALSA: Add SAI SoC Digital Audio Interface
> driver.
>=20
> On Tue, Oct 29, 2013 at 12:00:57PM +0800, Xiubo Li-B47053 wrote:
> > > There's a patch in -next that lets the generic dmaengine code figure
> > > out some settings from the dmacontroller rather than requiring the
> > > driver to explicitly provide configuration - it's "ASoC:
> > > dmaengine-pcm: Provide default config".  Please update your driver
> > > to use this, or let's work out what it doesn't do any try to fix it.
> > >
> >
> > I couldn't find the patch in the next and other trees.
> > Does this patch has been submitted to the -next tree ?
> > Or could you tell me how to find the patch please?
> >
>=20
> Are you using broonie's repository?

NO.

> git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git
>=20
> If you searched the title in for-next branch, you should have found it.
>=20
Yes, find it.
Thanks very much.

--
Xiubo
