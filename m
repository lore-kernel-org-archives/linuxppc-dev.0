Return-Path: <B42378@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 097AE2C00D8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Aug 2013 12:18:39 +1000 (EST)
Date: Wed, 21 Aug 2013 10:18:02 +0800
From: Nicolin Chen <b42378@freescale.com>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH v8 2/2] ASoC: fsl: Add S/PDIF machine driver
Message-ID: <20130821021801.GA6177@MrMyself>
References: <cover.1376912873.git.b42378@freescale.com>
 <ca3061d70ab8bf59afc59031fa7befcfaed26d51.1376912873.git.b42378@freescale.com>
 <5212908E.6050104@wwwdotorg.org>
 <20130820001858.GF30073@sirena.org.uk>
 <52138FDE.3080007@wwwdotorg.org>
 <20130820190701.GR30073@sirena.org.uk>
 <5213C94D.7050304@wwwdotorg.org>
 <20130820222810.GU30073@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20130820222810.GU30073@sirena.org.uk>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, lars@metafoo.de,
 Stephen Warren <swarren@wwwdotorg.org>, linuxppc-dev@lists.ozlabs.org,
 s.hauer@pengutronix.de, timur@tabi.org, rob.herring@calxeda.com,
 tomasz.figa@gmail.com, p.zabel@pengutronix.de, R65777@freescale.com,
 shawn.guo@linaro.org, festevam@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 20, 2013 at 11:28:10PM +0100, Mark Brown wrote:
> On Tue, Aug 20, 2013 at 01:53:49PM -0600, Stephen Warren wrote:
> > On 08/20/2013 01:07 PM, Mark Brown wrote:
> 
> > > The point is that it might turn into a more correct binding
> > > depending on what the S/PDIF device actually is.
> 
> > There's *never* an object on the board called a "dummy codec".
> 
> Oh, is that what you're talking about?  Yes, that makes sense.  I had
> been responding to the comments about the transceivers.

I'll remove the 'dummy' words in the next version from the binding doc.

Thank you
Nicolin
