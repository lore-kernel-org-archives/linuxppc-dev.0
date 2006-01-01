Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 15E32688EE
	for <linuxppc-dev@ozlabs.org>; Sun,  1 Jan 2006 17:08:33 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Hanselmann <linux-kernel@hansmi.ch>
In-Reply-To: <20060101030331.GA26559@hansmi.ch>
References: <20051225212041.GA6094@hansmi.ch>
	<200512252304.32830.dtor_core@ameritech.net>
	<20051231235124.GA18506@hansmi.ch>
	<1136084207.4635.86.camel@localhost.localdomain>
	<20060101030331.GA26559@hansmi.ch>
Content-Type: text/plain
Date: Sun, 01 Jan 2006 17:09:02 +1100
Message-Id: <1136095742.24205.0.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linux-kernel@killerfox.forkbomb.ch,
	Dmitry Torokhov <dtor_core@ameritech.net>,
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

On Sun, 2006-01-01 at 04:03 +0100, Michael Hanselmann wrote:
> On Sun, Jan 01, 2006 at 01:56:47PM +1100, Benjamin Herrenschmidt wrote:
> > I've been using the other patch for some time now and while it's a
> > life-saver, it does have one annoying little issue: If you press a key
> > with the Fn key down and release that key with the Fn key up, your key
> > is stuck.
> 
> I noticed something like that with the numlock key as well but didn't
> have time to fix it yet.
> 
> Other than that, have you found any keys that aren't mapped or are
> mapped incorrectly?

I haven't but then I haven't tested in depth neither. Such little bugs
if any can always be fixed later anyway.

> The new patch adds quite some code to hid-input.c, should it be
> configuratible via .config?

Possibly yes, since it's only useful for mac laptops...

Ben.
