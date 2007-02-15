Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 8F2AADDDEF
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 07:31:43 +1100 (EST)
Date: Thu, 15 Feb 2007 23:31:39 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH] Fix compile failure in cpm_uart_cpm2
Message-ID: <20070215233139.5b9eab08@localhost.localdomain>
In-Reply-To: <20070215174305.GA2820@windriver.com>
References: <20070215174305.GA2820@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, p_gortmaker@yahoo.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 15 Feb 2007 12:43:06 -0500
Paul Gortmaker wrote:

> Fix bug that exists in kernel.org since 2.6.17rc4 - compiles fail if
> CONFIG_SERIAL_CPM_SMC is defined.  Tested on a board using SMC1
> console.
> 

This has been submitted already by Heiko Schocher <hs@denx.de>, sorry... 
Anyway, got to be fixed soon.


> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
> 
> --- linux-2.6.20/drivers/serial/cpm_uart/cpm_uart_cpm2.c~
> 2007-02-07 14:07:47.778573326 -0500 +++
> linux-2.6.20/drivers/serial/cpm_uart/cpm_uart_cpm2.c
> 2007-02-07 14:07:58.248391885 -0500 @@ -285,7 +285,7 @@ int __init
> cpm_uart_init_portdesc(void) {
>  #if defined(CONFIG_SERIAL_CPM_SMC1) ||
> defined(CONFIG_SERIAL_CPM_SMC2)
> -	u32 addr;
> +	u16 *addr;
>  #endif
>  	pr_debug("CPM uart[-]:init portdesc\n");
>  
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
