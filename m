Return-Path: <timur@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D66A0DDF04
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 01:14:49 +1000 (EST)
Message-ID: <4885F95C.7060600@freescale.com>
Date: Tue, 22 Jul 2008 10:14:36 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [alsa-devel] [PATCH v3 0/3] ALSA SoC: MPC5200 audio driver
References: <fa686aa40807212358p17c824ia1d6516a87a7aac1@mail.gmail.com>	
	<20080722092646.GA7251@sirena.org.uk>	
	<9e4733910807220638u5cf48424l92ba780ecd9e3d9d@mail.gmail.com>	
	<20080722141027.GB12555@sirena.org.uk>
	<9e4733910807220752o4d220f90o770d55e70f493642@mail.gmail.com>
In-Reply-To: <9e4733910807220752o4d220f90o770d55e70f493642@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	liam.girdwood@wolfsonmicro.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jon Smirl wrote:

> I'm just going to ignore 2.6.27 and wait for 2.6.28.

2.6.28 might have ASoC V2, or at least portions of it.  You might want to just
port your driver to ASoC V2 like I did and not worry about it.

-- 
Timur Tabi
Linux kernel developer at Freescale
