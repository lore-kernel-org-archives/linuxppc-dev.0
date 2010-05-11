Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 494ECB7D7A
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 11 May 2010 15:35:47 +1000 (EST)
Subject: Re: [PATCHv2 2/3] powerpc: Add power management support to VIO bus
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Brian King <brking@linux.vnet.ibm.com>
In-Reply-To: <201005102053.o4AKrFJL017810@d03av05.boulder.ibm.com>
References: <201005102053.o4AKrFJL017810@d03av05.boulder.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 11 May 2010 15:35:29 +1000
Message-ID: <1273556129.21352.3.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2010-05-10 at 15:53 -0500, Brian King wrote:
> Adds support for suspend/resume for VIO devices. This is needed for
> support for HMC initiated hibernation.

Your previous version of that patch is already in powerpc-next. Please
make a new patch against it.

Cheers,
Ben.

> Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
> ---
> 
>  arch/powerpc/kernel/vio.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff -puN arch/powerpc/kernel/vio.c~powerpc_vio_bus_pm arch/powerpc/kernel/vio.c
> --- linux-2.6/arch/powerpc/kernel/vio.c~powerpc_vio_bus_pm	2010-05-10 11:12:15.000000000 -0500
> +++ linux-2.6-bjking1/arch/powerpc/kernel/vio.c	2010-05-10 11:12:15.000000000 -0500
> @@ -1365,6 +1365,7 @@ static struct bus_type vio_bus_type = {
>  	.match = vio_bus_match,
>  	.probe = vio_bus_probe,
>  	.remove = vio_bus_remove,
> +	.pm = GENERIC_SUBSYS_PM_OPS,
>  };
>  
>  /**
> _
