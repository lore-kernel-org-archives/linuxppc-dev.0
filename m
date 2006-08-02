Return-Path: <mgreer@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id AA081679A6
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Aug 2006 10:31:23 +1000 (EST)
Date: Tue, 1 Aug 2006 17:35:04 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Matthew McClintock <msm@freescale.com>
Subject: Re: RFC: Location for Device Tree Sources?
Message-ID: <20060802003504.GA20439@mag.az.mvista.com>
References: <1154464346.19994.4.camel@cashmere.sps.mot.com>
	<Pine.LNX.4.60.0608012258040.4041@poirot.grange>
	<1154466094.11069.6.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1154466094.11069.6.camel@localhost>
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

On Tue, Aug 01, 2006 at 04:01:33PM -0500, Matthew McClintock wrote:
> On Tue, 2006-08-01 at 23:00 +0200, Guennadi Liakhovetski wrote:
> > 
> > Mark A. Greer in his patch to port sandpoint to arch/powerpc put 
> > sandpoint.dts under arch/powerpc/boot/dts/sandpoint.dts 
> 
> I believe in his latest patches he removed this part. The device trees
> were not included at all and he left this point open for discussion.

That's correct.

TBH, I think its wrong to keep them in the kernel source at all--yes,
the same argument could be made for arch/powerpc/boot but that's been
settled.

We already have dtc kept externally to the kernel source.  Why not
keep a single site where all things necessary to powerpc linux are kept?
It could house dtc, the dt attach tool, and all the dt source files.

I doesn't matter to me where as long as its highly available and has
reasonable bandwidth.  jdl.com?  source.mvista.com?  penguinppc.org?
other?

Mark
