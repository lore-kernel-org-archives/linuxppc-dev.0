Return-Path: <shawn.guo@linaro.org>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0251.outbound.messaging.microsoft.com [213.199.154.251])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 971D92C00C8
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Nov 2013 19:12:48 +1100 (EST)
Date: Wed, 6 Nov 2013 16:12:59 +0800
From: Shawn Guo <shawn.guo@linaro.org>
To: Li Xiubo <B47053@freescale.com>
Subject: Re: [PATCHv2 1/8] ALSA: Add SAI SoC Digital Audio Interface driver.
Message-ID: <20131106081257.GR19770@S2101-09.ap.freescale.net>
References: <1383289495-24523-1-git-send-email-Li.Xiubo@freescale.com>
 <1383289495-24523-2-git-send-email-Li.Xiubo@freescale.com>
 <20131101085904.GC28401@MrMyself>
 <1DD289F6464F0949A2FCA5AA6DC23F82874201@039-SN2MPN1-013.039d.mgd.msft.net>
 <5278F1FA.1060706@tabi.org>
 <1DD289F6464F0949A2FCA5AA6DC23F82876A53@039-SN2MPN1-013.039d.mgd.msft.net>
 <5279B822.9010401@tabi.org>
 <1DD289F6464F0949A2FCA5AA6DC23F82876B08@039-SN2MPN1-013.039d.mgd.msft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1DD289F6464F0949A2FCA5AA6DC23F82876B08@039-SN2MPN1-013.039d.mgd.msft.net>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "tiwai@suse.de" <tiwai@suse.de>, Huan Wang <B18965@freescale.com>,
 Timur Tabi <timur@tabi.org>, "perex@perex.cz" <perex@perex.cz>,
 Shawn Guo <r65073@freescale.com>,
 "LW@KARO-electronics.de" <LW@KARO-electronics.de>,
 "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>,
 Guangyu Chen <B42378@freescale.com>,
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
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 06, 2013 at 03:53:24AM +0000, Li Xiubo wrote:
> > >> If there are any comments that say PPC but are not PPC-specific, that
> > >> >should be fixed.
> > > Yes, find it.
> > >
> > > The comments is in "sound/soc/fsl/Makefile" :
> > > +++++++++++
> > > "# Freescale PowerPC SSI/DMA Platform Support"
> > > -----------
> > >
> > > But fsl-spdif.o is also under it.
> > > And this is also support ARM and PowerPC platforms at the same time ?
> > > If so, the comments should be modified to :
> > > +++++++++++
> > > "# Freescale PowerPC and ARM SSI/DMA Platform Support"
> > > -----------
> > 
> > Yes, this should be changed.
> > 
> 
> How about :
> +++++++++
> "# Freescale PowerPC and ARM SSI/DMA/SAI/SPDIF Platform Support"	
> ---------
>  ?

Or we can just drop 'PowerPC and ARM'?

Shawn
