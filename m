Return-Path: <B47053@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id F0FD62C00B8
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Nov 2013 14:53:33 +1100 (EST)
From: Li Xiubo <B47053@freescale.com>
To: Timur Tabi <timur@tabi.org>, Guangyu Chen <B42378@freescale.com>
Subject: RE: [PATCHv2 1/8] ALSA: Add SAI SoC Digital Audio Interface driver.
Date: Wed, 6 Nov 2013 03:53:24 +0000
Message-ID: <1DD289F6464F0949A2FCA5AA6DC23F82876B08@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1383289495-24523-1-git-send-email-Li.Xiubo@freescale.com>
 <1383289495-24523-2-git-send-email-Li.Xiubo@freescale.com>
 <20131101085904.GC28401@MrMyself>
 <1DD289F6464F0949A2FCA5AA6DC23F82874201@039-SN2MPN1-013.039d.mgd.msft.net>
 <5278F1FA.1060706@tabi.org>
 <1DD289F6464F0949A2FCA5AA6DC23F82876A53@039-SN2MPN1-013.039d.mgd.msft.net>
 <5279B822.9010401@tabi.org>
In-Reply-To: <5279B822.9010401@tabi.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "tiwai@suse.de" <tiwai@suse.de>, Huan Wang <B18965@freescale.com>,
 "perex@perex.cz" <perex@perex.cz>, Shawn Guo <r65073@freescale.com>,
 "LW@KARO-electronics.de" <LW@KARO-electronics.de>,
 "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "grant.likely@linaro.org" <grant.likely@linaro.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "ian.campbell@citrix.com" <ian.campbell@citrix.com>,
 "pawel.moll@arm.com" <pawel.moll@arm.com>,
 "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>,
 "rob.herring@calxeda.com" <rob.herring@calxeda.com>,
 "broonie@kernel.org" <broonie@kernel.org>, "oskar@scara.com" <oskar@scara.com>,
 Fabio Estevam <r49496@freescale.com>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "rob@landley.net" <rob@landley.net>, Zhengxiong Jin <R64188@freescale.com>,
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

> >> If there are any comments that say PPC but are not PPC-specific, that
> >> >should be fixed.
> > Yes, find it.
> >
> > The comments is in "sound/soc/fsl/Makefile" :
> > +++++++++++
> > "# Freescale PowerPC SSI/DMA Platform Support"
> > -----------
> >
> > But fsl-spdif.o is also under it.
> > And this is also support ARM and PowerPC platforms at the same time ?
> > If so, the comments should be modified to :
> > +++++++++++
> > "# Freescale PowerPC and ARM SSI/DMA Platform Support"
> > -----------
>=20
> Yes, this should be changed.
>=20

How about :
+++++++++
"# Freescale PowerPC and ARM SSI/DMA/SAI/SPDIF Platform Support"=09
---------
 ?
