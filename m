Return-Path: <sam@ravnborg.org>
Received: from pfepb.post.tele.dk (pfepb.post.tele.dk [195.41.46.236])
	by ozlabs.org (Postfix) with ESMTP id 20968B70E2
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 18 Aug 2010 15:40:00 +1000 (EST)
Date: Wed, 18 Aug 2010 07:39:55 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: David Miller <davem@davemloft.net>
Subject: Re: 64-bit ppc rwsem
Message-ID: <20100818053955.GA11962@merkur.ravnborg.org>
References: <20100817.191424.183031381.davem@davemloft.net>
	<1282106338.22370.151.camel@pasglop>
	<1282107803.22370.173.camel@pasglop>
	<20100817.222818.193699062.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100817.222818.193699062.davem@davemloft.net>
Cc: linuxppc-dev@lists.ozlabs.org, paulus@au.ibm.com,
	linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
	akpm@linux-foundation.org, torvalds@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> diff --git a/arch/sparc/lib/Makefile b/arch/sparc/lib/Makefile
> index c4b5e03..fa4c3ea 100644
> --- a/arch/sparc/lib/Makefile
> +++ b/arch/sparc/lib/Makefile
> @@ -15,7 +15,7 @@ lib-$(CONFIG_SPARC32) += divdi3.o udivdi3.o
>  lib-$(CONFIG_SPARC32) += copy_user.o locks.o
>  lib-y                 += atomic_$(BITS).o
>  lib-$(CONFIG_SPARC32) += lshrdi3.o ashldi3.o
> -lib-y                 += rwsem_$(BITS).o
> +lib-$(CONFIG_SPARC32) += rwsem_$(BITS).o

You could write this explicit as:

> +lib-$(CONFIG_SPARC32) += rwsem_32.o

As rwsem_64 is gone now.

	Sam
