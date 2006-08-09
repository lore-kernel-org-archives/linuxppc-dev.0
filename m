Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 3374E679FC
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Aug 2006 02:34:14 +1000 (EST)
Date: Wed, 9 Aug 2006 11:33:13 -0500
To: Jan-Bernd Themann <ossthema@de.ibm.com>
Subject: Re: [PATCH 6/6] ehea: Kernel build (Kconfig / Makefile)
Message-ID: <20060809163313.GC29823@pb15.lixom.net>
References: <44D99F92.60407@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <44D99F92.60407@de.ibm.com>
From: Olof Johansson <olof@lixom.net>
Cc: Thomas Klein <tklein@de.ibm.com>, netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-ppc <linuxppc-dev@ozlabs.org>, Christoph Raisch <raisch@de.ibm.com>,
	Marcus Eder <meder@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 09, 2006 at 10:40:50AM +0200, Jan-Bernd Themann wrote:
> Signed-off-by: Jan-Bernd Themann <themann@de.ibm.com>
> 
> 
>   drivers/net/Kconfig  |    6 ++++++
>   drivers/net/Makefile |    1 +
>   2 files changed, 7 insertions(+)
> 
> 
> 
> diff -Nurp -X dontdiff linux-2.6.18-rc4/drivers/net/Kconfig patched_kernel/drivers/net/Kconfig
> --- linux-2.6.18-rc4/drivers/net/Kconfig	2006-08-06 11:20:11.000000000 -0700
> +++ patched_kernel/drivers/net/Kconfig	2006-08-08 03:00:49.526421944 -0700
> @@ -2277,6 +2277,12 @@ config CHELSIO_T1
>             To compile this driver as a module, choose M here: the module
>             will be called cxgb.
> 
> +config EHEA
> +        tristate "eHEA Ethernet support"
> +        depends on IBMEBUS
> +        ---help---
> +          This driver supports the IBM pSeries ethernet adapter

Does this adapter really not have a better name for the option
description? That's a very vague description given that IBM pSeries
machines have had all sorts of ethernet adapters through the years.



-Olof
