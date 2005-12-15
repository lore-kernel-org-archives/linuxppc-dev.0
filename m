Return-Path: <linux-kernel@hansmi.ch>
Received: from hansmi.home.forkbomb.ch (hansmi.home.forkbomb.ch
	[213.144.146.165])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "hansmi.home.forkbomb.ch",
	Issuer "hansmi.home.forkbomb.ch" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 84AE068884
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Dec 2005 08:26:40 +1100 (EST)
Date: Thu, 15 Dec 2005 22:26:35 +0100
From: Michael Hanselmann <linux-kernel@hansmi.ch>
To: Olof Johansson <olof@lixom.net>
Message-ID: <20051215212635.GA6195@hansmi.ch>
References: <20051213223659.GB20017@hansmi.ch>
	<1134568620.3875.6.camel@localhost>
	<20051214213923.GB17548@hansmi.ch>
	<d120d5000512141404wc86331fo124ebd29b713b07e@mail.gmail.com>
	<20051214233108.GA20127@hansmi.ch>
	<20051215195017.GA7195@pb15.lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20051215195017.GA7195@pb15.lixom.net>
Cc: linux-input@atrey.karlin.mff.cuni.cz, linuxppc-dev@ozlabs.org,
	dtor_core@ameritech.net, linux-kernel@vger.kernel.org,
	kernel-stuff@comcast.net
Subject: Re: [PATCH 2.6 1/2] usb/input: Add relayfs support to appletouch
	driver
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Dec 15, 2005 at 11:50:17AM -0800, Olof Johansson wrote:
> I think I agree with previous comments regarding debug code in the driver:
> It's unlikely to ever be used by more than a couple of people at very
> rare occasions (new hardware releases), and the barrier to using it is
> still high; new users need to learn how to parse the data anyway. I don't
> see a reason to include this in mainline.

Okay, based on your comments, please drop that patch. How about the one
to support the Geyser 2 device? Should I do a rediff without relayfs
support?

Greets,
Michael
