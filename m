Return-Path: <mikey@ozlabs.org>
To: Jan-Bernd Themann <ossthema@de.ibm.com>
From: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH 6/6] ehea: Kernel build (Kconfig / Makefile) 
In-reply-to: <44D99F92.60407@de.ibm.com> 
References: <44D99F92.60407@de.ibm.com>
Date: Thu, 10 Aug 2006 15:30:24 +1000
Sender: mikey@ozlabs.org
Message-Id: <20060810053024.C691F67A5E@ozlabs.org>
Cc: Thomas Klein <tklein@de.ibm.com>, linux-ppc <linuxppc-dev@ozlabs.org>,
	Christoph Raisch <raisch@de.ibm.com>
Reply-To: Michael Neuling <mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> --- linux-2.6.18-rc4/drivers/net/Makefile	2006-08-06 11:20:11.000000000 -
0700
> +++ patched_kernel/drivers/net/Makefile	2006-08-08 03:00:30.061451584 -
0700
> @@ -10,6 +10,7 @@ obj-$(CONFIG_E1000) += e1000/
>   obj-$(CONFIG_IBM_EMAC) += ibm_emac/
>   obj-$(CONFIG_IXGB) += ixgb/
>   obj-$(CONFIG_CHELSIO_T1) += chelsio/
> +obj-$(CONFIG_EHEA) += ehea/
>   obj-$(CONFIG_BONDING) += bonding/
>   obj-$(CONFIG_GIANFAR) += gianfar_driver.o

Looks like the whitespace has been munged here... 

Mikey
