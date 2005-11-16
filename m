Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 28E0968757
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Nov 2005 08:02:02 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Wolfgang Pfeiffer <roto@gmx.net>
In-Reply-To: <20051116180925.GB3080@localhost>
References: <1130999620.4680.28.camel@gaston> <20051116180925.GB3080@localhost>
Content-Type: text/plain
Date: Thu, 17 Nov 2005 08:01:07 +1100
Message-Id: <1132174868.5646.112.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
Subject: Re: 2.6.14 USB vs. sleep issues
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2005-11-16 at 19:09 +0100, Wolfgang Pfeiffer wrote:
> On Thu, Nov 03, 2005 at 05:33:39PM +1100, Benjamin Herrenschmidt wrote:
> > For those who experience crashes on sleep and/or wakeup (typically due
> > to USB) with 2.6.14, I made a test patch that might help. [ ... ]
> 
> Ben, I just compiled and installed a 2.6.14.1 from kernel.org with
> none of your patches from this thread applied to it, and I have no
> sleep/wakeup probs with it so far: about 3 instances of sleep/wakeup
> until now, all of them successful.
> 
> Maybe I even made it a bit more complicated for the system, as I
> connected a USB HUB, with 4 ports, to the machine: It just seems to
> work ...

Only newer machines with a NEC USB2 chip that shares interrupts appear
to be affected by the problem.

Ben.
