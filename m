Return-Path: <linux-kernel@hansmi.ch>
Received: from hansmi.home.forkbomb.ch (hansmi.home.forkbomb.ch
	[213.144.146.165])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "hansmi.home.forkbomb.ch",
	Issuer "hansmi.home.forkbomb.ch" (not verified))
	by ozlabs.org (Postfix) with ESMTP id B24BE6896F
	for <linuxppc-dev@ozlabs.org>; Sun,  1 Jan 2006 14:03:36 +1100 (EST)
Date: Sun, 1 Jan 2006 04:03:31 +0100
From: Michael Hanselmann <linux-kernel@hansmi.ch>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20060101030331.GA26559@hansmi.ch>
References: <20051225212041.GA6094@hansmi.ch>
	<200512252304.32830.dtor_core@ameritech.net>
	<20051231235124.GA18506@hansmi.ch>
	<1136084207.4635.86.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1136084207.4635.86.camel@localhost.localdomain>
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

On Sun, Jan 01, 2006 at 01:56:47PM +1100, Benjamin Herrenschmidt wrote:
> I've been using the other patch for some time now and while it's a
> life-saver, it does have one annoying little issue: If you press a key
> with the Fn key down and release that key with the Fn key up, your key
> is stuck.

I noticed something like that with the numlock key as well but didn't
have time to fix it yet.

Other than that, have you found any keys that aren't mapped or are
mapped incorrectly?

The new patch adds quite some code to hid-input.c, should it be
configuratible via .config?

Thanks,
Michael
