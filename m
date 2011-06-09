Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DDD1DB6FC3
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  9 Jun 2011 15:08:17 +1000 (EST)
Subject: Re: [patch 09/14] i8253: Alpha, PowerPC: Remove unused
	<asm/8253pit.h> header.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: ralf@linux-mips.org
In-Reply-To: <20110601180610.684557757@duck.linux-mips.net>
References: <20110601180456.801265664@duck.linux-mips.net>
	<20110601180610.684557757@duck.linux-mips.net>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 09 Jun 2011 15:07:33 +1000
Message-ID: <1307596053.2874.267.camel@pasglop>
Mime-Version: 1.0
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	linux-alpha@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
	Matt Turner <mattst88@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	Richard Henderson <rth@twiddle.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2011-06-01 at 19:05 +0100, ralf@linux-mips.org wrote:
> plain text document attachment
> (i8253-remove-unused-8253pit.h-files.patch)
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> To: linux-kernel@vger.kernel.org
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
> Cc: Matt Turner <mattst88@gmail.com>
> Cc: linux-alpha@vger.kernel.org
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> 
>  arch/alpha/include/asm/8253pit.h   |    3 ---
>  arch/powerpc/include/asm/8253pit.h |    3 ---
>  2 files changed, 6 deletions(-)

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Thanks !

Ben.

> Index: linux-mips/arch/alpha/include/asm/8253pit.h
> ===================================================================
> --- linux-mips.orig/arch/alpha/include/asm/8253pit.h
> +++ /dev/null
> @@ -1,3 +0,0 @@
> -/*
> - * 8253/8254 Programmable Interval Timer
> - */
> Index: linux-mips/arch/powerpc/include/asm/8253pit.h
> ===================================================================
> --- linux-mips.orig/arch/powerpc/include/asm/8253pit.h
> +++ /dev/null
> @@ -1,3 +0,0 @@
> -/*
> - * 8253/8254 Programmable Interval Timer
> - */
> 
