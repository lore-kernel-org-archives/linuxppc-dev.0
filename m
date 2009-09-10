Return-Path: <scottwood@freescale.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id E9E0EB6F1E
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 11 Sep 2009 02:32:49 +1000 (EST)
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6FE66DDD04
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Sep 2009 02:32:48 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n8AGWiOQ011935
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Sep 2009 09:32:44 -0700 (MST)
Received: from b07421-ec1.am.freescale.net (b07421-ec1.am.freescale.net
	[10.82.121.43])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n8AGYDeI020186
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Sep 2009 11:34:13 -0500 (CDT)
Date: Thu, 10 Sep 2009 11:32:44 -0500
From: Scott Wood <scottwood@freescale.com>
To: Isaac Gomez Morales <isaac.gomez.morales@gmail.com>
Subject: Re: Debian on MPC8572DS
Message-ID: <20090910163244.GA24878@b07421-ec1.am.freescale.net>
References: <38a5a2d10909100801x11049cddi1799c0ed6ee44410@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <38a5a2d10909100801x11049cddi1799c0ed6ee44410@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 10, 2009 at 05:01:53PM +0200, Isaac Gomez Morales wrote:
> Hello,
> 
> I'm trying to get a Linux distro such as Debian in the following system
> 
> System:
> mpc8572ds HW

The 8572 does not have classic PowerPC floating point.  The Debian
binaries use this, so they cannot run without emulation.

Emulation is slow, so you probably want something like this instead:
http://groups.google.com/group/linux.debian.ports.powerpc/browse_thread/thread/235607517fd7ae1e/f4638a2cdef09bf7?lnk=raot
http://download.breakpoint.cc/debian/linutronix-lenny-gnuspe/

-Scott
