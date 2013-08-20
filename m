Return-Path: <swarren@wwwdotorg.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org
 [IPv6:2001:470:1f0f:bd7::2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 3C7642C00FC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Aug 2013 05:53:58 +1000 (EST)
Message-ID: <5213C94D.7050304@wwwdotorg.org>
Date: Tue, 20 Aug 2013 13:53:49 -0600
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v8 2/2] ASoC: fsl: Add S/PDIF machine driver
References: <cover.1376912873.git.b42378@freescale.com>
 <ca3061d70ab8bf59afc59031fa7befcfaed26d51.1376912873.git.b42378@freescale.com>
 <5212908E.6050104@wwwdotorg.org> <20130820001858.GF30073@sirena.org.uk>
 <52138FDE.3080007@wwwdotorg.org> <20130820190701.GR30073@sirena.org.uk>
In-Reply-To: <20130820190701.GR30073@sirena.org.uk>
Content-Type: text/plain; charset=ISO-8859-1
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, lars@metafoo.de, festevam@gmail.com,
 s.hauer@pengutronix.de, Nicolin Chen <b42378@freescale.com>, timur@tabi.org,
 rob.herring@calxeda.com, tomasz.figa@gmail.com, p.zabel@pengutronix.de,
 R65777@freescale.com, shawn.guo@linaro.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/20/2013 01:07 PM, Mark Brown wrote:
> On Tue, Aug 20, 2013 at 09:48:46AM -0600, Stephen Warren wrote:
>> On 08/19/2013 06:18 PM, Mark Brown wrote:
> 
>>> S/PDIF is also sometimes used as an interconnect between
>>> devices - some CODECs have S/PDIF I/O (more normally used as an
>>> external connector on the box).  This is most frequently seen
>>> as a way to
> 
>> That's not a good argument for an incorrect binding.
> 
> The point is that it might turn into a more correct binding
> depending on what the S/PDIF device actually is.

There's *never* an object on the board called a "dummy codec".
