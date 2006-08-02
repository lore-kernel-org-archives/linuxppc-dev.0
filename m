Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 72D5A67BC8
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Aug 2006 04:17:04 +1000 (EST)
Date: Wed, 2 Aug 2006 22:16:54 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Matthew McClintock <msm@freescale.com>
Subject: Re: RFC: Location for Device Tree Sources?
Message-ID: <20060802221654.5c54a9a2@localhost.localdomain>
In-Reply-To: <1154542161.5550.25.camel@localhost>
References: <1154464346.19994.4.camel@cashmere.sps.mot.com>
	<Pine.LNX.4.60.0608012258040.4041@poirot.grange>
	<1154466094.11069.6.camel@localhost>
	<20060802003504.GA20439@mag.az.mvista.com>
	<1154481150.2676.3.camel@vader.jdub.homelinux.org>
	<528646bc0608012020l11690cf7wbb7d93e6ba6eae90@mail.gmail.com>
	<33AC4A3A-876A-4AF9-B851-928EE80A9D80@kernel.crashing.org>
	<20060802163822.GK3075@smtp.west.cox.net>
	<1154542161.5550.25.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Wed, 02 Aug 2006 13:09:21 -0500
Matthew McClintock wrote:

> On Wed, 2006-08-02 at 09:38 -0700, Tom Rini wrote:
> > I'll throw in the caveat that I'm not 100% sure we're that stable
> > yet, but it certainly seems like it, at least for the overall
> > portion where you might really have incompatible trees.  More or
> > less complete (now every device is described!) dts should be
> > interchangable to the kernel for the custom board X is just a
> > little different from ref board Y issues (and now, in theory, the
> > Just Like A Sandpoint board, with a correct dts will boot the
> > 'sandpoint' kernel). 
> 
> The sandpoint (as far as I know) does not have a stable DTS. So in
> this case including the DTS in the kernel would reduce confusion. The
> same could be said for other boards where the DTS needed to be
> changed for the IRQ rework. The old DTS will no longer boot the new
> kernels. I'm not sure how much longer we will run into this problem
> though.
> 
I am right about to submit dts+code working fine w/ recent IRQ stuff for 8540 and 8560,
and will make sure dts coming along.

But, I guess we finally should end up with a place in kernel tree where such a stuff should reside
further.
