Return-Path: <benh@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@freescale.com>
In-Reply-To: <Pine.LNX.4.61.0509081611230.5055@nylon.am.freescale.net>
References: <Pine.LNX.4.61.0509081611230.5055@nylon.am.freescale.net>
Content-Type: text/plain
Date: Fri, 09 Sep 2005 09:56:05 +1000
Message-Id: <1126223767.29803.34.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: Re: [PATCH] ppc: Merge tlb.h
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2005-09-08 at 16:11 -0500, Kumar Gala wrote:
> Merged tlb.h between asm-ppc32 and asm-ppc64 into asm-powerpc.  Also, fixed
> a compiler warning in arch/ppc/mm/tlb.c since it was roughly related.
> 
> Signed-off-by: Kumar K. Gala <kumar.gala@freescale.com>

Do we want to do that ?

Replacing 2 different files with one split in #ifdef isn't a progress...
As I said, I think we need two subdirs for the low level stuffs that is
different, and that includes at this point all of the memory management
related stuff.

In addition, I'd appreciate if we could avoid touching ppc64 mm related
files completely for a couple of weeks as I'm working on a fairly big
patch that I'm really tired of having to rebase all the time ;)

Ben.
