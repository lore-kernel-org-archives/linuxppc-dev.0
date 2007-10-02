Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id 8B39EDDF09
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Oct 2007 19:02:40 +1000 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: benh@kernel.crashing.org
Subject: Re: What's the preferred way to export board information to userspace
	?
Date: Tue, 2 Oct 2007 11:02:34 +0200
References: <200710021011.00224.laurentp@cse-semaphore.com>
	<1191314363.22572.9.camel@pasglop>
In-Reply-To: <1191314363.22572.9.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200710021102.34448.laurentp@cse-semaphore.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Ben,

On Tuesday 02 October 2007 10:39, Benjamin Herrenschmidt wrote:
> On Tue, 2007-10-02 at 10:10 +0200, Laurent Pinchart wrote:
> > Hi everybody,
> >
> > it seems linuxppc-embedded is going away. I should have posted this here
> > in the first place, so sorry for the cross-post.
> >
> > I need to export some read-only board-specific information (serial
> > number, boot mode jumper configuration, ...) that are collected from
> > various locations (CPLD, flash, U-Boot, ...) to userspace applications.
> >
> > Could anyone advice me on the preferred way to do that ? I can easily a=
dd
> > a quick&dirty sysfs/procfs based implementation, but I was wondering if
> > there was some kind of clean and generic way.
>
> Userspace can read /proc/device-tree no ? :-)

Except I'm still using ARCH=3Dppc. I know I shouldn't :-) The MPC8272 isn't=
 well=20
supported in ARCH=3Dpowerpc. Scott Wood submitted some patches I need befor=
e=20
switching.

> Appart from that, it's common to stick that sort of thing
> in /proc/cpuinfo... /sys/firmware may be an option if you have shitloads
> of stuff ..

It's not really CPU information, but I guess I can stick that in there.

Best regards,

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chauss=C3=A9e de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75
