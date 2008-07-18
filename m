Return-Path: <dgibson@ozlabs.org>
Date: Fri, 18 Jul 2008 13:43:55 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Adrian Bunk <bunk@kernel.org>
Subject: Re: [2.6 patch] powerpc/boot/dtc-src/dtc-lexer.l: add %option noinput
Message-ID: <20080718034355.GE18748@yookeroo.seuss>
References: <20080717181949.GC18326@cs181140183.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20080717181949.GC18326@cs181140183.pp.htv.fi>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jul 17, 2008 at 09:19:49PM +0300, Adrian Bunk wrote:
> gcc 4.3 correctly determines that input() is unused and gives the 
> following warning:
> 
> <--  snip  -->
> 
> ...
>   HOSTCC  arch/powerpc/boot/dtc-src/dtc-lexer.lex.o
> dtc-lexer.lex.c:1436: warning: ‘input’ defined but not used
> ...
> 
> <--  snip  -->
> 
> Fix it by adding %option noinput to 
> arch/powerpc/boot/dtc-src/dtc-lexer.l and 
> regeneration of arch/powerpc/boot/dtc-src/dtc-lexer.lex.c_shipped.
> 
> Signed-off-by: Adrian Bunk <bunk@kernel.org>

Uh.. that should be fixed in dtc upstream.  It's probably time we
updated the in-kernel dtc from upstream anyway.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
