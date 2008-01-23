Return-Path: <sam@ravnborg.org>
Received: from pasmtpA.tele.dk (pasmtpa.tele.dk [80.160.77.114])
	by ozlabs.org (Postfix) with ESMTP id 514B5DDF5C
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jan 2008 04:13:00 +1100 (EST)
Date: Wed, 23 Jan 2008 18:12:52 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCHv2 0/8] [POWERPC] 8xx cleanups
Message-ID: <20080123171252.GA22967@uranus.ravnborg.org>
References: <4797641F.4000902@scram.de>
	<CA8FFE19-B84A-426B-9B1C-EF0F7C87AE47@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CA8FFE19-B84A-426B-9B1C-EF0F7C87AE47@kernel.crashing.org>
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

> 
> What impact do the have on boards in arch/ppc being able to build?

Byt the way what are the plans for powerpc?
We have:
arch/ppc
arch/ppc64
arch/powerpc

It was my understanding that arch/powerpc was supposed
to be the future unified powerpc architecture but it
does not even provide a defconfig.

And I do not see too much happening to do so - but that maybe
because I looked at a wrong place.

	Sam
