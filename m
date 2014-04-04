Return-Path: <guangyu.chen@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 12CCD14009C
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Apr 2014 20:47:48 +1100 (EST)
Date: Fri, 4 Apr 2014 17:38:47 +0800
From: Nicolin Chen <Guangyu.Chen@freescale.com>
To: Xiubo Li-B47053 <Li.Xiubo@freescale.com>
Subject: Re: [PATCH 1/2] ASoC: fsl_sai: Add clock control for SAI
Message-ID: <20140404093847.GB2735@MrMyself>
References: <cover.1396352401.git.Guangyu.Chen@freescale.com>
 <87d225a25812d730c0865f9d0bb733c67d8b3ed1.1396352401.git.Guangyu.Chen@freescale.com>
 <49295d4f0f0f42c4b9c6de77583b978e@BY2PR03MB505.namprd03.prod.outlook.com>
 <20140404092804.GA2735@MrMyself>
 <f713ce2310f44ef883194429ba97d4a8@BY2PR03MB505.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <f713ce2310f44ef883194429ba97d4a8@BY2PR03MB505.namprd03.prod.outlook.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "pawel.moll@arm.com" <pawel.moll@arm.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>,
 "timur@tabi.org" <timur@tabi.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "broonie@kernel.org" <broonie@kernel.org>, "rob@landley.net" <rob@landley.net>,
 "galak@codeaurora.org" <galak@codeaurora.org>,
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

On Fri, Apr 04, 2014 at 05:43:12PM +0800, Xiubo Li-B47053 wrote:
> > Subject: Re: [PATCH 1/2] ASoC: fsl_sai: Add clock control for SAI
> > 
> > Hi Xiubo,
> > 
> > On Fri, Apr 04, 2014 at 05:24:39PM +0800, Xiubo Li-B47053 wrote:
> > > Hi,
> > >
> > > I have test this series on my Vybrid-TWR board and it works happily.
> > 
> > You just checked the wrong version. I've sent a mail to let people disregard
> > this version and a newer v2.
> > 
> 
> Sorry, I didn't receive these, I will search it in the web page.
> 
> > >
> > > [...]
> > > > diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> > > > index 3847d2a..2d749df 100644
> > > > --- a/sound/soc/fsl/fsl_sai.c
> > > > +++ b/sound/soc/fsl/fsl_sai.c
> > > > @@ -428,5 +428,18 @@ static int fsl_sai_startup(struct snd_pcm_substream
> > > > *substream,
> > > >  {
> > > >  	struct fsl_sai *sai = snd_soc_dai_get_drvdata(cpu_dai);
> > > > -	u32 reg;
> > > > +	struct device *dev = &sai->pdev->dev;
> > > > +	u32 reg, ret;
> > > > +
> > >
> > > I'd prefer:
> > >   +	int ret;
> > 
> > Just like last time I said, it would be converted to 'int' any way. There's
> > no much difference between them.
> > 
> 
> Yes, it is...
> 
> I have ever encounter something like this in the feature maybe someone will
> do the following check:
> 
> If (ret < 0)
> 	...
> 
> Just one potential problem and one suggestion.

Fine...I'll revise it as you wish..after you checked the v2.

Thanks,
Nicolin
