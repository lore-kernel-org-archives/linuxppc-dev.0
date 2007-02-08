Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6BAD5DDED1
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Feb 2007 09:28:00 +1100 (EST)
Subject: Re: [PATCH] Added QE to the list of default scanned OF devices
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andy Fleming <afleming@freescale.com>
In-Reply-To: <Pine.LNX.4.61.0702081056250.15256@ld0175-tx32.am.freescale.net>
References: <Pine.LNX.4.61.0702081056250.15256@ld0175-tx32.am.freescale.net>
Content-Type: text/plain
Date: Fri, 09 Feb 2007 09:27:47 +1100
Message-Id: <1170973667.2620.376.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-02-08 at 10:56 -0600, Andy Fleming wrote:
> Signed-off-by: Andrew Fleming <afleming@freescale.com>
> ---
>  arch/powerpc/kernel/of_platform.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)

As I said several times on irc, I dislike the "default list" and I'm
tempted to remove it. I'd much prefer if your platform passed in the
list of what it wants exposed.

Ben.

> diff --git a/arch/powerpc/kernel/of_platform.c b/arch/powerpc/kernel/of_platform.c
> index b734517..43c5a00 100644
> --- a/arch/powerpc/kernel/of_platform.c
> +++ b/arch/powerpc/kernel/of_platform.c
> @@ -51,6 +51,7 @@ static struct of_device_id of_default_bu
>  	{ .type = "plb4", },
>  	{ .type = "opb", },
>  	{ .type = "ebc", },
> +	{ .type = "qe", },
>  	{},
>  };
>  
