Return-Path: <mikey@ozlabs.org>
To: Jan-Bernd Themann <ossthema@de.ibm.com>
From: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH 7/7] ehea: Makefile & Kconfig 
In-reply-to: <44E0A580.9020507@de.ibm.com> 
References: <44E0A580.9020507@de.ibm.com>
Date: Wed, 16 Aug 2006 14:27:16 -0500
Sender: mikey@ozlabs.org
Message-Id: <20060816192721.09C2967A3A@ozlabs.org>
Cc: Thomas Klein <tklein@de.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>,
	netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Thomas Klein <osstklei@de.ibm.com>, linux-ppc <linuxppc-dev@ozlabs.org>,
	Christoph Raisch <raisch@de.ibm.com>, Marcus Eder <meder@de.ibm.com>
Reply-To: Michael Neuling <mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch is still being white space munged so it doesn't apply.  

The context is being shifted over 1 column.  All your other patches add
new files so there is no context and hence they apply.

Mikey

In message <44E0A580.9020507@de.ibm.com> you wrote:
> Signed-off-by: Jan-Bernd Themann <themann@de.ibm.com>
> 
> 
>   drivers/net/Kconfig  |    6 ++++++
>   drivers/net/Makefile |    1 +
>   2 files changed, 7 insertions(+)
> 
> 
> 
> diff -Nurp -X dontdiff linux-2.6.18-rc4/drivers/net/Kconfig patched_kernel/dr
ivers/net/Kconfig
> --- linux-2.6.18-rc4/drivers/net/Kconfig	2006-08-06 11:20:11.000000000 -
0700
> +++ patched_kernel/drivers/net/Kconfig	2006-08-08 03:00:49.526421944 -
0700
> @@ -2277,6 +2277,12 @@ config CHELSIO_T1
>             To compile this driver as a module, choose M here: the module
>             will be called cxgb.
> 
> +config EHEA
> +        tristate "eHEA Ethernet support"
> +        depends on IBMEBUS
> +        ---help---
> +          This driver supports the IBM pSeries ethernet adapter
> +
>   config IXGB
>   	tristate "Intel(R) PRO/10GbE support"
>   	depends on PCI
> diff -Nurp -X dontdiff linux-2.6.18-rc4/drivers/net/Makefile patched_kernel/d
rivers/net/Makefile
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
> 
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 
