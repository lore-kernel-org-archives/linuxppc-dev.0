Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao04.cox.net (fed1rmmtao04.cox.net [68.230.241.35])
	by ozlabs.org (Postfix) with ESMTP id AE13867A6D
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 19 Mar 2005 06:30:49 +1100 (EST)
Date: Fri, 18 Mar 2005 12:30:46 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Jason McMullan <jason.mcmullan@timesys.com>
Message-ID: <20050318193045.GM8345@smtp.west.cox.net>
References: <20050316231800.GD8345@smtp.west.cox.net>
	<d0e9907f9780a7fce59b3f69af6ece99@freescale.com>
	<1111171391.2987.24.camel@ad.doubleclick.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1111171391.2987.24.camel@ad.doubleclick.net>
Cc: linuxppc-embedded Linux list <linuxppc-embedded@ozlabs.org>
Subject: Re: 440EP FPU patch
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Mar 18, 2005 at 01:43:11PM -0500, Jason McMullan wrote:
> On Fri, 2005-03-18 at 10:06 -0600, Kumar Gala wrote:
> > Can you build your patch for the lopec_defconfig and fix the errors 
> > associated with enabling altivec.
> > 
> > Looks like you need to include asm/offset.h & asm/page.h in vector.S, 
> > however there is another build error after that.
> 
> Thanks! That also found a linking bug, fixed in this patch.. Please
> double check the call in 'AltiVecUnavalible' in head.S, and the re-load
> of 'ctr' at the end of load_up_altivec, as I do not have an AltiVec
> machine here.

No dice:
VFS: Mounted root (nfs filesystem) readonly.
Freeing unused kernel memory: 100k init 4k prep
floating point used in kernel (task=c03816b0, pc=c000d664)
Doing some objdump'ing, that's the start of load_up_altivec.

-- 
Tom Rini
http://gate.crashing.org/~trini/
