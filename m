Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao07.cox.net (fed1rmmtao07.cox.net [68.230.241.32])
	by ozlabs.org (Postfix) with ESMTP id 1F92F2BD6A
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  5 Oct 2004 02:43:39 +1000 (EST)
Date: Mon, 4 Oct 2004 09:43:38 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Marius Groeger <mgroeger@sysgo.com>
Message-ID: <20041004094338.E11487@home.com>
References: <Pine.LNX.4.60.0410041110320.13645@dell.enoriver.com>
	<20041004084858.B11487@home.com>
	<Pine.LNX.4.61.0410041809210.11176@mag.sysgo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.61.0410041809210.11176@mag.sysgo.com>;
	from mgroeger@sysgo.com on Mon, Oct 04, 2004 at 06:11:05PM +0200
Cc: Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: Re: what is the protocol for getting patches into the tree?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, Oct 04, 2004 at 06:11:05PM +0200, Marius Groeger wrote:
> On Mon, 4 Oct 2004, Matt Porter wrote:
> 
> > Yes, submit it over and over until there is some feedback. argue
> > or follow the feedback...eventually it will go in unless it's not
> > a desirable change. If no feedback, keep submitting until the
> > maintainer has time to look at it.
> 
> Well, how about asking Russel to hand out the scripts for
> 
>    http://www.arm.linux.org.uk/developer/patches/
> 
> Would this help?

No, it just provides a web-based interface to what is handled
via mailing lists. It's just as easy for a maintainer to get
busy and not ack a patch submission on a web-based system as well.

I suspect that this is an 8xx-specific problem. The source of
the problem is that 8xx has been undermaintained for some time
and it only recently has gained a new maintainer.

-Matt
