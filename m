Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao03.cox.net (fed1rmmtao03.cox.net [68.230.241.36])
	by ozlabs.org (Postfix) with ESMTP id 1C063686D1
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  9 Nov 2005 08:02:05 +1100 (EST)
Date: Tue, 8 Nov 2005 14:02:04 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Wolfgang Denk <wd@denx.de>
Message-ID: <20051108210204.GP3839@smtp.west.cox.net>
References: <20051108175658.GO3839@smtp.west.cox.net>
	<20051108205259.A2870352B33@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20051108205259.A2870352B33@atlas.denx.de>
Cc: David Jander <david.jander@protonic.nl>, linuxppc-embedded@ozlabs.org
Subject: Re: fix swapping on 8xx?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Nov 08, 2005 at 09:52:59PM +0100, Wolfgang Denk wrote:
> In message <20051108175658.GO3839@smtp.west.cox.net> you wrote:
> >
> > > Well, at least it sounds ugly together, but it is also at least conceiveable. 
> > > There seem to be people who use PCMCIA for an IDE interface, so swapping may 
> > > become desireable in some cases.
> > 
> > I think Dan might be in the camp that says a properly designed embedded
> > system won't need to swap.  And when I hear about how people do try and
> > swap on systems like this, I really start agreeing.  Maybe we could make
> > 8xx just select SWAP=n? :)
> 
> No! David is right. There are systems out in the field  running  with
> IDE  harddisks attached (either through custom hardware interfaces or
> through standard PCMCIA adapters), and some of  these  actually  need
> and use swap space.
> 
> Please do not remove stuff that is needed and used to work (in 2.4).

Note the bug in question exists in 2.4, and I think really even 2.2.

-- 
Tom Rini
http://gate.crashing.org/~trini/
