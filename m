Return-Path: <kou.ishizaki@toshiba.co.jp>
Date: Mon, 21 May 2007 16:28:15 +0900 (JST)
Message-Id: <20070521.162815.-1300536619.kouish@swc.toshiba.co.jp>
To: hch@lst.de
Subject: Re: [PATCH] fix celleb link failure
In-Reply-To: <20070516103752.GA22383@lst.de>
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Index: linux-2.6.20/arch/powerpc/platforms/celleb/Makefile
> ===================================================================
> ---
linux-2.6.20.orig/arch/powerpc/platforms/celleb/Makefile	2007-05-
16 11:36:28.000000000 +0200
> +++
linux-2.6.20/arch/powerpc/platforms/celleb/Makefile	2007-05-16
11:36:41.000000000 +0200
> @@ -4,5 +4,5 @@ obj-y				+= interrupt.o iommu.o
setup.o 
>  
>  obj-$(CONFIG_SMP)		+= smp.o
>  obj-$(CONFIG_PPC_UDBG_BEAT)	+= udbg_beat.o
> -obj-$(CONFIG_HAS_TXX9_SERIAL)	+= scc_sio.o
> +obj-$(CONFIG_SERIAL_TXX9)	+= scc_sio.o
>  obj-$(CONFIG_SPU_BASE)		+= spu_priv1.o

Acked-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>

Thanks.

Best regards,
Kou Ishizaki
