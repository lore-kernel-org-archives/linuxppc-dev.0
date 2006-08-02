Return-Path: <mgreer@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 8CB8F67BF7
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Aug 2006 04:45:57 +1000 (EST)
Date: Wed, 2 Aug 2006 11:49:30 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: RFC: Location for Device Tree Sources?
Message-ID: <20060802184930.GN17652@mag.az.mvista.com>
References: <1154464346.19994.4.camel@cashmere.sps.mot.com>
	<Pine.LNX.4.60.0608012258040.4041@poirot.grange>
	<1154466094.11069.6.camel@localhost>
	<20060802003504.GA20439@mag.az.mvista.com>
	<1154481150.2676.3.camel@vader.jdub.homelinux.org>
	<528646bc0608012020l11690cf7wbb7d93e6ba6eae90@mail.gmail.com>
	<20060802182319.GI17652@mag.az.mvista.com>
	<528646bc0608021121l124cd3e8i14dfdfbf40272193@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <528646bc0608021121l124cd3e8i14dfdfbf40272193@mail.gmail.com>
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

On Wed, Aug 02, 2006 at 12:21:37PM -0600, Grant Likely wrote:
> On 8/2/06, Mark A. Greer <mgreer@mvista.com> wrote:
> >On Tue, Aug 01, 2006 at 09:20:52PM -0600, Grant Likely wrote:
> >> I have to second that opinion.  The device tree is absolutely integral
> >> with the rest of the code/drivers needed to support a board.  I say
> >> there are stronger arguments for keeping the dts files in the kernel
> >> source than there are for the boot wrapper.
> >
> >Well, the dts is no good to you without dtc so do we put dtc in the
> >kernel source tree too?
> 
> I don't know; should we include gcc also?
> 
> :p

Yep, my point.

I don't really have a problem with keeping known working dts files in
arch/powerpc/boot/dts.  Perhaps a 1-1 match with files in
arch/powerpc/configs?

It would still be nice to have the dtc source, attach tool source, and,
if useful, a more exhaustive collection of dts files in one place.

benh?  paulus?

Mark
