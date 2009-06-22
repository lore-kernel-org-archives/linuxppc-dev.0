Return-Path: <dgibson@bilbo.ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 9CB85B71C1
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 22 Jun 2009 11:55:51 +1000 (EST)
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8CCBDDDD0C
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Jun 2009 11:55:51 +1000 (EST)
Date: Mon, 22 Jun 2009 11:52:11 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH] Have git ignore generated files from dtc compile
Message-ID: <20090622015211.GA4003@yookeroo.seuss>
References: <20090622012800.31652.35886.stgit@terra>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090622012800.31652.35886.stgit@terra>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Jun 21, 2009 at 09:28:00PM -0400, Jon Smirl wrote:
> Have git ignore generated files from dtc compile
> 
> Signed-off-by: Jon Smirl <jonsmirl@gmail.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> diff --git a/arch/powerpc/boot/.gitignore b/arch/powerpc/boot/.gitignore
> index d57aa5c..dab1b41 100644
> --- a/arch/powerpc/boot/.gitignore
> +++ b/arch/powerpc/boot/.gitignore
> @@ -37,3 +37,13 @@ zImage.pseries
>  zconf.h
>  zlib.h
>  zutil.h
> +fdt.c
> +fdt.h
> +fdt_ro.c
> +fdt_rw.c
> +fdt_strerror.c
> +fdt_sw.c
> +fdt_wip.c
> +libfdt.h
> +libfdt_internal.h
> +
> diff --git a/scripts/dtc/.gitignore b/scripts/dtc/.gitignore

Except that I don't think this can go in via the powerpc tree, given
it touches scripts/

> new file mode 100644
> index 0000000..095acb4
> --- /dev/null
> +++ b/scripts/dtc/.gitignore
> @@ -0,0 +1,5 @@
> +dtc
> +dtc-lexer.lex.c
> +dtc-parser.tab.c
> +dtc-parser.tab.h
> +
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
