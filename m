Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3AEABDDF4D
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jan 2007 17:49:46 +1100 (EST)
In-Reply-To: <45BED88D.2050908@freescale.com>
References: <45BED88D.2050908@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <68ADB8CA-7D81-4783-BA9E-D7850D96C257@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: include new of_platform.h for 836x and 832x
Date: Tue, 30 Jan 2007 00:48:46 -0600
To: Li Yang <leoli@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Paul <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 29, 2007, at 11:33 PM, Li Yang wrote:

> Some prototypes are separated from of_device.h into of_platform.h.   
> Add
> the new include to fix warning.
>
> Signed-off-by: Li Yang <leoli@freescale.com>

Li,

Please copy me in the future as 83xx maintainer.

Paul,

I've picked up this patch and its in my for_paulus branch.

- k

> ---
>  arch/powerpc/platforms/83xx/mpc832x_mds.c |    1 +
>  arch/powerpc/platforms/83xx/mpc8360e_pb.c |    1 +
>  2 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/arch/powerpc/platforms/83xx/mpc832x_mds.c b/arch/ 
> powerpc/platforms/83xx/mpc832x_mds.c
> index 4d47119..2c7a1e9 100644
> --- a/arch/powerpc/platforms/83xx/mpc832x_mds.c
> +++ b/arch/powerpc/platforms/83xx/mpc832x_mds.c
> @@ -25,6 +25,7 @@
>  #include <linux/initrd.h>
>
>  #include <asm/of_device.h>
> +#include <asm/of_platform.h>
>  #include <asm/system.h>
>  #include <asm/atomic.h>
>  #include <asm/time.h>
> diff --git a/arch/powerpc/platforms/83xx/mpc8360e_pb.c b/arch/ 
> powerpc/platforms/83xx/mpc8360e_pb.c
> index 53b92a9..a1e23f0 100644
> --- a/arch/powerpc/platforms/83xx/mpc8360e_pb.c
> +++ b/arch/powerpc/platforms/83xx/mpc8360e_pb.c
> @@ -31,6 +31,7 @@
>  #include <linux/initrd.h>
>
>  #include <asm/of_device.h>
> +#include <asm/of_platform.h>
>  #include <asm/system.h>
>  #include <asm/atomic.h>
>  #include <asm/time.h>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
