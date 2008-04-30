Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 83B75DE134
	for <linuxppc-dev@ozlabs.org>; Thu,  1 May 2008 04:35:07 +1000 (EST)
Date: Wed, 30 Apr 2008 11:35:00 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: [PATCH] docbook: fix fatal rapidio yet again (and more to come)
Message-Id: <20080430113500.dfe21880.akpm@linux-foundation.org>
In-Reply-To: <Pine.LNX.4.64.0804292009000.18219@shark.he.net>
References: <Pine.LNX.4.64.0804292009000.18219@shark.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Benjamin, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, torvalds@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 29 Apr 2008 20:10:55 -0700 (PDT)
"Randy.Dunlap" <rdunlap@xenotime.net> wrote:

> From: Randy Dunlap <randy.dunlap@oracle.com>
> 
> Don't refer to file that no longer exists:
> docproc: linux-2.6.25-git14/arch/powerpc/kernel/rio.c: No such file or directory
> 
> Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
> ---
>  Documentation/DocBook/rapidio.tmpl |    1 -
>  1 file changed, 1 deletion(-)
> 
> --- linux-2.6.25-git14.orig/Documentation/DocBook/rapidio.tmpl
> +++ linux-2.6.25-git14/Documentation/DocBook/rapidio.tmpl
> @@ -133,7 +133,6 @@
>  !Idrivers/rapidio/rio-sysfs.c
>       </sect1>
>       <sect1 id="PPC32_support"><title>PPC32 support</title>
> -!Iarch/powerpc/kernel/rio.c
>  !Earch/powerpc/sysdev/fsl_rio.c
>  !Iarch/powerpc/sysdev/fsl_rio.c
>       </sect1>

grumble.

This is a subset of rapidio-fix-docbook-references.patch, but I appear to
be unable to interest anyone in merging/reviewing/accepting/anything-else
that quite large set of patches.

Guys, those patches were sent six weeks ago and it now looks like they will
miss 2.6.26.  This is pretty slack of us.  Help?
