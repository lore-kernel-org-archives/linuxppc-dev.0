Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AD411DE98D
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 15:37:44 +1000 (EST)
Message-Id: <F4ADE2C2-EF96-41EB-94AD-A5301A4C456B@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Adrian Bunk <bunk@kernel.org>
In-Reply-To: <20080731161020.GD20212@cs181140183.pp.htv.fi>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [2.6 patch] Add cuImage.mpc866ads to the bootwrapper as a
	cuboot-8xx target
Date: Thu, 21 Aug 2008 00:37:32 -0500
References: <20080731161020.GD20212@cs181140183.pp.htv.fi>
Cc: Scott Wood <scottwood@freescale.com>, paulus@samba.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 31, 2008, at 11:10 AM, Adrian Bunk wrote:

> From: Scott Wood <scottwood@freescale.com>
>
> This patch fixes the following build error with mpc866_ads_defconfig:
>
> <--  snip  -->
>
> ...
>  WRAP    arch/powerpc/boot/cuImage.mpc866ads
> powerpc64-linux-ld: arch/powerpc/boot/cuboot-mpc866ads.o: No such  
> file: No such file or directory
> make[2]: *** [arch/powerpc/boot/cuImage.mpc866ads] Error 1
>
> <--  snip  -->
>
> Reported-by: Adrian Bunk <bunk@kernel.org>
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> Signed-off-by: Adrian Bunk <bunk@kernel.org>
>
> ---

applied.

- k
