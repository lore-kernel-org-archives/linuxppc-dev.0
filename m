Return-Path: <gaudenz@debian.org>
Received: from ping.pong.ch (ping.pong.ch [212.103.71.101])
	by ozlabs.org (Postfix) with ESMTP id 30E8ADE12D
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Mar 2008 07:54:31 +1100 (EST)
Date: Tue, 4 Mar 2008 21:21:00 +0100
From: Gaudenz Steinlin <gaudenz@debian.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] (testers ?) Fix sleep on some powerbooks
Message-ID: <20080304202100.GA5525@soziologie.ch>
References: <20080303062831.6BD8EDDED8@ozlabs.org>
	<20080304161518.GA4523@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080304161518.GA4523@localhost>
Cc: debian-powerpc@lists.debian.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Ben


On Tue, Mar 04, 2008 at 05:15:18PM +0100, Wolfgang Pfeiffer wrote:
> Hi Ben, Gaudenz - Hi All
> 
> On Mon, Mar 03 2008, at 17:27 +1100, Benjamin Herrenschmidt wrote:
> > The PMU backlight code would kick in during sleep/resume even on
> > machines that use a different backlight method. This appears to
> > break sleep on my PowerBook, though I can't test that patch at
> > the moment as the machine died while I was bisecting.
> > 
> > So if anybody around has one of those latest revision PowerPC
> > PowerBooks, the one just before they went to Intel, 
> 
> yes, I think so:
> 
> $ cat /proc/cpuinfo 
> processor       : 0
> cpu             : 7447A, altivec supported
> clock           : 1666.666000MHz
> revision        : 0.5 (pvr 8003 0105)
> bogomips        : 33.15
> timebase        : 8320000
> platform        : PowerMac
> machine         : PowerBook5,8
> motherboard     : PowerBook5,8 MacRISC3 Power Macintosh 
> detected as     : 287 (PowerBook G4 15")
> pmac flags      : 00000019
> L2 cache        : 512K unified
> pmac-generation : NewWorld
> 
> 
> > and have a
> > problem with suspend/resume, please test this and let me know
> > if it helps.
> 
> It helps. Thanks a lot .. :) ... 

For me it fixes the problem too. I have the same machine.

Gaudenz
-- 
Ever tried. Ever failed. No matter.
Try again. Fail again. Fail better.
~ Samuel Beckett ~
