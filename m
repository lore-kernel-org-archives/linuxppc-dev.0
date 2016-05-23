Return-Path: <ruscur@russell.cc>
Received: from russell.cc (russell.cc [IPv6:2404:9400:2:0:216:3eff:fee0:3370])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rCgvx6GsHzDqWn
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 May 2016 11:30:21 +1000 (AEST)
Message-ID: <1463967017.2414.2.camel@russell.cc>
Subject: Re: [PATCH 0213/1529] Fix typo
From: Russell Currey <ruscur@russell.cc>
To: Andrea Gelmini <andrea.gelmini@gelma.net>
Cc: trivial@kernel.org, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Date: Mon, 23 May 2016 11:30:17 +1000
In-Reply-To: <20160521120353.11023-1-andrea.gelmini@gelma.net>
References: <20160521120353.11023-1-andrea.gelmini@gelma.net>
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

On Sat, 2016-05-21 at 14:03 +0200, Andrea Gelmini wrote:
> Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
> ---

This entire comment needs to be rewritten as it's incredibly confusing, but alas

Acked-by: Russell Currey <ruscur@russell.cc>

>  arch/powerpc/include/asm/eeh.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
> index fb9f376..7d34f3d 100644
> --- a/arch/powerpc/include/asm/eeh.h
> +++ b/arch/powerpc/include/asm/eeh.h
> @@ -57,7 +57,7 @@ struct pci_dn;
>  /*
>   * The struct is used to trace PE related EEH functionality.
>   * In theory, there will have one instance of the struct to
> - * be created against particular PE. In nature, PEs corelate
> + * be created against particular PE. In nature, PEs correlate
>   * to each other. the struct has to reflect that hierarchy in
>   * order to easily pick up those affected PEs when one particular
>   * PE has EEH errors.
