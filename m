Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id AC230B71EA
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 18 Jun 2009 19:31:28 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 07DD8DDDA0
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Jun 2009 19:31:27 +1000 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id n5I9VMG7002629
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Jun 2009 04:31:23 -0500
Subject: Re: [PATCH] powerpc: Add irqtrace support for 32-bit powerpc (v2)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <20090618034439.0854ADDDB2@ozlabs.org>
References: <20090618034439.0854ADDDB2@ozlabs.org>
Content-Type: text/plain
Date: Thu, 18 Jun 2009 19:31:21 +1000
Message-Id: <1245317482.21602.53.camel@pasglop>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-06-18 at 13:43 +1000, Benjamin Herrenschmidt wrote:
> Index: linux-work/arch/powerpc/kernel/udbg.c
> ===================================================================
> --- linux-work.orig/arch/powerpc/kernel/udbg.c  2009-06-18
> 13:21:29.000000000 +1000
> +++ linux-work/arch/powerpc/kernel/udbg.c       2009-06-18
> 13:21:39.000000000 +1000
> @@ -65,6 +65,7 @@ void __init udbg_early_init(void)
>  #ifdef CONFIG_PPC_EARLY_DEBUG
>         console_loglevel = 10;
>  #endif
> +       register_early_udbg_console();
>  }

And that bit of course have nothing to do in that patch :-)

No need for a respin for now though unless we find other problems.

Cheers,
Ben.
