Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 90B63DDE22
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Dec 2007 09:33:05 +1100 (EST)
Message-ID: <476AED87.3090703@freescale.com>
Date: Thu, 20 Dec 2007 16:32:39 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH] ASoC drivers for the Freescale MPC8610 SoC
References: <11981089894052-git-send-email-timur@freescale.com>
	<9e4733910712201429q5845e786yb2ecb3ce9c8b7871@mail.gmail.com>
In-Reply-To: <9e4733910712201429q5845e786yb2ecb3ce9c8b7871@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jon Smirl wrote:

> How is of_platform_bus_probe() supposed to be called? mpc5200/virtex
> call it with three NULLs. Is it necessary to name all of the buses in
> a of_device_id? If it's not necessary to list the buses the
> of_platform_bus_probe() call could be moved to common code.

I added the above code because it is the only way I could get my SSI nodes to be 
probed.  If there's a better way to do it, I'm all ears.  I just copied that 
code from the mpc836x_mds.c platform file.

> Are these buses?
>         { .compatible = "ibm,plb4", },
>         { .compatible = "ibm,opb", },
>         { .compatible = "ibm,ebc", },

I have no idea.

> Could of_platform_bus_probe() be simplified? No one uses the first and
> third parameters.

Maybe, but that's not a discussion for this thread!

-- 
Timur Tabi
Linux kernel developer at Freescale
