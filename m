Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B4A7CDDD04
	for <linuxppc-dev@ozlabs.org>; Thu, 10 May 2007 06:04:15 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id
	l49K0ju4010614
	for <linuxppc-dev@ozlabs.org>; Wed, 9 May 2007 16:00:45 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l49K48uK179310
	for <linuxppc-dev@ozlabs.org>; Wed, 9 May 2007 14:04:08 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l49K47Cw029009
	for <linuxppc-dev@ozlabs.org>; Wed, 9 May 2007 14:04:07 -0600
Subject: Re: Section mismatch warnings (was Re: [PATCH] early_pfn_to_nid
	needs to be __meminit)
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Linas Vepstas <linas@austin.ibm.com>
In-Reply-To: <20070509194503.GZ4452@austin.ibm.com>
References: <20070510022552.4bb1a407.sfr@canb.auug.org.au>
	<20070509165115.GA23576@iram.es> <20070509194503.GZ4452@austin.ibm.com>
Content-Type: text/plain
Date: Wed, 09 May 2007 14:58:13 -0500
Message-Id: <1178740693.3086.81.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	LKML <linux-kernel@vger.kernel.org>,
	ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-05-09 at 14:45 -0500, Linas Vepstas wrote:
> On Wed, May 09, 2007 at 06:51:15PM +0200, Gabriel Paubert wrote:
> > On Thu, May 10, 2007 at 02:25:52AM +1000, Stephen Rothwell wrote:
> > > This removes a section mismatch warning in those circumstances.
> > 
> > Speaking of this, I just tried to compile an official (Linus' git tree) 
> > kernel for my old PMac G4 and I get a lot of section mismatch warnings at 
> > the end of the compilation:
> > 
> > WARNING: arch/powerpc/mm/built-in.o - Section mismatch: reference to .init.text:early_get_page from .text between 'pte_alloc_one_kernel' (at offset 0xf50) and 'v_mapped_by_bats'
> > 
> > I find these 50 or so warnings so scary that I've not yet tried 
> > to boot the kernel. Note that this is a non-modular kernel.
> 
> I'm getting oodles of these on an older -mm2 tree. The kernels seem to
> work fine. Yes, they should be fixed but I'm up to my proverbial eyballs
> in alligators.

Yeah, I see all kinds of this too.  Does anyone have an idea why they're
being spit out?  Or if it's related to a particular binutils version,
etc?

josh
