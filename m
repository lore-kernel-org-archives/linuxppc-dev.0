Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao07.cox.net (fed1rmmtao07.cox.net [68.230.241.32])
	by ozlabs.org (Postfix) with ESMTP id 48B2E67A67
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  3 Mar 2005 04:52:18 +1100 (EST)
Date: Wed, 2 Mar 2005 10:52:01 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Takeharu KATO <takeharu1219@ybb.ne.jp>
Message-ID: <20050302105201.C31614@cox.net>
References: <421CD2B3.4020805@ybb.ne.jp> <421CD669.1040002@ybb.ne.jp>
	<20050223142720.C13087@cox.net> <421D1085.5080602@ybb.ne.jp>
	<421D1375.5000904@ybb.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <421D1375.5000904@ybb.ne.jp>;
	from takeharu1219@ybb.ne.jp on Thu, Feb 24, 2005 at 08:36:21AM
	+0900
Cc: ppcembed <linuxppc-embedded@ozlabs.org>
Subject: Re: PowerPC4xx Watchdog
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Feb 24, 2005 at 08:36:21AM +0900, Takeharu KATO wrote:
> Hi
> 
> >> Are you looking for the old "ppc405 watchdog" driver that simply
> >> hooked into the generic PPC heartbeat facility? Or are you looking
> >> for a driver that utilizes the 4xx/booke hardware watchdog facility?
> >>
> > I am looking for a driver that utilizes the 4xx/booke hardware watchdog 
> > facility.
> > 
> > 
> FYI, I wrote a driver uses 4xx/booke hardware watchdog.
> BTW, is hooking PPC heartbeat facility obsoleted?

I see.  The ppc_md.heartbeat facility isn't going anywhere as there
are multiple users.  It's possible to take the "ppc405_wdt" driver
with a rename and minor cleanup have it be a generic timebase driven
watchdog driver that is compliant with the familiar WD interface.

What do you see as the advantage to having a watchdog driver
that uses the booke hardware watchdog facility over a generic
timebase driven driver?

-Matt
