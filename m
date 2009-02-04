Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5A37FDDED9
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Feb 2009 14:42:47 +1100 (EST)
Subject: Re: [PATCH] powerpc: Ignore vmlinux.strip
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sean MacLennan <smaclennan@pikatech.com>
In-Reply-To: <20090128145057.7ff2d12a@lappy.seanm.ca>
References: <20090128145057.7ff2d12a@lappy.seanm.ca>
Content-Type: text/plain
Date: Wed, 04 Feb 2009 14:42:40 +1100
Message-Id: <1233718960.16867.157.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2009-01-28 at 14:50 -0500, Sean MacLennan wrote:
> Not sure if this is PPC specific or not. I use the following patch to
> get a clean git status. Does nobody else see this file? Or am I missing
> a step somewhere?

Looks good actually.

> Cheers,
>    Sean
> 
> Ignore the vmlinux.strip file.
> 
> Signed-off-by: Sean MacLennan <smaclennan@pikatech.com>
> diff --git a/.gitignore b/.gitignore
> index 869e1a3..f7e924a 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -32,6 +32,7 @@
>  tags
>  TAGS
>  vmlinux
> +vmlinux.strip
>  System.map
>  Module.markers
>  Module.symvers
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
