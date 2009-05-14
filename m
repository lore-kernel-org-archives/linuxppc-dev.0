Return-Path: <penberg@cs.helsinki.fi>
Received: from mail.cs.helsinki.fi (courier.cs.helsinki.fi [128.214.9.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6031BDE02F
	for <linuxppc-dev@ozlabs.org>; Thu, 14 May 2009 20:01:09 +1000 (EST)
Subject: Re: Next May 11 : BUG during scsi initialization
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Sachin Sant <sachinp@in.ibm.com>
In-Reply-To: <1242295150.21646.10.camel@penberg-laptop>
References: <20090511161442.3e9d9cb9.sfr@canb.auug.org.au>
	<4A081002.4050802@in.ibm.com> <20090511115233.GB8112@parisc-linux.org>
	<4A081437.7000409@in.ibm.com> <20090511122135.GC8112@parisc-linux.org>
	<20090512045716.GC32535@wotan.suse.de>  <4A0BD6BB.1050600@in.ibm.com>
	<1242291113.21646.6.camel@penberg-laptop> <4A0BEA44.2050908@in.ibm.com>
	<1242295150.21646.10.camel@penberg-laptop>
Date: Thu, 14 May 2009 13:01:03 +0300
Message-Id: <1242295263.21646.11.camel@penberg-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Nick Piggin <npiggin@suse.de>, Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-next@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Matthew Wilcox <matthew@wil.cx>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Sachin,

On Thu, 2009-05-14 at 12:59 +0300, Pekka Enberg wrote:
> On Thu, 2009-05-14 at 15:24 +0530, Sachin Sant wrote:
> > Pekka Enberg wrote:
> > > I wasn't able to find your .config in this thread. Can you please post
> > > it?
> > >   
> > Config attached.
> 
> Thanks! Can you please enable CONFIG_DEBUG_VM, CONFIG_DEBUG_LIST, and
> decrease CONFIG_NR_CPUS=1024 to, say, 32 and retest? Perhaps we'll get a
> some clues to what's going on here.

Furthermore, you might want to test with CONFIG_PPC_4K_PAGES and
CONFIG_PPC_16K_PAGES to see if it makes a difference compared to the
CONFIG_PPC_64K_PAGES you currently have.

Thanks!

			Pekka
