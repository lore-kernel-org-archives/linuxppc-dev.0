Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7B229DDF70
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Jul 2008 10:59:30 +1000 (EST)
Subject: Re: [2.6 patch] powerpc/boot/Makefile: change spaces to tabs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Adrian Bunk <bunk@kernel.org>
In-Reply-To: <20080717181854.GB18326@cs181140183.pp.htv.fi>
References: <20080717181854.GB18326@cs181140183.pp.htv.fi>
Content-Type: text/plain
Date: Mon, 21 Jul 2008 10:59:13 +1000
Message-Id: <1216601953.11027.63.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	David Gibson <david@gibson.dropbear.id.au>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-07-17 at 21:18 +0300, Adrian Bunk wrote:
> For C code spaces versus tabs is just a religious issue,
> but for Makefiles it actually matters.
> 
> This patch fixes he following errors:
> /home/bunk/linux/kernel-2.6/git/linux-2.6/arch/powerpc/boot/Makefile:166: *** missing separator.  Stop.
> /home/bunk/linux/kernel-2.6/git/linux-2.6/arch/powerpc/boot/Makefile:171: *** missing separator.  Stop.
> 
> Since this was inside an ifdef DTC_GENPARSER it was not a problem unless 
> someone wanted to regenerate the shipped generated files.
> 
> Signed-off-by: Adrian Bunk <bunk@kernel.org>

And that too :-)

Cheers,
Ben.

> ---
> 
>  arch/powerpc/boot/Makefile |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> --- a/arch/powerpc/boot/Makefile
> +++ b/arch/powerpc/boot/Makefile
> @@ -163,12 +163,12 @@ quiet_cmd_flex = FLEX    $@
>        cmd_flex = $(FLEX) -o$@ $<; cp $@ $@_shipped
>  
>  $(obj)/dtc-src/dtc-parser.tab.c: $(src)/dtc-src/dtc-parser.y FORCE
> -     $(call if_changed,bison)
> +	$(call if_changed,bison)
>  
>  $(obj)/dtc-src/dtc-parser.tab.h: $(obj)/dtc-src/dtc-parser.tab.c
>  
>  $(obj)/dtc-src/dtc-lexer.lex.c: $(src)/dtc-src/dtc-lexer.l FORCE
> -     $(call if_changed,flex)
> +	$(call if_changed,flex)
>  endif
>  
>  #############
