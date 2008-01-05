Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1F324DDE29
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Jan 2008 13:42:09 +1100 (EST)
Message-ID: <477EEEC5.9050603@freescale.com>
Date: Fri, 04 Jan 2008 20:43:17 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>, linuxppc-dev@ozlabs.org,
	alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] [PATCH] ASoC drivers for the Freescale MPC8610 SoC
References: <11981089894052-git-send-email-timur@freescale.com>	<9e4733910801010925j67192427o4e0e824b9d7e0ad0@mail.gmail.com>	<477BA974.8010308@freescale.com>	<20080102172340.GA2007@sirena.org.uk>	<477D280C.4000800@freescale.com>
	<20080103230004.GA18709@sirena.org.uk>
In-Reply-To: <20080103230004.GA18709@sirena.org.uk>
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

> Each individual call to set_sysclk() only takes three parameters but it
> can be called repeatedly and some configurations are going to require
> this. 

In other words, ...

clock1 = <0, bb8000>
clock2 = <1, 653230>
clock23 = <0, ab2372>

> and of course the ordering matters.  

Ok, you got me there.  But then, isn't this just another example where the 
device tree is incapable of describing a complex configuration, and so we need 
a platform driver?


> Indeed.  Providing the device tree stuff doesn't get set in stone I'm
> not sure we need to nail this down perfectly for ASoC v1 when we're
> running into trouble working around it.

I definitely agree with that.  I'll be the first to admit that this driver, 
much like ASoC V1, is a prototype.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
