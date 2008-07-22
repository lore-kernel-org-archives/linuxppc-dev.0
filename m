Return-Path: <jonsmirl@gmail.com>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.30])
	by ozlabs.org (Postfix) with ESMTP id 8BF46DE01D
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 00:52:27 +1000 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so412301yxg.39
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 07:52:25 -0700 (PDT)
Message-ID: <9e4733910807220752o4d220f90o770d55e70f493642@mail.gmail.com>
Date: Tue, 22 Jul 2008 10:52:20 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Grant Likely" <grant.likely@secretlab.ca>, linuxppc-dev@ozlabs.org,
	alsa-devel@alsa-project.org, liam.girdwood@wolfsonmicro.com,
	timur@freescale.com, "Mark Brown" <broonie@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] [PATCH v3 0/3] ALSA SoC: MPC5200 audio driver
In-Reply-To: <20080722141027.GB12555@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <fa686aa40807212358p17c824ia1d6516a87a7aac1@mail.gmail.com>
	<20080722092646.GA7251@sirena.org.uk>
	<9e4733910807220638u5cf48424l92ba780ecd9e3d9d@mail.gmail.com>
	<20080722141027.GB12555@sirena.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 7/22/08, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> On Tue, Jul 22, 2008 at 09:38:11AM -0400, Jon Smirl wrote:
>
>  > These drivers are going to get hit with immediate patches.  The DMA is
>  > not broken out so that AC97 support can be fixed for the Efika.
>
> Further updates shouldn't present a problem - if anything, it should be
>  easier easier to review incremental patches.

I'm just going to ignore 2.6.27 and wait for 2.6.28.  This driver only
partially implement i2s support and assumes external clocking. There's
no way to add a ASOC machine driver. It's not a general purpose
driver. Adding the rest of the features probably means device tree
changes.

-- 
Jon Smirl
jonsmirl@gmail.com
