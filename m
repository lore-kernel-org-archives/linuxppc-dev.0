Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41ltw75zL1zDqrN
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Aug 2018 00:25:43 +1000 (AEST)
In-Reply-To: <25463c4f-4901-b86f-2002-6c65c9ee9fd2@infradead.org>
To: Randy Dunlap <rdunlap@infradead.org>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Scott Wood <oss@buserror.net>, Paul Mackerras <paulus@samba.org>
Subject: Re: powerpc/platforms/85xx: fix t1042rdb_diu.c build errors & warning
Message-Id: <41ltw05Ljlz9s7Q@ozlabs.org>
Date: Thu,  9 Aug 2018 00:25:36 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2018-07-15 at 17:34:46 UTC, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix build errors and warnings in t1042rdb_diu.c by adding header files
> and MODULE_LICENSE().
> 
> ../arch/powerpc/platforms/85xx/t1042rdb_diu.c:152:1: warning: data definition has no type or storage class
>  early_initcall(t1042rdb_diu_init);
> ../arch/powerpc/platforms/85xx/t1042rdb_diu.c:152:1: error: type defaults to 'int' in declaration of 'early_initcall' [-Werror=implicit-int]
> ../arch/powerpc/platforms/85xx/t1042rdb_diu.c:152:1: warning: parameter names (without types) in function declaration
> 
> and
> WARNING: modpost: missing MODULE_LICENSE() in arch/powerpc/platforms/85xx/t1042rdb_diu.o
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Scott Wood <oss@buserror.net>
> Cc: Kumar Gala <galak@kernel.crashing.org>
> Cc: linuxppc-dev@lists.ozlabs.org

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/f5daf77a55ef0e695cc90c440ed650

cheers
