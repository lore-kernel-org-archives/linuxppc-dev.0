Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 697D1DE06C
	for <linuxppc-dev@ozlabs.org>; Thu,  1 May 2008 03:32:18 +1000 (EST)
Date: Wed, 30 Apr 2008 10:31:32 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v2] [POWERPC] devres: Add devm_ioremap_flags()
Message-Id: <20080430103132.c110a84c.akpm@linux-foundation.org>
In-Reply-To: <Pine.LNX.4.64.0804301106010.22992@blarg.am.freescale.net>
References: <Pine.LNX.4.64.0804301106010.22992@blarg.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: htejun@gmail.com, jeff@garzik.org, greg@kroah.com,
	linux-kernel@vger.kernel.org, Emilian.Medve@Freescale.com,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 30 Apr 2008 11:08:51 -0500 (CDT)
Kumar Gala <galak@kernel.crashing.org> wrote:

> From: Emil Medve <Emilian.Medve@Freescale.com>
> 
> We provide an ioremap_flags so provide a coresphonding devm_ioremap_flags.
> 
> Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
> 
> Forgot to commit the actual implemtation in arch/powerpc/lib/devres.c
> 
> Which tree should this go through, powerpc.git?

I'd say so, yes.

> arch/powerpc/lib/Makefile |    1 +
> arch/powerpc/lib/devres.c |   33 +++++++++++++++++++++++++++++++++
> include/asm-powerpc/io.h  |    8 +++++++-
> include/linux/io.h        |    1 +
> lib/devres.c              |    2 +-
>
