Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BF68FDDEA2
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jan 2008 02:52:27 +1100 (EST)
Message-ID: <47824AA3.5070808@freescale.com>
Date: Mon, 07 Jan 2008 09:52:03 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>, Jon Smirl <jonsmirl@gmail.com>,
	Liam Girdwood <liam.girdwood@wolfsonmicro.com>,
	alsa-devel@alsa-project.org, linuxppc-dev@ozlabs.org
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
In-Reply-To: <20080106004637.GJ4326@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:

> Ok, but couldn't you strucutre your I2S or fabric driver so that it
> only becomes fully operational once the codec driver has registered
> with it?

Not in ASoC V1.  You have to understand, ASoC V1 was designed without any 
consideration for runtime-bindings and other OF goodies.  All connections 
between the drivers are static, literally.  In fact, I wouldn't be surprised if 
some ASoC drivers cannot be compiled as modules.

So all I'm trying to do now is get my driver, with warts and all, into the tree 
so that I can focus with Liam et al to get a real ASoC V2 up and running.

-- 
Timur Tabi
Linux kernel developer at Freescale
