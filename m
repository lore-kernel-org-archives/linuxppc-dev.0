Return-Path: <linuxppcleo@gmail.com>
Received: from wx-out-0102.google.com (wx-out-0102.google.com [66.249.82.205])
	by ozlabs.org (Postfix) with ESMTP id E978C67A3A
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Aug 2006 00:49:15 +1000 (EST)
Received: by wx-out-0102.google.com with SMTP id t14so1022768wxc
	for <linuxppc-dev@ozlabs.org>; Thu, 03 Aug 2006 07:49:13 -0700 (PDT)
Message-ID: <a0bc9bf80608030749x57eb81che2225e8a6499b41a@mail.gmail.com>
Date: Thu, 3 Aug 2006 22:49:11 +0800
From: "Li Yang" <LeoLi@freescale.com>
Sender: linuxppcleo@gmail.com
To: "Kumar Gala" <galak@kernel.crashing.org>
Subject: Re: RFC: Location for Device Tree Sources?
In-Reply-To: <A6047A42-78C4-4B38-B7B1-77B2C6E9A5CC@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <Pine.LNX.4.60.0608012258040.4041@poirot.grange>
	<1154481150.2676.3.camel@vader.jdub.homelinux.org>
	<528646bc0608012020l11690cf7wbb7d93e6ba6eae90@mail.gmail.com>
	<33AC4A3A-876A-4AF9-B851-928EE80A9D80@kernel.crashing.org>
	<20060802163822.GK3075@smtp.west.cox.net>
	<1154542161.5550.25.camel@localhost>
	<20060802182143.GP3075@smtp.west.cox.net>
	<1154542988.19994.36.camel@cashmere.sps.mot.com>
	<20060802185728.GQ3075@smtp.west.cox.net>
	<A6047A42-78C4-4B38-B7B1-77B2C6E9A5CC@kernel.crashing.org>
Cc: Tom Rini <trini@kernel.crashing.org>,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 8/3/06, Kumar Gala <galak@kernel.crashing.org> wrote:
>
> On Aug 2, 2006, at 1:57 PM, Tom Rini wrote:
>
> > On Wed, Aug 02, 2006 at 01:23:08PM -0500, Jon Loeliger wrote:
> >> On Wed, 2006-08-02 at 13:21, Tom Rini wrote:
> >>
> >>> Yes, as I said, I'm not totally sure we're at the stable point right
> >>> now, but I think that we are.  I'll add that maybe we need to think
> >>> about API changes and DTS format versions.  To quote from my post..
> >>>
> >>>>> X bugs) or a change that requires a dts version bump.
> >>>
> >>> Now it sounds like the IRQ thing was an "Oops, we should have
> >>> changed
> >>> the dts version" and bailed, noting what is wrong with the dts.
> >>
> >> This confuses me.  There hasn't been a change in the DTS
> >> format at all.  I've even updated the 8641HPCN DTS file
> >> across the IRQ updates and all is fine.  Same (DTS) format
> >> both before and after the IRQ changes.
> >>
> >> What have I missed here?
> >
> > Matthew said:
> >> The sandpoint (as far as I know) does not have a stable DTS. So in
> >> this
> >> case including the DTS in the kernel would reduce confusion. The same
> >> could be said for other boards where the DTS needed to be changed for
> >> the IRQ rework. The old DTS will no longer boot the new kernels.
> >> I'm not
> >> sure how much longer we will run into this problem though.
> >
> > Now, if we've had to change the contents of the DTS because of a
> > kernel
> > change, I'd say the DTS format changed as when I say format I mean not
> > only layout and naming, but what the contents are supposed to contain.
> >
> > And, so it's clear, I don't know if we're at the very stable format
> > (names/layout/content means...), but when we are at that point, what
> > Matthew noted should, IMHO, be a graceful (ie explained in the panic()
> > or something) death.
> >
> > And, so it's clear, I think (and hope!) we all agree on that last
> > part,
> > once we hit stability.
>
> Agree about the comments related to the stability of the API, I just
> dont think we are there yet.  We should revisit the issue when we
> removed arch/ppc, until that point I would say things are up in the air.
>
> For example, we still haven't closed on CPM descriptions and I'm sure
> we will go through several iterations before we get it right.  For
> more standard things like uart's, ethernet, pci we have the OF specs
> to model off of and are probably pretty stable.

I agree.  We are adding more and more device types under device tree
management.  There will be a process of evolution.
>
> Additionally, Ben and I have talked about making macro's in the dts's
> so we can build up a board or SOC description from standard building
> blocks so people dont get the simple things wrong.

What are the macros about? Like constant we used in source code?
>
> - kumar
- Leo
