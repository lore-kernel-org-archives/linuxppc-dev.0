Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao04.cox.net (fed1rmmtao04.cox.net [68.230.241.35])
	by ozlabs.org (Postfix) with ESMTP id DEB95686E4
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Nov 2005 09:48:55 +1100 (EST)
Date: Tue, 8 Nov 2005 15:48:53 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Tom Rini <trini@kernel.crashing.org>
Message-ID: <20051108154853.H27232@cox.net>
References: <20051108223631.GR3839@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20051108223631.GR3839@smtp.west.cox.net>;
	from trini@kernel.crashing.org on Tue, Nov 08, 2005 at 03:36:31PM
	-0700
Cc: Andrew Morton <akpm@osdl.org>, Kumar Gala <galak@gate.crashing.org>,
	Matt Mackall <mpm@selenic.com>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2.6.14] ppc32: Fix CONFIG_PRINTK=n building
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Nov 08, 2005 at 03:36:31PM -0700, Tom Rini wrote:
> The following patch is needed to allow PRINTK=n to work on ppc32.
> 
> Direct calls to printk from asm files can't be magically removed so we
> have to do it manually.
> 
> Signed-off-by: Tom Rini <trini@kernel.crashing.org>
> 
> Index: linux-2.6.14/arch/ppc/kernel/fpu.S
> ===================================================================
> --- linux-2.6.14.orig/arch/ppc/kernel/fpu.S

This file doesn't exist in mainline. 2.6.14 is too old as a reference
for ppc patches due to the arch/powerpc/ merge.

-Matt
