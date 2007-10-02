Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2B76BDDEFC
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Oct 2007 18:39:29 +1000 (EST)
Subject: Re: What's the preferred way to export board information to
	userspace ?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Laurent Pinchart <laurentp@cse-semaphore.com>
In-Reply-To: <200710021011.00224.laurentp@cse-semaphore.com>
References: <200710021011.00224.laurentp@cse-semaphore.com>
Content-Type: text/plain
Date: Tue, 02 Oct 2007 18:39:23 +1000
Message-Id: <1191314363.22572.9.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Tue, 2007-10-02 at 10:10 +0200, Laurent Pinchart wrote:
> Hi everybody,
> 
> it seems linuxppc-embedded is going away. I should have posted this here in 
> the first place, so sorry for the cross-post.
> 
> I need to export some read-only board-specific information (serial number, 
> boot mode jumper configuration, ...) that are collected from various locations 
> (CPLD, flash, U-Boot, ...) to userspace applications.
> 
> Could anyone advice me on the preferred way to do that ? I can easily add a 
> quick&dirty sysfs/procfs based implementation, but I was wondering if there 
> was some kind of clean and generic way.

Userspace can read /proc/device-tree no ? :-)

Appart from that, it's common to stick that sort of thing
in /proc/cpuinfo... /sys/firmware may be an option if you have shitloads
of stuff ..

Ben.
