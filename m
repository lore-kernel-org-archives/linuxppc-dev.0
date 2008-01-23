Return-Path: <jdl@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D2F25DDDF5
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jan 2008 04:31:55 +1100 (EST)
Message-ID: <47977A02.40506@freescale.com>
Date: Wed, 23 Jan 2008 11:31:46 -0600
From: Jon Loeliger <jdl@freescale.com>
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCHv2 0/8] [POWERPC] 8xx cleanups
References: <4797641F.4000902@scram.de>	<CA8FFE19-B84A-426B-9B1C-EF0F7C87AE47@kernel.crashing.org>
	<20080123171252.GA22967@uranus.ravnborg.org>
In-Reply-To: <20080123171252.GA22967@uranus.ravnborg.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Scott Wood <scottwood@freescale.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>, "Kernel,
	Linux" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sam Ravnborg wrote:
>> What impact do the have on boards in arch/ppc being able to build?
> 
> Byt the way what are the plans for powerpc?
> We have:
> arch/ppc
> arch/ppc64
> arch/powerpc
> 
> It was my understanding that arch/powerpc was supposed
> to be the future unified powerpc architecture but it
> does not even provide a defconfig.
> 
> And I do not see too much happening to do so - but that maybe
> because I looked at a wrong place.

You must have looked in the wrong place. :-)

arch/ppc is scheduled for removal from mainline in June.

arch/powerpc is under significant development, with lots
of defconfigs in arch/powerpc/configs.

arch/ppc64 is long dead.

jdl
