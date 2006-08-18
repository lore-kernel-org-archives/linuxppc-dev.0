Return-Path: <adobriyan@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.186])
	by ozlabs.org (Postfix) with ESMTP id 59B1C67A5E
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Aug 2006 00:18:56 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id c2so1431740nfe
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 07:18:54 -0700 (PDT)
Date: Fri, 18 Aug 2006 18:18:47 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Jan-Bernd Themann <ossthema@de.ibm.com>
Subject: Re: [2.6.19 PATCH 7/7] ehea: Makefile & Kconfig
Message-ID: <20060818141847.GE5201@martell.zuzino.mipt.ru>
References: <200608181337.44153.ossthema@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200608181337.44153.ossthema@de.ibm.com>
Cc: Thomas Klein <tklein@de.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>,
	netdev@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>,
	Thomas Klein <osstklei@de.ibm.com>, linux-ppc <linuxppc-dev@ozlabs.org>,
	Christoph Raisch <raisch@de.ibm.com>, Marcus Eder <meder@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Aug 18, 2006 at 01:37:44PM +0200, Jan-Bernd Themann wrote:
> --- linux-2.6.18-rc4/drivers/net/Kconfig
> +++ patched_kernel/drivers/net/Kconfig
> @@ -2277,6 +2277,12 @@ config CHELSIO_T1
>            To compile this driver as a module, choose M here: the module
>            will be called cxgb.
>
> +config EHEA
> +        tristate "eHEA Ethernet support"
> +        depends on IBMEBUS
> +        ---help---
> +          This driver supports the IBM pSeries ethernet adapter
								  .

People usually add the following boilerplate:

	To compile this driver as a module, choose M here: the module
	will be called $FOO.
