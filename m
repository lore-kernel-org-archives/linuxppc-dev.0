Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 37A93DDEB7
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jan 2008 05:46:04 +1100 (EST)
Message-ID: <47827360.9090106@freescale.com>
Date: Mon, 07 Jan 2008 12:45:52 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Subject: Re: [alsa-devel] [PATCH] ASoC drivers for the Freescale MPC8610 SoC
References: <11981089894052-git-send-email-timur@freescale.com>
	<9e4733910801010925j67192427o4e0e824b9d7e0ad0@mail.gmail.com>
	<9e4733910801010942y47e4cdbfge5e0d3e44ab96760@mail.gmail.com>
	<477BAB67.4080003@freescale.com>
	<9e4733910801020734n115888cbt86351f67f2311629@mail.gmail.com>
	<477D2150.4020506@freescale.com>
	<20080103235156.GE12883@localhost.localdomain>
	<477EEDFA.9010205@freescale.com>
	<20080106004637.GJ4326@localhost.localdomain>
	<47824AA3.5070808@freescale.com>
	<1199731487.19903.56.camel@localhost.localdomain>
In-Reply-To: <1199731487.19903.56.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org,
	Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Liam Girdwood wrote:
> On Mon, 2008-01-07 at 09:52 -0600, Timur Tabi wrote:
>> So all I'm trying to do now is get my driver, with warts and all, into the tree 
>> so that I can focus with Liam et al to get a real ASoC V2 up and running.
>>
> 
> I'll commit the MPC8610 into the ASoC (v1) dev tree soon (hopefully
> tonight). This will allow folks to use it in the meantime whilst we sort
> out any changes.

I'm working on some minor updates, so hold off for now.  I'll post a new patch 
later this afternoon.

> I'll then port (what I can) to V2, although I may need some assistance
> with some of the PPC sections.

I'll be 100% available for that.

-- 
Timur Tabi
Linux kernel developer at Freescale
