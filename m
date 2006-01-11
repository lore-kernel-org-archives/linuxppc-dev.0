Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2AB30689C7
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jan 2006 08:41:19 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Hanselmann <linux-kernel@hansmi.ch>
In-Reply-To: <20060111213805.GE6617@hansmi.ch>
References: <20051225212041.GA6094@hansmi.ch>
	<200512252304.32830.dtor_core@ameritech.net>
	<1135575997.14160.4.camel@localhost.localdomain>
	<d120d5000601111307x451db79aqf88725e7ecec79d2@mail.gmail.com>
	<20060111212056.GC6617@hansmi.ch>
	<1137015258.5138.20.camel@localhost.localdomain>
	<20060111213805.GE6617@hansmi.ch>
Content-Type: text/plain
Date: Thu, 12 Jan 2006 08:41:08 +1100
Message-Id: <1137015669.5138.22.camel@localhost.localdomain>
Mime-Version: 1.0
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

On Wed, 2006-01-11 at 22:38 +0100, Michael Hanselmann wrote:
> On Thu, Jan 12, 2006 at 08:34:17AM +1100, Benjamin Herrenschmidt wrote:
> > Yeah, but the question is why 3 ? I think one (on/off) is enough. Do you
> > have any case where people actually change the other ones ?
> 
> Johannes Berg told me he wants to use the fn key alone to switch the
> keyboard layout or something. For such uses, the pb_enablefn is there.

What does it do ? Just send a keycode ? That should be unconditionnal.
The Fn key should change a keycode always. I don't see why you would
that to be off.

> pb_fkeyslast is to emulate the behaviour of KBDMode from pbbuttonsd.
> The last one, pb_disablekeypad could left out. It doesn't add much code
> and might be used by some people, too.

The ony one we need is the one enabling/disabing the old behaviour.

Ben.
