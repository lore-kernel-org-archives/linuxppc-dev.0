Return-Path: <SRS0=SNis=RL=denx.de=sr@srs.kundenserver.de>
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 4/5] Convert PowerPC MPC i2c to of_platform_driver from
	platform_driver
Date: Thu, 20 Dec 2007 07:04:16 +0100
References: <20071220044136.20091.70984.stgit@terra.home>
	<20071220044144.20091.35917.stgit@terra.home>
	<20071220051618.GB29058@localhost.localdomain>
In-Reply-To: <20071220051618.GB29058@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200712200704.17309.sr@denx.de>
Cc: linux-kernel@vger.kernel.org, i2c@lm-sensors.org,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 20 December 2007, David Gibson wrote:
> On Wed, Dec 19, 2007 at 11:41:44PM -0500, Jon Smirl wrote:
> > Convert MPC i2c driver from being a platform_driver to an open
> > firmware version. Error returns were improved. Routine names were
> > changed from fsl_ to mpc_ to make them match the file name.
>
> In discussions BenH and I have had, we've actually concluded that
> moving this from platform drivers to of_platform drives is not
> actually a good idea.
>
> In fact we're planning to move away from of_platform devices and
> drivers and instead develop a framework for instantiating platform
> devices or i2c devices or whatever devices from the device tree nodes.

Now that is interesting news. I like this idea.

But what should be done to support the still missing devices in the 4xx 
arch/powerpc tree, like I2C, NAND etc.? Should we wait with those driver till 
this framework is available?

Thanks.

Cheers,
Stefan
