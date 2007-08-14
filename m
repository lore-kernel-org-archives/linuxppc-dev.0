Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 37993DDE42
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Aug 2007 05:22:56 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l7EIHtWO002089
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Aug 2007 14:17:55 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l7EJMqbK510562
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Aug 2007 15:22:52 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l7EJMpu4019746
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Aug 2007 15:22:51 -0400
Received: from zod.rchland.ibm.com (wecm-9-67-139-20.wecm.ibm.com
	[9.67.139.20])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	l7EJMpPd019709
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Aug 2007 15:22:51 -0400
Date: Tue, 14 Aug 2007 14:21:48 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 1/4] PowerPC 440EPx: Sequoia defconfig
Message-ID: <20070814142148.40bd7a57@zod.rchland.ibm.com>
In-Reply-To: <20070814184500.GA10087@ru.mvista.com>
References: <20070814184107.GA6696@ru.mvista.com>
	<20070814184500.GA10087@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 14 Aug 2007 22:45:00 +0400
Valentine Barshak <vbarshak@ru.mvista.com> wrote:

> Sequoia defconfig
> 
> Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
> ---
>  arch/powerpc/configs/sequoia_defconfig |  783 +++++++++++++++++++++++++++++++++
>  1 files changed, 783 insertions(+)
> 
> diff -ruN linux-2.6.orig/arch/powerpc/configs/sequoia_defconfig linux-2.6/arch/powerpc/configs/sequoia_defconfig
> --- linux-2.6.orig/arch/powerpc/configs/sequoia_defconfig	1970-01-01 03:00:00.000000000 +0300
> +++ linux-2.6/arch/powerpc/configs/sequoia_defconfig	2007-08-14 17:18:07.000000000 +0400
> @@ -0,0 +1,783 @@
> +#
> +# Automatically generated make config: don't edit
> +# Linux kernel version: 2.6.23-rc1
> +# Fri Jul 27 20:46:07 2007
> +#
> +# CONFIG_PPC64 is not set
> +
> +#
> +# Processor support
> +#
> +# CONFIG_6xx is not set
> +# CONFIG_PPC_85xx is not set
> +# CONFIG_PPC_8xx is not set
> +# CONFIG_40x is not set
> +CONFIG_44x=y
> +# CONFIG_E200 is not set
> +CONFIG_PPC_FPU=y

...

> +CONFIG_MATH_EMULATION=y

You shouldn't need both FPU and MATH_EMULATION.  Bamboo had the same
bug in it's defconfig until recently, so you can blame me if you'd
like :)

josh
