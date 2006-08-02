Return-Path: <mgreer@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id D46FF67BC8
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Aug 2006 04:18:42 +1000 (EST)
Date: Wed, 2 Aug 2006 11:22:26 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Josh Boyer <jwboyer@jdub.homelinux.org>
Subject: Re: RFC: Location for Device Tree Sources?
Message-ID: <20060802182226.GH17652@mag.az.mvista.com>
References: <1154464346.19994.4.camel@cashmere.sps.mot.com>
	<Pine.LNX.4.60.0608012258040.4041@poirot.grange>
	<1154466094.11069.6.camel@localhost>
	<20060802003504.GA20439@mag.az.mvista.com>
	<1154481150.2676.3.camel@vader.jdub.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1154481150.2676.3.camel@vader.jdub.homelinux.org>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Aug 01, 2006 at 08:12:29PM -0500, Josh Boyer wrote:
> On Tue, 2006-08-01 at 17:35 -0700, Mark A. Greer wrote:
> > On Tue, Aug 01, 2006 at 04:01:33PM -0500, Matthew McClintock wrote:
> > > On Tue, 2006-08-01 at 23:00 +0200, Guennadi Liakhovetski wrote:
> > > > 
> > > > Mark A. Greer in his patch to port sandpoint to arch/powerpc put 
> > > > sandpoint.dts under arch/powerpc/boot/dts/sandpoint.dts 
> > > 
> > > I believe in his latest patches he removed this part. The device trees
> > > were not included at all and he left this point open for discussion.
> > 
> > That's correct.
> > 
> > TBH, I think its wrong to keep them in the kernel source at all--yes,
> > the same argument could be made for arch/powerpc/boot but that's been
> > settled.
> 
> Sorry, I have to disagree.  We're talking about device tree _source_
> files here.  I believe they should be included in the kernel source.
> Where that is, I don't have a particularly strong argument but they
> should be included.

I would agree that its certainly _easier_ to keep them in the src tree.
The only good argument for why its _right_--that I've seen so far--is
by Kumar (i.e., so you have a dts that you know will boot on that kernel).

> > We already have dtc kept externally to the kernel source.  Why not
> > keep a single site where all things necessary to powerpc linux are kept?
> > It could house dtc, the dt attach tool, and all the dt source files.
> 
> I think hosting the dtc, the dt attach tool, and pre-built dtb files for
> each platform in one spot would be a good idea.

Well, if you're going to keep prebuilt dtb files there, why wouldn't you
want the dts that makes that dtb to be in the same place?

Mark
