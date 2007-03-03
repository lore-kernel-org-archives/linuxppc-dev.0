Return-Path: <domen.puncer@telargo.com>
Received: from kukmak.uni-mb.si (kukmak.uni-mb.si [164.8.100.3])
	by ozlabs.org (Postfix) with ESMTP id 89364DDF81
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  3 Mar 2007 18:42:34 +1100 (EST)
Date: Sat, 3 Mar 2007 08:15:46 +0100
From: Domen Puncer <domen.puncer@telargo.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 7/7] lite5200b suspend: low-power mode
Message-ID: <20070303071546.GB3276@nd47.coderock.org>
References: <20070301075323.GP4397@moe.telargo.com>
	<20070301080008.GH17184@moe.telargo.com>
	<20070302185702.GA2719@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070302185702.GA2719@ld0162-tx32.am.freescale.net>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 02/03/07 12:57 -0600, Scott Wood wrote:
> On Thu, Mar 01, 2007 at 09:00:08AM +0100, Domen Puncer wrote:
> > +static int lite5200_pm_enter(suspend_state_t state)
> > +{
> [snip]
> > +	mbar = ioremap_nocache(0xf0000000, 0x8000);
> 
> You can't do ioremap with interrupts disabled (it will fail with spinlock
> debugging enabled); the mapping should be set up at boot time.

>From what I see, it could also be set up in prepare(), no?
I'll try that with spinlock debugging on monday.

Thanks!


	Domen
> 
> -Scott
