Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao12.cox.net (fed1rmmtao12.cox.net [68.230.241.27])
	by ozlabs.org (Postfix) with ESMTP id EC7282BC0F
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Oct 2004 04:39:30 +1000 (EST)
Date: Thu, 21 Oct 2004 11:39:24 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Mark Powell <medp@primagraphics.com>,
	linuxppc-embedded@ozlabs.org
Message-ID: <20041021113924.A28106@home.com>
References: <41777D14.7090108@primagraphics.com>
	<20041021175208.GC6234@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20041021175208.GC6234@gate.ebshome.net>;
	from ebs@ebshome.net on Thu, Oct 21, 2004 at 10:52:08AM -0700
Cc: 
Subject: Re: gdb on a 440GP ELDK
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Oct 21, 2004 at 10:52:08AM -0700, Eugene Surovegin wrote:
> On Thu, Oct 21, 2004 at 10:10:44AM +0100, Mark Powell wrote:
> > I hope this is not a dumb question.
> > I can't seem to use breakpoints in gdb (application debugging in 
> > userland not kernel debugging).
> > The system is a custom 440GP card, running the kernel from ELDK 3.0, 
> > modified for this card.
> 
> Which kernel is it (I have no idea what ELDK uses)?

It's the Denx 2_4_devel kernel tree.

-Matt
