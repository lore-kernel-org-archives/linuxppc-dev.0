Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6B0E2DDD0B
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Jun 2009 07:50:38 +1000 (EST)
Message-Id: <0FD273FE-CCAA-451A-B86C-916849DD4DD8@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Byron Bradley <byron.bbradley@gmail.com>
In-Reply-To: <alpine.DEB.2.00.0906042152330.7053@gamma>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: [PATCH] [POWERPC] 83xx: Add support for the Thecus N1200 NAS
	device
Date: Thu, 4 Jun 2009 16:50:30 -0500
References: <alpine.DEB.2.00.0906042152330.7053@gamma>
Cc: linuxppc-dev@ozlabs.org, tim.ellis@mac.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 4, 2009, at 3:59 PM, Byron Bradley wrote:

> The Thecus N1200 is a NAS device with a single internal SATA disk and
> an eSATA port based on an MPC8347 SoC.
>
> http://thecus.nas-central.org/index.php/Category:N1200
>
> Signed-off-by: Byron Bradley <byron.bbradley@gmail.com>
> Signed-off-by: Tim Ellis <tim.ellis@mac.com>
> ---
> arch/powerpc/boot/Makefile                       |    1 +
> arch/powerpc/boot/dts/thecus_n1200.dts           |  352 +++++
> arch/powerpc/boot/wrapper                        |    2 +-
> arch/powerpc/configs/83xx/thecus_n1200_defconfig | 1674 +++++++++++++ 
> +++++++++
> arch/powerpc/platforms/83xx/Kconfig              |    7 +
> arch/powerpc/platforms/83xx/Makefile             |    1 +
> arch/powerpc/platforms/83xx/thecus_n1200.c       |  160 ++
> 7 files changed, 2196 insertions(+), 1 deletions(-)
> create mode 100644 arch/powerpc/boot/dts/thecus_n1200.dts
> create mode 100644 arch/powerpc/configs/83xx/thecus_n1200_defconfig
> create mode 100644 arch/powerpc/platforms/83xx/thecus_n1200.c
>
> diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
> index 9ae7b7e..7ea6aff 100644
> --- a/arch/powerpc/boot/Makefile
> +++ b/arch/powerpc/boot/Makefile
> @@ -228,6 +228,7 @@ image-$(CONFIG_MPC834x_ITX)		+=  
> cuImage.mpc8349emitx \
> 					   cuImage.mpc8349emitxgp
> image-$(CONFIG_MPC834x_MDS)		+= cuImage.mpc834x_mds
> image-$(CONFIG_MPC836x_MDS)		+= cuImage.mpc836x_mds
> +image-$(CONFIG_THECUS_N1200)		+= cuImage.thecus_n1200
> image-$(CONFIG_ASP834x)			+= dtbImage.asp834x-redboot

Is the u-boot for the board capable of dealing w/device trees or do  
you really need cuImage?

- k
