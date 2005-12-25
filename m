Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 09D8468914
	for <linuxppc-dev@ozlabs.org>; Sun, 25 Dec 2005 11:33:32 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pavel Machek <pavel@ucw.cz>
In-Reply-To: <20051224231928.GC2183@elf.ucw.cz>
References: <111520052143.16540.437A5680000BE8A60000409C220076369200009A9B9CD3040A029D0A05@comcast.net>
	<70210ED5-37CA-40BC-8293-FF1DAA3E8BD5@comcast.net>
	<20051129000615.GA20843@hansmi.ch> <20051130223917.GA15102@hansmi.ch>
	<20051130234653.GB15102@hansmi.ch>
	<1133533712.23129.25.camel@localhost.localdomain>
	<20051204224221.GA28218@hansmi.ch> <1135382385.4542.8.camel@gaston>
	<20051224201753.GA26801@elf.ucw.cz>
	<1135463271.5611.3.camel@localhost.localdomain>
	<20051224231928.GC2183@elf.ucw.cz>
Content-Type: text/plain
Date: Sun, 25 Dec 2005 11:33:20 +1100
Message-Id: <1135470801.6387.1.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	debian-powerpc@lists.debian.org, Parag Warudkar <kernel-stuff@comcast.net>
Subject: Re: PowerBook5,8 - TrackPad update
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> It should be doable once in gpm, all other apps can use gpm's repeater
> mode...
> 
> > When it's in raw mode for use by the synaptics X driver, if course, it's
> > expected that those things are to be done by that driver.
> 
> ...but you are right, doing it in /dev/input/mice emulation layer
> makes some sense. OTOH I thought we were moving away from
> /dev/input/mice... Its Dmitry's call I guess.

Heh, yes, it is. No hurry anyway, I finally got synaptics working
properly in X ...

Why would we move away from the mouse mux ? It's proven to be very
useful to me at least :)

Ben
