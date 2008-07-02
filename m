Return-Path: <lg@opensource.wolfsonmicro.com>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2DEEEDE6A0
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jul 2008 02:08:18 +1000 (EST)
Subject: Re: [alsa-devel] [PATCH 3/3] ALSA SoC: Add Texas Instruments
	TLV320AIC26 codec driver
From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
To: Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <9e4733910807020652j59c9c742h965b4782667837f9@mail.gmail.com>
References: <20080701235330.16923.67218.stgit@trillian.secretlab.ca>
	<20080701235340.16923.48024.stgit@trillian.secretlab.ca>
	<9e4733910807020652j59c9c742h965b4782667837f9@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 02 Jul 2008 17:08:14 +0100
Message-Id: <1215014894.4882.100.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org,
	broonie@opensource.wolfsonmicro.com, timur@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-07-02 at 09:52 -0400, Jon Smirl wrote:
> 
> I've been using asoc-v2 so it may not be possible to make this arch
> independent in asoc-v1.  Maybe try porting this to asoc-v2 and see if
> a bunch of the registration complexity disappears. Most of soc-of.c
> should be unnecessary.
> 
> Liam, when is asoc-v2 going into mainline?

Hopefully over the next 2 merge windows. I'm about to start queueing
patches....

This also assumes Mark and I remain at our current work load levels.

Liam
