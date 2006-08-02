Return-Path: <jwboyer@jdub.homelinux.org>
Received: from jdub.homelinux.org (67-40-242-100.roch.qwest.net
	[67.40.242.100])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5DA9367C0A
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Aug 2006 05:03:44 +1000 (EST)
Subject: Re: RFC: Location for Device Tree Sources?
From: Josh Boyer <jwboyer@jdub.homelinux.org>
To: "Mark A. Greer" <mgreer@mvista.com>
In-Reply-To: <20060802184930.GN17652@mag.az.mvista.com>
References: <1154464346.19994.4.camel@cashmere.sps.mot.com>
	<Pine.LNX.4.60.0608012258040.4041@poirot.grange>
	<1154466094.11069.6.camel@localhost>
	<20060802003504.GA20439@mag.az.mvista.com>
	<1154481150.2676.3.camel@vader.jdub.homelinux.org>
	<528646bc0608012020l11690cf7wbb7d93e6ba6eae90@mail.gmail.com>
	<20060802182319.GI17652@mag.az.mvista.com>
	<528646bc0608021121l124cd3e8i14dfdfbf40272193@mail.gmail.com>
	<20060802184930.GN17652@mag.az.mvista.com>
Content-Type: text/plain
Date: Wed, 02 Aug 2006 14:03:02 -0500
Message-Id: <1154545382.12757.1.camel@weaponx.rchland.ibm.com>
Mime-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-08-02 at 11:49 -0700, Mark A. Greer wrote:
> On Wed, Aug 02, 2006 at 12:21:37PM -0600, Grant Likely wrote:
> > On 8/2/06, Mark A. Greer <mgreer@mvista.com> wrote:
> > >On Tue, Aug 01, 2006 at 09:20:52PM -0600, Grant Likely wrote:
> > >> I have to second that opinion.  The device tree is absolutely integral
> > >> with the rest of the code/drivers needed to support a board.  I say
> > >> there are stronger arguments for keeping the dts files in the kernel
> > >> source than there are for the boot wrapper.
> > >
> > >Well, the dts is no good to you without dtc so do we put dtc in the
> > >kernel source tree too?
> > 
> > I don't know; should we include gcc also?
> > 
> > :p
> 
> Yep, my point.
> 
> I don't really have a problem with keeping known working dts files in
> arch/powerpc/boot/dts.  Perhaps a 1-1 match with files in
> arch/powerpc/configs?

I like that idea very much.  Actually that's what I thought were were
talking about in the first place.

> 
> It would still be nice to have the dtc source, attach tool source, and,
> if useful, a more exhaustive collection of dts files in one place.

I also think that would be useful.

josh
