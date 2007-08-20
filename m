Return-Path: <dgibson@ozlabs.org>
Date: Mon, 20 Aug 2007 16:00:00 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 0/3 v2] Remove need for include/asm-ppc
Message-ID: <20070820060000.GA26100@localhost.localdomain>
References: <Pine.LNX.4.64.0708181203320.31362@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.64.0708181203320.31362@blarg.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Aug 18, 2007 at 12:05:36PM -0500, Kumar Gala wrote:
> This patch series removes the need for include/asm-ppc in the ARCH=powerpc
> build for ppc32.  They exist in the following git tree:
> 
>   master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git for-2.6.24
> 
> posting here for everyone else to see.
> 
> Updated with changes suggested by Arnd & Segher. (removal 82xx pci header
> and moving some headers under platforms if not globally needed).

Nice!  I'm hoping the next step after this is to do the other way
around - make ARCH=ppc builds independent of things in arch/powerpc or
include/asm-powerpc, which is almost the more important change.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
