Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C855DDDE2F
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Feb 2008 10:26:43 +1100 (EST)
Subject: Re: [PATCH 1/2] firewire: endianess fix
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jarod Wilson <jwilson@redhat.com>
In-Reply-To: <200802281342.06493.jwilson@redhat.com>
References: <20080220220326.GA22328@uranus.ravnborg.org>
	<200802272221.38985.jwilson@redhat.com>
	<1204179959.15052.372.camel@pasglop>
	<200802281342.06493.jwilson@redhat.com>
Content-Type: text/plain
Date: Fri, 29 Feb 2008 10:26:02 +1100
Message-Id: <1204241162.15052.393.camel@pasglop>
Mime-Version: 1.0
Cc: Kristian Hoegsberg <krh@bitplanet.net>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Stefan Richter <stefanr@s5r6.in-berlin.de>,
	sparclinux@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
	Sam Ravnborg <sam@ravnborg.org>,
	Harvey Harrison <harvey.harrison@gmail.com>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Thu, 2008-02-28 at 13:42 -0500, Jarod Wilson wrote:
> On Thursday 28 February 2008 01:25:59 am Benjamin Herrenschmidt wrote:
> > > Under Mac OS X, system.log says "FireWire (OHCI) Apple ID 31 built-in now
> > > active". Could still be lucent though, judging by the subsys device ID of
> > > 5811, which matches up w/the Lucent/Agere FW323. But no, apparently I
> > > don't have the interesting one.
> >
> > Well, it's interesting in the sense that it's a "normal" OHCI then on a
> > BE machine :-) My Pismo, which had the weirdo one, unfortunately died a
> > while ago. I'll see if I can find another machine with that one in.
> 
> Ah, the pismo has it, eh? I think I may actually know of someone in the office 
> that still has one of those that I might be able to borrow and poke at...

I -think- it has it... Pismo definitely has one of the first variant of
UniNorth with "working" FW afaik.

The first UniNorth was used in the first "toilet-seat" ibook, but I
think this one didn't have firewire, or a non-working one... and in the
first Sawtooth G4 for which FW and Ethernet even were separate PCI chips
because the ones in UniNorth were too broken.

It's possible that early G4 titanium powerbooks or other model of FW
iBooks have that UniNorth FW variant too.

Ben.
