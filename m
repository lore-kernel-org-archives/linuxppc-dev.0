Return-Path: <rpjday@mindspring.com>
Received: from mailhost.rdmcorp.com (world.rdmcorp.com [204.225.180.10])
	by ozlabs.org (Postfix) with ESMTP id 534DB2BC0F
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 15 Oct 2004 18:23:52 +1000 (EST)
Date: Fri, 15 Oct 2004 04:16:47 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Tom Rini <trini@kernel.crashing.org>
In-Reply-To: <20041014221623.GD19791@smtp.west.cox.net>
Message-ID: <Pine.LNX.4.60.0410150412150.9222@localhost.localdomain>
References: <JPEALJAFNGDDLOPNDIEEIEEPCNAA.joakim.tjernlund@lumentis.se>
	<20041014221623.GD19791@smtp.west.cox.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Joakim Tjernlund <joakim.tjernlund@lumentis.se>,
	linuxppc-embedded@ozlabs.org
Subject: Re: Merge 8xx to Linus tree?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, 14 Oct 2004, Tom Rini wrote:

> On Thu, Oct 14, 2004 at 04:53:49PM +0200, Joakim Tjernlund wrote:
>
> > Is it not time to merge 8xx from linuxppc-2.5 into Linus tree?
> >
> > I know the 8xx is not fully functional yet but this isn't done
> > soon I think it won't happen at all. The 8xx arch can be made to
> > depend on BROKEN in Linus tree to make it clear that it isn't
> > working properly yet.
>
> I've been the hard-ass about holding back on moving 8xx forward.
> Once 2.6.9 finally comes out (assuming and hoping that Linus really
> intends to do a release and not -rc5), I'll start moving stuff over
> and make it depend on BROKEN hopefully in time for 2.6.10-rc1.

not like anyone here would care, but i'm pretty sure that it was my
carping and whining some time back on LKML that inspired someone to
add the extra options to the kernel config process regarding the
selections to pick only drivers expected to compile cleanly, etc.
this was based on my having, once too often, done a kernel compile and
having the compile fail because a selected driver was just plain
broken (from memory, it was a riscom driver that no one cared about
anymore).

see?  sometimes the squeaky wheel really does get the grease.  (or
maybe they did it just to shut me up.  hard to believe ...)

rday
