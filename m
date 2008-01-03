Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5829BDDE9D
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Jan 2008 05:22:03 +1100 (EST)
Message-ID: <477D280C.4000800@freescale.com>
Date: Thu, 03 Jan 2008 12:23:08 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>, Jon Smirl <jonsmirl@gmail.com>,
	linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] [PATCH] ASoC drivers for the Freescale MPC8610 SoC
References: <11981089894052-git-send-email-timur@freescale.com>	<9e4733910801010925j67192427o4e0e824b9d7e0ad0@mail.gmail.com>	<477BA974.8010308@freescale.com>
	<20080102172340.GA2007@sirena.org.uk>
In-Reply-To: <20080102172340.GA2007@sirena.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Mark Brown wrote:

>> clock1 = <0, bb8000>
> 
>> Would that be better?
> 
> To cover everything you'd need to be able to specify all the clocking
> parameters, especially a PLL configuration, and also specify more than
> one of each item.  Even then you'd still have problems like...

The ASoC V1 API for communicating clock data from the fabric driver to the 
codec driver only allows for three parameters.

> According to the documentation in your patch the bus frequency should
> already be optional 

My code does not currently support that configuration, and I don't have any 
hardware that works that way, so I don't know what it would look like.  I'm 
just trying to make the driver as flexible as possible, given ASoC V1 constraints.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
