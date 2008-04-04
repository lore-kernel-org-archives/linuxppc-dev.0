Return-Path: <dale@farnsworth.org>
Received: from xyzzy.farnsworth.org (xyzzy.farnsworth.org [65.39.95.219])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DBBECDE2CC
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Apr 2008 08:30:00 +1100 (EST)
Date: Fri, 4 Apr 2008 14:29:52 -0700
From: Dale Farnsworth <dale@farnsworth.org>
To: Johannes Berg <johannes@sipsolutions.net>
Message-ID: <20080404212952.GA15454@farnsworth.org>
References: <20080201195040.GA8950@farnsworth.org>
	<1207145738.3957.2.camel@johannes.berg>
	<1207337598.19189.77.camel@johannes.berg>
MIME-Version: 1.0
In-Reply-To: <1207337598.19189.77.camel@johannes.berg>
Subject: Re: [RFC/PATCH] powerpc: Add irqtrace support to 32-bit powerpc
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, Benjamin Herrenschmidt <benh@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Apr 04, 2008 at 09:33:18PM +0200, Johannes Berg wrote:
> On Wed, 2008-04-02 at 16:15 +0200, Johannes Berg wrote:
> > On Fri, 2008-02-01 at 12:50 -0700, Dale Farnsworth wrote:
> > > This adds the low level irq tracing hooks for 32-bit powerpc.
> > > This patch applies on top of Benjamin Herrenschmidt's patch that
> > > provides similar support for 64-bit powerpc.  See
> > > <http://ozlabs.org/pipermail/linuxppc-dev/2007-October/044361.html>
> > > 
> > > It seems to work on my prpmc2800 board with a ppc7447.
> > 
> > At first it appears to work on my powerbook (with Ben's latest version
> > of the 64-bit patch), but then it seems to cause random corruption, I've
> > had a crash in the ext3 code and one in console_callback(), both of
> > which I cannot otherwise explain.
> 
> FWIW, same kernel without the patch works fine.

My apologies, Johannes.  I made some unwarranted assumptions about
register usage in the lowest-level exception handlers.  While it worked
on my 7447 board, I saw similar random failures on the 85xx (booke) system
I tried.

Thanks for testing this.

I'll follow up with a revised patch.

-Dale
