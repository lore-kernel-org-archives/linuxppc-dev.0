Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id AAECEDDE06
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Dec 2007 16:54:58 +1100 (EST)
Date: Thu, 20 Dec 2007 00:01:19 -0600
From: Olof Johansson <olof@lixom.net>
To: Jon Smirl <jonsmirl@gmail.com>, i2c@lm-sensors.org,
	linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] Convert PowerPC MPC i2c to of_platform_driver from
	platform_driver
Message-ID: <20071220060119.GA8456@lixom.net>
References: <20071220044136.20091.70984.stgit@terra.home>
	<20071220044144.20091.35917.stgit@terra.home>
	<20071220051618.GB29058@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071220051618.GB29058@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Dec 20, 2007 at 04:16:18PM +1100, David Gibson wrote:
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

There's been talk about that for a long time. Whenever that framework
is done, all the other drivers that have been converted (or written)
must/can be converted back as well.

Meanwhile, this should go in so those of us who can make use of the
other improvements the series brings can make use of them.


Thanks,

Olof
