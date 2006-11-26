Return-Path: <rutger@wingding.demon.nl>
Received: from post-24.mail.nl.demon.net (post-24.mail.nl.demon.net
	[194.159.73.194]) by ozlabs.org (Postfix) with ESMTP id 4E5CF679FD
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Nov 2006 05:47:46 +1100 (EST)
Date: Sun, 26 Nov 2006 19:47:43 +0100
From: Rutger Nijlunsing <rutger@nospam.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] Provide dummy hard_irq_enable/disable() for PPC32
Message-ID: <20061126184743.GA4080@nospam.com>
References: <20061126063616.A186067B22@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061126063616.A186067B22@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Reply-To: linuxppc-dev@tux.tmfweb.nl
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Nov 26, 2006 at 05:36:15PM +1100, Michael Ellerman wrote:
> To allow arch/powerpc/kernel/crash.c to build on 32-bit we need a
> definition of hard_irq_disable(). 32-bit doesn't support the lazy
> interrupt disabling mechanism, so on 32-bit hard_irq_disable() is
> simply local_irq_disable(). Add a definition for hard_irq_enable()
> just for completeness.
> 
> This allows (KEXEC=y && PPC32=y) to build again. Broken since
> d04c56f73c30a5e593202ecfcf25ed43d42363a2.
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> ---
> Paulus,
> 
> if this is OK by you, I think it should probably go in for 2.6.19.

d04c56f73c30a5e593202ecfcf25ed43d42363a2 is not in Linus' tree
currently, so no need to fix it in 2.6.19 I would say...

-- 
Rutger Nijlunsing ---------------------------------- eludias ed dse.nl
never attribute to a conspiracy which can be explained by incompetence
----------------------------------------------------------------------
