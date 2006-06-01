Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao04.cox.net (fed1rmmtao04.cox.net [68.230.241.35])
	by ozlabs.org (Postfix) with ESMTP id BAB7067A44
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  2 Jun 2006 06:53:49 +1000 (EST)
Date: Thu, 1 Jun 2006 13:53:46 -0700
From: Matt Porter <mporter@embeddedalley.com>
To: Chris Dumoulin <cdumoulin@ics-ltd.com>, linuxppc-embedded@ozlabs.org
Subject: Re: Pinned TLB entries with 2.6 linux kernel on PPC4xx
Message-ID: <20060601135346.A23836@cox.net>
References: <447F4021.5030109@ics-ltd.com>
	<20060601195129.GA15262@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060601195129.GA15262@gate.ebshome.net>;
	from ebs@ebshome.net on Thu, Jun 01, 2006 at 12:51:29PM -0700
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Jun 01, 2006 at 12:51:29PM -0700, Eugene Surovegin wrote:
> On Thu, Jun 01, 2006 at 03:29:37PM -0400, Chris Dumoulin wrote:
> > Does the idea of creating pinned TLB entries (ones that will never be 
> > overwritten) make sense for a PPC4xx (specifically PPC405) 2.6 linux 
> > kernel? If so, how would this be accomplished?
> 
> 44x kernel already pins some TLB entries, 40x may use this approach to 
> increase performance (I use this in my internal 2.4 tree 
> quite successfully).
> 
> Old 2.4 trees (linuxppc-2.4 or devel_2_4) have TLB pinning support 
> for 40x, you can look at the implementation there.

The partial kernel lowmem pinning for ppc405 was deprecated in favor
of having all of kernel lowmem covered by large pages and then large
TLBs loaded on tlb misses. This is regarding 2.6, of course.

It can also be extended to handle arbitrary areas other than kernel
lowmem.

-Matt
