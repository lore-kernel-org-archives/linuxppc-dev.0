Return-Path: <nico@fluxnic.net>
Received: from relais.videotron.ca (relais.videotron.ca [24.201.245.36])
	by ozlabs.org (Postfix) with ESMTP id 90663B6EE8
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 17 Jul 2010 04:31:59 +1000 (EST)
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
	(Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007;
	32bit))
	with ESMTP id <0L5N00AYJY4WRPA0@VL-MO-MR005.ip.videotron.ca> for
	linuxppc-dev@lists.ozlabs.org; Fri, 16 Jul 2010 14:31:44 -0400 (EDT)
Date: Fri, 16 Jul 2010 14:31:44 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC PATCH] Kconfig: Enable Kconfig fragments to be used for
	defconfig
In-reply-to: <AANLkTilY0rvbp7brGsnyuGhPjFvpVYInNWlAlf5tT4zG@mail.gmail.com>
Message-id: <alpine.LFD.2.00.1007161429121.10598@xanadu.home>
References: <20100713230352.6781.18644.stgit@angua>
	<1279296221.17878.66.camel@e102109-lin.cambridge.arm.com>
	<AANLkTinyFBTKYaryFANYheTuP-biJUws2x01NRNZPb4M@mail.gmail.com>
	<alpine.LFD.2.00.1007161406120.10598@xanadu.home>
	<AANLkTilY0rvbp7brGsnyuGhPjFvpVYInNWlAlf5tT4zG@mail.gmail.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Daniel Walker <dwalker@codeaurora.org>,
	linux-kbuild@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	=?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Russell King <rmk@arm.linux.org.uk>, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 16 Jul 2010, Grant Likely wrote:
> On Fri, Jul 16, 2010 at 12:19 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> > For example, if I want CONFIG_MTD_CMDLINE_PARTS=y, the system may be
> > smart enough to notice and automatically enable CONFIG_MTD and
> > CONFIG_MTD_PARTITIONS without having to carry those in the defconfig.
> 
> I fully agree.  However, the warnings make the system work now while
> we wait for a full solver to be implemented.

Why can't the tool just _select_ the option it is warning about when a 
dependency is not met?  That shouldn't require a full solver.


Nicolas
