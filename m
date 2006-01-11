Return-Path: <linux-kernel@hansmi.ch>
Received: from hansmi.home.forkbomb.ch (hansmi.home.forkbomb.ch
	[213.144.146.165])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "hansmi.home.forkbomb.ch",
	Issuer "hansmi.home.forkbomb.ch" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 7CA36689E1
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jan 2006 08:50:12 +1100 (EST)
Date: Wed, 11 Jan 2006 22:50:07 +0100
From: Michael Hanselmann <linux-kernel@hansmi.ch>
To: Vojtech Pavlik <vojtech@suse.cz>
Message-ID: <20060111215007.GH6617@hansmi.ch>
References: <20051225212041.GA6094@hansmi.ch>
	<200512252304.32830.dtor_core@ameritech.net>
	<1135575997.14160.4.camel@localhost.localdomain>
	<d120d5000601111307x451db79aqf88725e7ecec79d2@mail.gmail.com>
	<20060111212056.GC6617@hansmi.ch>
	<1137015258.5138.20.camel@localhost.localdomain>
	<20060111213805.GE6617@hansmi.ch>
	<1137015669.5138.22.camel@localhost.localdomain>
	<20060111214351.GF6617@hansmi.ch>
	<20060111214732.GA12014@midnight.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060111214732.GA12014@midnight.suse.cz>
Cc: linux-kernel@killerfox.forkbomb.ch, dtor_core@ameritech.net,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	linux-input@atrey.karlin.mff.cuni.cz
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

On Wed, Jan 11, 2006 at 10:47:32PM +0100, Vojtech Pavlik wrote:
> > No, if that parameter is disabled, it translates key combinations like
> > Fn+F1 to KEY_BRIGHTNESSUP. If it's enabled, it only sends KEY_FN.

> I believe a better behavior would be to send KEY_FN and then
> KEY_BRIGHTNESSUP when enabled and KEY_FN and KEY_F1 when disabled.

That's done. It sends KEY_FN as any other key. If a key is pressed while
the fn key is pressed, it uses the table to look up the new code.
Releasing is also done with the corresponding keycodes.

Greets,
Michael
