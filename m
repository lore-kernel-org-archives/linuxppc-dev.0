Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 39B6EDDE9C
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Oct 2007 02:36:40 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l9JGaaf9009629
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 12:36:36 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9JGaakP070160
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 10:36:36 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9JGaZ5p012677
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 10:36:36 -0600
Date: Fri, 19 Oct 2007 11:36:34 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Yuri Tikhonov <yur@emcraft.com>
Subject: Re: [PATCH] ppc44x: support for 256K PAGE_SIZE
Message-ID: <20071019113634.397c63f7@weaponx.rchland.ibm.com>
In-Reply-To: <200710181108.19413.yur@emcraft.com>
References: <200710181108.19413.yur@emcraft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 18 Oct 2007 11:08:19 +0400
Yuri Tikhonov <yur@emcraft.com> wrote:

> 
>  Hello,
> 
>  The following patch adds support for 256KB PAGE_SIZE on ppc44x-based boards. 
> The applications to be run on the kernel with 256KB PAGE_SIZE have to be 
> built using the modified version of binutils, where the MAXPAGESIZE 
> definition is set to 0x40000 (as opposite to standard 0x10000).
> 
>  Signed-off-by: Pavel Kolesnikov <concord@emcraft.com>
>  Acked-by: Yuri Tikhonov <yur@emcraft.com>
> 
> --
> 
> diff --git a/arch/ppc/Kconfig b/arch/ppc/Kconfig
> index c590b18..0ee372d 100644
> --- a/arch/ppc/Kconfig
> +++ b/arch/ppc/Kconfig
> @@ -1223,6 +1223,9 @@ config PPC_PAGE_16K
> 
>  config PPC_PAGE_64K
>  	bool "64 KB" if 44x
> +
> +config PPC_PAGE_256K
> +	bool "256 KB" if 44x
>  endchoice

BTW, what tree did you base this on?  I don't seem to have the
PPC_PAGE_* options in my tree.

josh
