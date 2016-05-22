Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rCLp64jFkzDq9m
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 May 2016 22:39:10 +1000 (AEST)
Date: Sun, 22 May 2016 12:37:32 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Andrea Gelmini <andrea.gelmini@gelma.net>
Cc: trivial@kernel.org, benh@kernel.crashing.org, mpe@ellerman.id.au,
 christophe.leroy@c-s.fr, oss@buserror.net, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 0228/1529] Fix typo
Message-ID: <20160522023732.GA23547@fergus.ozlabs.ibm.com>
References: <20160521120618.11846-1-andrea.gelmini@gelma.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160521120618.11846-1-andrea.gelmini@gelma.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, May 21, 2016 at 02:06:18PM +0200, Andrea Gelmini wrote:
> Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
> ---
>  arch/powerpc/lib/checksum_64.S | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/lib/checksum_64.S b/arch/powerpc/lib/checksum_64.S
> index 8e6e510..f3b5b7d 100644
> --- a/arch/powerpc/lib/checksum_64.S
> +++ b/arch/powerpc/lib/checksum_64.S
> @@ -74,7 +74,7 @@ _GLOBAL(__csum_partial)
>  	ld	r11,24(r3)
>  
>  	/*
> -	 * On POWER6 and POWER7 back to back addes take 2 cycles because of
> +	 * On POWER6 and POWER7 back to back adds take 2 cycles because of
>  	 * the XER dependency. This means the fastest this loop can go is
>  	 * 16 cycles per iteration. The scheduling of the loop below has
>  	 * been shown to hit this on both POWER6 and POWER7.
> @@ -275,7 +275,7 @@ source;	ld	r10,16(r3)
>  source;	ld	r11,24(r3)
>  
>  	/*
> -	 * On POWER6 and POWER7 back to back addes take 2 cycles because of
> +	 * On POWER6 and POWER7 back to back adds take 2 cycles because of
>  	 * the XER dependency. This means the fastest this loop can go is
>  	 * 16 cycles per iteration. The scheduling of the loop below has
>  	 * been shown to hit this on both POWER6 and POWER7.

NAK - this is talking about the 'adde' instruction, not the 'add'
instruction.

Paul.
