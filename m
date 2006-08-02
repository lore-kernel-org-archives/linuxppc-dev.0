Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao02.cox.net (fed1rmmtao02.cox.net [68.230.241.37])
	by ozlabs.org (Postfix) with ESMTP id B72AF67C6C
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Aug 2006 04:21:44 +1000 (EST)
Date: Wed, 2 Aug 2006 11:21:43 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Matthew McClintock <msm@freescale.com>
Subject: Re: RFC: Location for Device Tree Sources?
Message-ID: <20060802182143.GP3075@smtp.west.cox.net>
References: <1154464346.19994.4.camel@cashmere.sps.mot.com>
	<Pine.LNX.4.60.0608012258040.4041@poirot.grange>
	<1154466094.11069.6.camel@localhost>
	<20060802003504.GA20439@mag.az.mvista.com>
	<1154481150.2676.3.camel@vader.jdub.homelinux.org>
	<528646bc0608012020l11690cf7wbb7d93e6ba6eae90@mail.gmail.com>
	<33AC4A3A-876A-4AF9-B851-928EE80A9D80@kernel.crashing.org>
	<20060802163822.GK3075@smtp.west.cox.net>
	<1154542161.5550.25.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1154542161.5550.25.camel@localhost>
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

On Wed, Aug 02, 2006 at 01:09:21PM -0500, Matthew McClintock wrote:
> On Wed, 2006-08-02 at 09:38 -0700, Tom Rini wrote:
> > I'll throw in the caveat that I'm not 100% sure we're that stable yet,
> > but it certainly seems like it, at least for the overall portion where
> > you might really have incompatible trees.  More or less complete (now
> > every device is described!) dts should be interchangable to the kernel
> > for the custom board X is just a little different from ref board Y
> > issues (and now, in theory, the Just Like A Sandpoint board, with a
> > correct dts will boot the 'sandpoint' kernel). 
> 
> The sandpoint (as far as I know) does not have a stable DTS. So in this
> case including the DTS in the kernel would reduce confusion. The same
> could be said for other boards where the DTS needed to be changed for
> the IRQ rework. The old DTS will no longer boot the new kernels. I'm not
> sure how much longer we will run into this problem though.

Yes, as I said, I'm not totally sure we're at the stable point right
now, but I think that we are.  I'll add that maybe we need to think
about API changes and DTS format versions.  To quote from my post..

> > X bugs) or a change that requires a dts version bump.

Now it sounds like the IRQ thing was an "Oops, we should have changed
the dts version" and bailed, noting what is wrong with the dts.

-- 
Tom Rini
