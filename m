Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0130.outbound.protection.outlook.com [65.55.169.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EC8CB1A0BD4
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Feb 2015 12:05:41 +1100 (AEDT)
Message-ID: <1423011921.12631.8.camel@aoeu.buserror.net>
Subject: Re: Pull request: scottwood/linux.git next
From: Scott Wood <scottwood@freescale.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Date: Tue, 3 Feb 2015 19:05:21 -0600
In-Reply-To: <1423011533.7982.3.camel@ellerman.id.au>
References: <20150203172056.GA14407@SnaresPenguin>
 <1423011533.7982.3.camel@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-02-04 at 11:58 +1100, Michael Ellerman wrote:
> On Tue, 2015-02-03 at 11:20 -0600, Scott Wood wrote:
> > Highlights include 8xx optimizations, some more work on datapath device
> > tree content, e300 machine check support, t1040 corenet error reporting,
> > and various cleanups and fixes.
> > 
> > The following changes since commit 31494cf3532cfee0bf5c913ac9962971aab7b1d4:
> > 
> >   powerpc/powernv: Don't alloc IRQ map if necessary (2015-01-28 15:28:10 +1100)
> > 
> > are available in the git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/scottwood/linux.git next
> > 
> > for you to fetch changes up to 0dc294f717d41bfbafc746a7a96a7bc0f114c20c:
> > 
> >   powerpc/mm: bail out early when flushing TLB page (2015-01-30 18:39:00 -0600)
> 
> 
> Hi Scott,
> 
> It's not a big deal but a few of the subjects are a bit off in here. I'm not
> going to ask you to respin or anything, but in general if we can stick with
> "powerpc[/topic]: ..." that'd be good.  

Sorry... I normally fix those up but apparently I didn't notice this
time.

> >       perf/powerpc: reset event hw state when adding it to the PMU
> >       powerpc: defconfigs: add MTD_SPI_NOR (new dependency for M25P80)
> >       powerpc32: adds handling of _PAGE_RO
> >       powerpc32: Use kmem_cache memory for PGDIR
> >       PowerPC-83xx: Deletion of an unnecessary check before the function call "of_node_put"
> 
> 
> Also there was a v2 of this one:
> 
> >       powerpc/mm: bail out early when flushing TLB page
> 
> Do you want to merge that as an incremental fix, or I can, let me know?

I had pushed a day or so before v2 came along...  Go ahead and merge the
incremental fix.

-Scott
