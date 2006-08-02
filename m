Return-Path: <jwboyer@jdub.homelinux.org>
Received: from jdub.homelinux.org (67-40-242-100.roch.qwest.net
	[67.40.242.100])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0B00C67B88
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Aug 2006 11:36:10 +1000 (EST)
Subject: Re: RFC: Location for Device Tree Sources?
From: Josh Boyer <jwboyer@jdub.homelinux.org>
To: "Mark A. Greer" <mgreer@mvista.com>
In-Reply-To: <20060802003504.GA20439@mag.az.mvista.com>
References: <1154464346.19994.4.camel@cashmere.sps.mot.com>
	<Pine.LNX.4.60.0608012258040.4041@poirot.grange>
	<1154466094.11069.6.camel@localhost>
	<20060802003504.GA20439@mag.az.mvista.com>
Content-Type: text/plain
Date: Tue, 01 Aug 2006 20:12:29 -0500
Message-Id: <1154481150.2676.3.camel@vader.jdub.homelinux.org>
Mime-Version: 1.0
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

On Tue, 2006-08-01 at 17:35 -0700, Mark A. Greer wrote:
> On Tue, Aug 01, 2006 at 04:01:33PM -0500, Matthew McClintock wrote:
> > On Tue, 2006-08-01 at 23:00 +0200, Guennadi Liakhovetski wrote:
> > > 
> > > Mark A. Greer in his patch to port sandpoint to arch/powerpc put 
> > > sandpoint.dts under arch/powerpc/boot/dts/sandpoint.dts 
> > 
> > I believe in his latest patches he removed this part. The device trees
> > were not included at all and he left this point open for discussion.
> 
> That's correct.
> 
> TBH, I think its wrong to keep them in the kernel source at all--yes,
> the same argument could be made for arch/powerpc/boot but that's been
> settled.

Sorry, I have to disagree.  We're talking about device tree _source_
files here.  I believe they should be included in the kernel source.
Where that is, I don't have a particularly strong argument but they
should be included.

> 
> We already have dtc kept externally to the kernel source.  Why not
> keep a single site where all things necessary to powerpc linux are kept?
> It could house dtc, the dt attach tool, and all the dt source files.

I think hosting the dtc, the dt attach tool, and pre-built dtb files for
each platform in one spot would be a good idea.

josh
