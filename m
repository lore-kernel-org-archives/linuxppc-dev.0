Return-Path: <mark.rutland@arm.com>
Received: from cam-admin0.cambridge.arm.com (cam-admin0.cambridge.arm.com
 [217.140.96.50]) by ozlabs.org (Postfix) with ESMTP id EE1812C0167
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Aug 2013 21:31:42 +1000 (EST)
Date: Mon, 19 Aug 2013 12:31:21 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v7 2/2] ASoC: fsl: Add S/PDIF machine driver
Message-ID: <20130819113121.GL3719@e106331-lin.cambridge.arm.com>
References: <cover.1376901081.git.b42378@freescale.com>
 <e7ceef74714bb4ead624b333ee3969225b4c5cb5.1376901081.git.b42378@freescale.com>
 <20130819092458.GE3719@e106331-lin.cambridge.arm.com>
 <20130819095042.GA11402@MrMyself>
 <20130819100143.GH3719@e106331-lin.cambridge.arm.com>
 <20130819105201.GB30073@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130819105201.GB30073@sirena.org.uk>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "lars@metafoo.de" <lars@metafoo.de>,
 "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 Nicolin Chen <b42378@freescale.com>, "timur@tabi.org" <timur@tabi.org>,
 "rob.herring@calxeda.com" <rob.herring@calxeda.com>,
 "tomasz.figa@gmail.com" <tomasz.figa@gmail.com>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "R65777@freescale.com" <R65777@freescale.com>,
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

On Mon, Aug 19, 2013 at 11:52:01AM +0100, Mark Brown wrote:
> On Mon, Aug 19, 2013 at 11:01:43AM +0100, Mark Rutland wrote:
> > On Mon, Aug 19, 2013 at 10:50:43AM +0100, Nicolin Chen wrote:
> 
> > > The phrase "user-visible" is being used in many current docs, I don't 
> > > dare to change it unless a sage gives me a suggestion.
> 
> > I can see that there is entrenched usage, but this really seems to be
> > embedding Linux-specific implementation details into the dt. I don't see
> > why the driver cannot select a sensible name, but perhaps I'm missing
> > something.
> 
> > Mark, is there any reason we need to handle the user-visible name of the
> > device this way?
> 
> This is intended to allow userspace to distinguish between systems that
> are electrically identical but physically distinct, for example when
> multiple systems are derived from the same reference design.

I see. Surely if there's some meaning imparted to userspace by the model
name, there's a contract there that we should document (the set of valid
model names and what they correspond to)?

I'm not sure I understand why userspace needs to know what the system is
if we've adequately described how it's wired and what its capabilities
are. However, I'm not at all familiar with the way we handle audio, so
please forgive my naivety there :)

Thanks,
Mark.
