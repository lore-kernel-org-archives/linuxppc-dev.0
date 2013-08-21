Return-Path: <swarren@wwwdotorg.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org
 [IPv6:2001:470:1f0f:bd7::2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 28C772C00D1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2013 02:08:21 +1000 (EST)
Message-ID: <5214E5E8.1000102@wwwdotorg.org>
Date: Wed, 21 Aug 2013 10:08:08 -0600
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
To: Nicolin Chen <b42378@freescale.com>
Subject: Re: [alsa-devel] [PATCH v8 2/2] ASoC: fsl: Add S/PDIF machine driver
References: <cover.1376912873.git.b42378@freescale.com>
 <ca3061d70ab8bf59afc59031fa7befcfaed26d51.1376912873.git.b42378@freescale.com>
 <5212908E.6050104@wwwdotorg.org> <20130820001858.GF30073@sirena.org.uk>
 <52138FDE.3080007@wwwdotorg.org> <20130820190701.GR30073@sirena.org.uk>
 <5213C94D.7050304@wwwdotorg.org> <20130820222810.GU30073@sirena.org.uk>
 <20130821021801.GA6177@MrMyself>
In-Reply-To: <20130821021801.GA6177@MrMyself>
Content-Type: text/plain; charset=ISO-8859-1
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, lars@metafoo.de, linuxppc-dev@lists.ozlabs.org,
 s.hauer@pengutronix.de, timur@tabi.org, rob.herring@calxeda.com,
 tomasz.figa@gmail.com, Mark Brown <broonie@kernel.org>, p.zabel@pengutronix.de,
 R65777@freescale.com, shawn.guo@linaro.org, festevam@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/20/2013 08:18 PM, Nicolin Chen wrote:
> On Tue, Aug 20, 2013 at 11:28:10PM +0100, Mark Brown wrote:
>> On Tue, Aug 20, 2013 at 01:53:49PM -0600, Stephen Warren wrote:
>>> On 08/20/2013 01:07 PM, Mark Brown wrote:
>>
>>>> The point is that it might turn into a more correct binding
>>>> depending on what the S/PDIF device actually is.
>>
>>> There's *never* an object on the board called a "dummy codec".
>>
>> Oh, is that what you're talking about?  Yes, that makes sense.  I had
>> been responding to the comments about the transceivers.
> 
> I'll remove the 'dummy' words in the next version from the binding doc.

I think the word "CODEC" is also problematic in this context, since
whatever is connector to the S/PDIF output path may not be a CODEC.
That's why I suggested some more generic property names that IIRC
concentrated on enabling rx/tx rather than indicating what was actually
connected to the S/PDIF controller.
