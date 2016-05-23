Return-Path: <ruscur@russell.cc>
Received: from russell.cc (russell.cc [IPv6:2404:9400:2:0:216:3eff:fee0:3370])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rCgt51GRwzDqXq
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 May 2016 11:28:45 +1000 (AEST)
Message-ID: <1463966919.2414.1.camel@russell.cc>
Subject: Re: [PATCH 0223/1529] Fix typo
From: Russell Currey <ruscur@russell.cc>
To: Andrea Gelmini <andrea.gelmini@gelma.net>
Cc: trivial@kernel.org, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Date: Mon, 23 May 2016 11:28:39 +1000
In-Reply-To: <20160521120526.11583-1-andrea.gelmini@gelma.net>
References: <20160521120526.11583-1-andrea.gelmini@gelma.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2016-05-21 at 14:05 +0200, Andrea Gelmini wrote:
> Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
> ---

Acked-by: Russell Currey <ruscur@russell.cc>

>  arch/powerpc/kernel/eeh_driver.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/eeh_driver.c
> b/arch/powerpc/kernel/eeh_driver.c
> index 2714a3b..389b0d3 100644
> --- a/arch/powerpc/kernel/eeh_driver.c
> +++ b/arch/powerpc/kernel/eeh_driver.c
> @@ -139,7 +139,7 @@ static void eeh_enable_irq(struct pci_dev *dev)
>  		 * into it.
>  		 *
>  		 * That's just wrong.The warning in the core code is
> -		 * there to tell people to fix their assymetries in
> +		 * there to tell people to fix their asymmetries in
>  		 * their own code, not by abusing the core information
>  		 * to avoid it.
>  		 *
