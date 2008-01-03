Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 32C33DDF31
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Jan 2008 05:19:23 +1100 (EST)
Message-ID: <477D276B.2060300@freescale.com>
Date: Thu, 03 Jan 2008 12:20:27 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] ASoC drivers for the Freescale MPC8610 SoC
References: <11981089894052-git-send-email-timur@freescale.com>	
	<9e4733910801010925j67192427o4e0e824b9d7e0ad0@mail.gmail.com>	
	<9e4733910801010942y47e4cdbfge5e0d3e44ab96760@mail.gmail.com>	
	<477BAB67.4080003@freescale.com>	
	<9e4733910801020734n115888cbt86351f67f2311629@mail.gmail.com>	
	<477D2150.4020506@freescale.com>
	<fa686aa40801031013w54b15286u8e6e2561219422f2@mail.gmail.com>
In-Reply-To: <fa686aa40801031013w54b15286u8e6e2561219422f2@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Liam Girdwood <liam.girdwood@wolfsonmicro.com>, alsa-devel@alsa-project.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:

> The device tree is a description of the hardware; not software.  It's
> not a good idea to break with convention due to current driver
> architecture.

I believe that with ASoC V1, I'm stuck between a rock and a hard place, and so 
the only way to make this code work is to bend some rules.  Right now, the 
CS4270 driver does not support platform drivers or the device tree, so there's 
no point in putting a child I2C node for it.  As I mentioned in other posts, I 
will be more than happy to update the CS4270 driver to support this new 
paradigm (which was invented after the CS4270 driver was written) *after* this 
current patchset is applied.


-- 
Timur Tabi
Linux Kernel Developer @ Freescale
