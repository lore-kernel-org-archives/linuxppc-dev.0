Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 1592067A46
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Apr 2005 04:46:18 +1000 (EST)
In-Reply-To: <20050331163420.GI25923@smtp.west.cox.net>
References: <20050331163420.GI25923@smtp.west.cox.net>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <b931159370eb09607fdee4a0f438d57f@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Thu, 31 Mar 2005 12:45:44 -0600
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

Tom,

On Mar 31, 2005, at 10:34 AM, Tom Rini wrote:

> On Thu, Mar 31, 2005 at 09:26:18AM -0700, Wade Farnsworth wrote:
>  > On Fri, 2005-03-18 at 12:30, Tom Rini wrote:
>  > > On Fri, Mar 18, 2005 at 01:43:11PM -0500, Jason McMullan wrote:
>  > > > On Fri, 2005-03-18 at 10:06 -0600, Kumar Gala wrote:
>  > > > > Can you build your patch for the lopec_defconfig and fix the=20=

> errors
> > > > > associated with enabling altivec.
>  > > > >
> > > > > Looks like you need to include asm/offset.h & asm/page.h in=20
> vector.S,
> > > > > however there is another build error after that.
>  > > >
> > > > Thanks! That also found a linking bug, fixed in this patch..=20
> Please
>  > > > double check the call in 'AltiVecUnavalible' in head.S, and the=20=

> re-load
>  > > > of 'ctr' at the end of load_up_altivec, as I do not have an=20
> AltiVec
>  > > > machine here.
>  > >
> > > No dice:
>  > > VFS: Mounted root (nfs filesystem) readonly.
>  > > Freeing unused kernel memory: 100k init 4k prep
>  > > floating point used in kernel (task=3Dc03816b0, pc=3Dc000d664)
> > > Doing some objdump'ing, that's the start of load_up_altivec.
> >
> > Hi Jason and Tom,
>  >
> > Has there been any more progress on this patch?
>
> Sadly no.=A0 We got to the point where it was reliably crashing on my
> LoPEC (7400), but no time to try and fix it.=A0 The problem should =
show=20
> up
>  on any classic PPC box..

Is it crashing on just avec code or everything?

- kumar
