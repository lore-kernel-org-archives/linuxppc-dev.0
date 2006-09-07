Return-Path: <gerald.vanbaren@smiths-aerospace.com>
Received: from agrxsusmail.smiths.aero (host241-chi.smiths-group.com
	[65.216.75.241]) by ozlabs.org (Postfix) with ESMTP id F27AA67BC0
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Sep 2006 23:15:18 +1000 (EST)
Message-ID: <45001455.5000408@smiths-aerospace.com>
Date: Thu, 07 Sep 2006 08:45:09 -0400
From: Jerry Van Baren <gerald.vanbaren@smiths-aerospace.com>
MIME-Version: 1.0
CC: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] PPC: Fix Kconfig whitespace warnings
References: <1157632584.6098.35.camel@zod.rchland.ibm.com>
In-Reply-To: <1157632584.6098.35.camel@zod.rchland.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Josh Boyer wrote:
> Fix the following whitespace warnings when compiling with ARCH=ppc
> 
> arch/ppc/Kconfig:1207:warning: leading whitespace ignored
> arch/ppc/Kconfig:1226:warning: leading whitespace ignored
> arch/ppc/Kconfig:1231:warning: leading whitespace ignored
> 
> Signed-off-by: Josh Boyer <jdub@us.ibm.com>
> 
> ---
>  arch/ppc/Kconfig |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> --- linux-2.6.orig/arch/ppc/Kconfig
> +++ linux-2.6/arch/ppc/Kconfig
> @@ -1204,7 +1204,7 @@ config PCI_DOMAINS
>  	default PCI
>  
>  config MPC83xx_PCI2
> -	bool "  Supprt for 2nd PCI host controller"
> +	bool "Supprt for 2nd PCI host controller"
                   ^ Add an "o"?

[snip]

gvb
