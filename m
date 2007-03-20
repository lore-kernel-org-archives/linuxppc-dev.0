Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7CE50DDF2E
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Mar 2007 12:20:40 +1100 (EST)
In-Reply-To: <1174346834.6595.365.camel@ld0161-tx32>
References: <1174346834.6595.365.camel@ld0161-tx32>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <7073CDF4-22AE-4460-A5DA-0D49194D95A3@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 2/2] Add initial MPC8544DS platform files.
Date: Mon, 19 Mar 2007 20:19:56 -0500
To: Jon Loeliger <jdl@freescale.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 19, 2007, at 6:27 PM, Jon Loeliger wrote:

>
> This patch provides the basic 8544 platform code and config.
> Follow-up patches will add peripherals such as PCI and SATA.
>
> Signed-off-by: Xianghua Xiao <x.xiao@freescale.com>
> Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
> Signed-off-by: York Sun <yorksun@freescale.com>
> Signed-off-by: Andy Fleming <afleming@freescale.com>
> Signed-off-by: Jon Loeliger <jdl@freescale.com>
> ---
>  arch/powerpc/boot/dts/mpc8544ds.dts      |  137 +++++++++++++++++++ 
> +++++++++
>  arch/powerpc/platforms/85xx/Kconfig      |    9 ++-
>  arch/powerpc/platforms/85xx/Makefile     |    1 +
>  arch/powerpc/platforms/85xx/mpc8544_ds.c |  147 +++++++++++++++++++ 
> +++++++++++
>  4 files changed, 293 insertions(+), 1 deletions(-)
>  create mode 100644 arch/powerpc/boot/dts/mpc8544ds.dts
>  create mode 100644 arch/powerpc/platforms/85xx/mpc8544_ds.c

All the internal interrupts are offset by 16.  Please fix that up.   
Otherwise looks ok.

- k
