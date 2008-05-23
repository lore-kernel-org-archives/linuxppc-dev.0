Return-Path: <rsass@uncc.edu>
Received: from rsass-homer.uncc.edu (rsass-homer.uncc.edu [152.15.91.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E4D76DDFF1
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 23 May 2008 11:26:42 +1000 (EST)
Message-Id: <200805230126.m4N1QVEk000778@rsass-homer.uncc.edu>
To: John Bonesio <john.bonesio@xilinx.com>
Subject: Re: APU FPU in Virtex ppc405 
In-reply-to: <20080523010910.1976B408066@mail161-dub.bigfish.com> 
References: <4835FC73.5080102@dlasys.net>
	<20080523010910.1976B408066@mail161-dub.bigfish.com>
Date: Thu, 22 May 2008 21:26:31 -0400
From: Ron Sass <rsass@uncc.edu>
Cc: Thomas Werne <thomas.a.werne@jpl.nasa.gov>,
	"A. Nolson" <alohanono@gmail.com>,
	Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>,
	Shanyuan Gao <sygao.research@gmail.com>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Shan and I are going to sit down and rebuild our tool chain (a mix
of crosstool, linux-from-scratch, and Xilinx patches) next week.
Our aim is to quantify the gains/losses of frequency versus
hardware acceleration since we have several large scientific apps
we plan to run.  Like he said, we're hoping to have a handle on
the best approach over the next couple of weeks.

Ron

> My understanding is that with the fpu on the ppc405 (not ppc440), the
> processor clock rate had to be reduced for the fpu to work. This ended
> up negating much of the performance benefits of using the fpu.
> 
> I don't know the specifics offhand, but Xilinx answer records can be
> searched. Hopefully I'm wrong, and there can still be a benefit to using
> the ppc405 fpu.
> 
> - John
> 
> 
> On Thu, 2008-05-22 at 19:06 -0400, David H. Lynch Jr. wrote:
> >    Were the issues associated with getting the Xilinx Floating point APU
> > working with Linux completely resolved ?
> >     Is there a git tree or patch collection with the appropriate patches
> > etc ?
> > 
> > 
> > 
> 
