Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17784.62591.729512.791358@cargo.ozlabs.ibm.com>
Date: Fri, 8 Dec 2006 16:13:35 +1100
From: Paul Mackerras <paulus@samba.org>
To: Anton Blanchard <anton@samba.org>
Subject: Re: Add DSCR SPR to sysfs
In-Reply-To: <20061206205818.GA27857@krispykreme>
References: <20061206205818.GA27857@krispykreme>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Blanchard writes:

> POWER6 adds a new SPR, the data stream control register (DSCR). It can
> be used to adjust how agressive the prefetch mechanisms are.
> 
> Its possible we may want to context switch this, but for now just export
> it to userspace via sysfs so we can adjust it.

I think you need to adjust both CPU_FTRS_POWER6 and CPU_FTRS_POWER6X
in include/asm-powerpc/cputable.h, don't you?  Your patch doesn't
apply cleanly on Linus' current tree.  Please send a rebased patch.

Thanks,
Paul.
