Return-Path: <kumar.gala@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id BF8F267A6B
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Apr 2005 09:10:11 +1000 (EST)
In-Reply-To: <20050331201548.GK25923@smtp.west.cox.net>
References: <20050331201548.GK25923@smtp.west.cox.net>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <6bc789cab290e3a49523c59a4a5f73a4@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Thu, 31 Mar 2005 17:10:01 -0600
To: "Tom Rini" <trini@kernel.crashing.org>
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

I'll try to see if I can build a kernel to use on a pegasos box to test=20=

out the avec side tomorrow.

- kumar

On Mar 31, 2005, at 2:15 PM, Tom Rini wrote:

> On Thu, Mar 31, 2005 at 01:10:44PM -0700, Matt wrote:
>  > On Thu, Mar 31, 2005 at 09:34:21AM -0700, Tom Rini wrote:
>  > > On Thu, Mar 31, 2005 at 09:26:18AM -0700, Wade Farnsworth wrote:
>  > > > On Fri, 2005-03-18 at 12:30, Tom Rini wrote:
>  > > > > On Fri, Mar 18, 2005 at 01:43:11PM -0500, Jason McMullan=20
> wrote:
>  > > > > > On Fri, 2005-03-18 at 10:06 -0600, Kumar Gala wrote:
>  > > > > > > Can you build your patch for the lopec_defconfig and fix=20=

> the errors
> > > > > > > associated with enabling altivec.
>  > > > > > >
> > > > > > > Looks like you need to include asm/offset.h & asm/page.h=20=

> in vector.S,
> > > > > > > however there is another build error after that.
>  > > > > >
> > > > > > Thanks! That also found a linking bug, fixed in this patch..=20=

> Please
> > > > > > double check the call in 'AltiVecUnavalible' in head.S, and=20=

> the re-load
>  > > > > > of 'ctr' at the end of load_up_altivec, as I do not have an=20=

> AltiVec
>  > > > > > machine here.
>  > > > >
> > > > > No dice:
>  > > > > VFS: Mounted root (nfs filesystem) readonly.
>  > > > > Freeing unused kernel memory: 100k init 4k prep
>  > > > > floating point used in kernel (task=3Dc03816b0, pc=3Dc000d664)
> > > > > Doing some objdump'ing, that's the start of load_up_altivec.
> > > >
> > > > Hi Jason and Tom,
>  > > >
> > > > Has there been any more progress on this patch?
>  > >
> > > Sadly no.=A0 We got to the point where it was reliably crashing on =
my
> > > LoPEC (7400), but no time to try and fix it.=A0 The problem should=20=

> show up
>  > > on any classic PPC box..
>  >
> > If nobody has time to work on this, then I intend=A0 to put Wade's=20=

> 440EP
>  > support in as is (actually, he's planning on resubmitting with some
>  > additional changes).=A0 When somebody has time, they can redo the=20=

> patch
> > against that.
>
> That's a good point to bring up.=A0 Jason, do you want to post your
>  current version to the list and we can try and see if we can get it
>  workign right?
>
> --=20
> Tom Rini
>  http://gate.crashing.org/~trini/
> _______________________________________________
> Linuxppc-embedded mailing list
>  Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
