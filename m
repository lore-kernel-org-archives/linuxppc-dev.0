Return-Path: <linux-kernel@hansmi.ch>
Received: from hansmi.home.forkbomb.ch (hansmi.home.forkbomb.ch
	[213.144.146.165])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "hansmi.home.forkbomb.ch",
	Issuer "hansmi.home.forkbomb.ch" (not verified))
	by ozlabs.org (Postfix) with ESMTP id A638B689C5
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jan 2006 08:38:10 +1100 (EST)
Date: Wed, 11 Jan 2006 22:38:05 +0100
From: Michael Hanselmann <linux-kernel@hansmi.ch>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20060111213805.GE6617@hansmi.ch>
References: <20051225212041.GA6094@hansmi.ch>
	<200512252304.32830.dtor_core@ameritech.net>
	<1135575997.14160.4.camel@localhost.localdomain>
	<d120d5000601111307x451db79aqf88725e7ecec79d2@mail.gmail.com>
	<20060111212056.GC6617@hansmi.ch>
	<1137015258.5138.20.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1137015258.5138.20.camel@localhost.localdomain>
Cc: linux-kernel@killerfox.forkbomb.ch, dtor_core@ameritech.net,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Vojtech Pavlik <vojtech@suse.cz>, linux-input@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH/RFC?] usb/input: Add support for fn key on Apple
	PowerBooks
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jan 12, 2006 at 08:34:17AM +1100, Benjamin Herrenschmidt wrote:
> Yeah, but the question is why 3 ? I think one (on/off) is enough. Do you
> have any case where people actually change the other ones ?

Johannes Berg told me he wants to use the fn key alone to switch the
keyboard layout or something. For such uses, the pb_enablefn is there.
pb_fkeyslast is to emulate the behaviour of KBDMode from pbbuttonsd.
The last one, pb_disablekeypad could left out. It doesn't add much code
and might be used by some people, too.

Greets,
Michael
