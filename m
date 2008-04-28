Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18453.26718.402204.95133@cargo.ozlabs.ibm.com>
Date: Mon, 28 Apr 2008 16:02:06 +1000
From: Paul Mackerras <paulus@samba.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] Add IRQSTACKS support on ppc32
In-Reply-To: <D84B894B-B6E8-47FD-97CE-CACDE7835B78@kernel.crashing.org>
References: <Pine.LNX.4.64.0804240814280.29846@blarg.am.freescale.net>
	<18453.24013.647603.723185@cargo.ozlabs.ibm.com>
	<D84B894B-B6E8-47FD-97CE-CACDE7835B78@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala writes:

> > Mostly looks great.  One minor nit is that this ifdef could disappear
> > entirely now:
> 
> How do you figure?  If we want to maintain it as a config option (for  
> at least 2.6.26) we  either need this ifdef or a dummy irq_ctx_init().

In include/asm-powerpc/irq.h we already have a dummy definition:

#ifdef CONFIG_IRQSTACKS

...

#else
#define irq_ctx_init()

#endif /* CONFIG_IRQSTACKS */

Paul.
