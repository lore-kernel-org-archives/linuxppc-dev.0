Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qk9Jz1th2zDq5g
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Apr 2016 23:05:07 +1000 (AEST)
In-Reply-To: <563CBD1B.1060407@gmail.com>
To: =?utf-8?b?5oWV5Yas5Lqu?= <mudongliangabcd@gmail.com>,
 benh@kernel.crashing.org, paulus@samba.org, mudongliangabcd@gmail.com,
 will.deacon@arm.com, takahiro.akashi@linaro.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-api@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: uapi elf: delete unused macros
Message-Id: <3qk9Jy6NyYz9sC4@ozlabs.org>
Date: Mon, 11 Apr 2016 23:05:06 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-06-11 at 14:45:47 UTC, =?utf-8?b?5oWV5Yas5Lqu?= wrote:
> >From 13f516acc709d88d3162e92bc891c8e39cc9fc1a Mon Sep 17 00:00:00 2001
> From: mudongliang <mudongliangabcd@gmail.com>
> Date: Fri, 6 Nov 2015 14:35:19 +0800
> Subject: [PATCH] unify the comment form and delete unused macros
> 
> diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
> index 71e1d0e..ff81b20 100644
> --- a/include/uapi/linux/elf.h
> +++ b/include/uapi/linux/elf.h
> @@ -342,15 +342,13 @@ typedef struct elf64_shdr {
>  #define	ELFCLASSNONE	0		/* EI_CLASS */
>  #define	ELFCLASS32	1
>  #define	ELFCLASS64	2
> -#define	ELFCLASSNUM	3
>  
> -#define ELFDATANONE	0		/* e_ident[EI_DATA] */
> +#define ELFDATANONE	0		/* EI_DATA */
>  #define ELFDATA2LSB	1
>  #define ELFDATA2MSB	2
>  
> -#define EV_NONE		0		/* e_version, EI_VERSION */
> +#define EV_NONE		0		/* EI_VERSION */
>  #define EV_CURRENT	1
> -#define EV_NUM		2

How do you know there isn't a userspace program somewhere that's using this
definition?

cheers
