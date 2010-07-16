Return-Path: <nico@fluxnic.net>
Received: from relais.videotron.ca (relais.videotron.ca [24.201.245.36])
	by ozlabs.org (Postfix) with ESMTP id D344FB6F05
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 17 Jul 2010 04:40:40 +1000 (EST)
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR003.ip.videotron.ca
	(Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008;
	32bit))
	with ESMTP id <0L5N00A46YJQ4TB0@VL-MH-MR003.ip.videotron.ca> for
	linuxppc-dev@lists.ozlabs.org; Fri, 16 Jul 2010 14:40:39 -0400 (EDT)
Date: Fri, 16 Jul 2010 14:40:38 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC PATCH] Kconfig: Enable Kconfig fragments to be used for
	defconfig
In-reply-to: <20100716183028.GB26854@n2100.arm.linux.org.uk>
Message-id: <alpine.LFD.2.00.1007161439240.10598@xanadu.home>
References: <20100713230352.6781.18644.stgit@angua>
	<1279296221.17878.66.camel@e102109-lin.cambridge.arm.com>
	<AANLkTinyFBTKYaryFANYheTuP-biJUws2x01NRNZPb4M@mail.gmail.com>
	<alpine.LFD.2.00.1007161406120.10598@xanadu.home>
	<20100716183028.GB26854@n2100.arm.linux.org.uk>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Daniel Walker <dwalker@codeaurora.org>,
	linux-kbuild@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	=?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	lkml <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 16 Jul 2010, Russell King - ARM Linux wrote:

> On Fri, Jul 16, 2010 at 02:19:31PM -0400, Nicolas Pitre wrote:
> > For example, if I want CONFIG_MTD_CMDLINE_PARTS=y, the system may be 
> > smart enough to notice and automatically enable CONFIG_MTD and 
> > CONFIG_MTD_PARTITIONS without having to carry those in the defconfig.
> 
> How do you sort out something like this:
> 
> config FOO
> 	bool "Foo"
> 	depends on (A && B) || C

DOH.


Nicolas
