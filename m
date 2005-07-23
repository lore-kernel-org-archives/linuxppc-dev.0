Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao12.cox.net (fed1rmmtao12.cox.net [68.230.241.27])
	by ozlabs.org (Postfix) with ESMTP id 9658867D81
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 24 Jul 2005 00:38:27 +1000 (EST)
Date: Sat, 23 Jul 2005 07:38:24 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Josh Boyer <jwboyer@jdub.homelinux.org>
Message-ID: <20050723073824.B5431@cox.net>
References: <42E0C0BE.6010807@gmx.de> <200507221202.33820.g.jaeger@sysgo.com>
	<1122031045.20742.0.camel@yoda.jdub.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1122031045.20742.0.camel@yoda.jdub.homelinux.org>;
	from jwboyer@jdub.homelinux.org on Fri, Jul 22, 2005 at
	06:17:25AM -0500
Cc: Frank Lautenbach <frank.lautenbach@gmx.de>, linuxppc-embedded@ozlabs.org
Subject: Re: AMCC 440EP (Bamboo board) support?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Jul 22, 2005 at 06:17:25AM -0500, Josh Boyer wrote:
> On Fri, 2005-07-22 at 12:02 +0200, Gerhard Jaeger wrote:
> > On Friday 22 July 2005 11:47, Frank Lautenbach wrote:
> > > Did anyone bring up linux already on this kind of board? If yes, please 
> > > let me know. If not, any hints how to start from scratch
> > > starting with a kernel tree are higly welcome!
> > > 
> > > Regards,
> > >     Frank
> > 
> > Yes, works for me here - Kernel 2.6.12 + Wade Farnsworth patches.
> > and our own toolchain (see my sig ;)
> 
> Speaking of which...  when will those patches go upstream?  Wade?

I've only been waiting on updated patches that use the fpu.S code.
If you'll recall, that was the major hold-up when they were posted
before. I talked to Wade recently and he was busy with some other
things but is planning on posting an update...at which point it
will go upstream.

-Matt
