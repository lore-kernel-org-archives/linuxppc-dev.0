Return-Path: <ruscur@russell.cc>
Received: from russell.cc (russell.cc [IPv6:2404:9400:2:0:216:3eff:fee0:3370])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rCgsT5n34zDqNc
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 May 2016 11:28:13 +1000 (AEST)
Message-ID: <1463966888.2414.0.camel@russell.cc>
Subject: Re: [PATCH 0244/1529] Fix typo
From: Russell Currey <ruscur@russell.cc>
To: Andrea Gelmini <andrea.gelmini@gelma.net>
Cc: trivial@kernel.org, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Date: Mon, 23 May 2016 11:28:08 +1000
In-Reply-To: <20160521120817.12731-1-andrea.gelmini@gelma.net>
References: <20160521120817.12731-1-andrea.gelmini@gelma.net>
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

On Sat, 2016-05-21 at 14:08 +0200, Andrea Gelmini wrote:
> Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
> ---

Acked-by: Russell Currey <ruscur@russell.cc>

>  arch/powerpc/platforms/pseries/eeh_pseries.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c
> b/arch/powerpc/platforms/pseries/eeh_pseries.c
> index ac3ffd9..ef3147c 100644
> --- a/arch/powerpc/platforms/pseries/eeh_pseries.c
> +++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
> @@ -2,7 +2,7 @@
>   * The file intends to implement the platform dependent EEH operations on
> pseries.
>   * Actually, the pseries platform is built based on RTAS heavily. That means
> the
>   * pseries platform dependent EEH operations will be built on RTAS calls. The
> functions
> - * are devired from arch/powerpc/platforms/pseries/eeh.c and necessary
> cleanup has
> + * are derived from arch/powerpc/platforms/pseries/eeh.c and necessary
> cleanup has
>   * been done.
>   *
>   * Copyright Benjamin Herrenschmidt & Gavin Shan, IBM Corporation 2011.
