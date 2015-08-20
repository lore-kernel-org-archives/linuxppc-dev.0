Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 401BF1A0102
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2015 11:09:56 +1000 (AEST)
Message-ID: <1440032995.13406.6.camel@ellerman.id.au>
Subject: Re: provide more common DMA API functions V2
From: Michael Ellerman <mpe@ellerman.id.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Andrew Morton <akpm@linux-foundation.org>, jonas@southpole.se,
 linux-ia64@vger.kernel.org, monstr@monstr.eu, linux@arm.linux.org.uk,
 ysato@users.sourceforge.jp, arnd@arndb.de, linux-mips@linux-mips.org,
 linux-sh@vger.kernel.org, catalin.marinas@arm.com, x86@kernel.org,
 will.deacon@arm.com, linux-kernel@vger.kernel.org, Ingo Molnar
 <mingo@kernel.org>,  cmetcalf@ezchip.com, linux-alpha@vger.kernel.org,
 sparclinux@vger.kernel.org,  linux-hexagon@vger.kernel.org,
 linux-s390@vger.kernel.org, gxt@mprc.pku.edu.cn,
 linuxppc-dev@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>
Date: Thu, 20 Aug 2015 11:09:55 +1000
In-Reply-To: <20150820095233.30bb9689@canb.auug.org.au>
References: <1439795216-32189-1-git-send-email-hch@lst.de>
 <20150817142429.95a3965e0b35d0f35d3c4cfe@linux-foundation.org>
 <20150818053825.GA20771@lst.de>
 <20150817224552.43d7267d.akpm@linux-foundation.org>
 <20150818075107.GA31884@gmail.com> <20150819080814.GA18115@lst.de>
 <20150819143656.3a38eb538ffac60386e1224a@linux-foundation.org>
 <20150820095233.30bb9689@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-08-20 at 09:52 +1000, Stephen Rothwell wrote:
> Hi Andrew (sorry, I can't tell who made the incorrect statement below
> that I am replying to),
> 
> On Wed, 19 Aug 2015 14:36:56 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Wed, 19 Aug 2015 10:08:14 +0200 Christoph Hellwig <hch@lst.de> wrote:
> > 
> > > On Tue, Aug 18, 2015 at 09:51:07AM +0200, Ingo Molnar wrote:
> > > > I.e. shouldn't this be:
> > > > 
> > > > > I'll merge these 5 patches for 4.4.  That means I'll release them into 
> > > > > linux-next after 4.2 is released.
> > > > >
> > > > > [...]
> > > > > 
> > > > > Linus will be releasing 4.2 in 1-2 weeks and until then, linux-next is supposed 
> > > > > to contain only 4.3 material.  Once 4.2 is released and the 4.3 merge window 
> > > > > opens, linux-next is open for 4.4 material.
> 
> Just to be clear: the above should read "Once 4.2 is released and the
> 4.3 merge window *closes* (i.e. v4.3-rc1 is released), linux-next is
> open for 4.4 material".

/me registers www.whatdamnkernelversionareweuptoagain.com

cheers
