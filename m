Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C72E1689D3
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jan 2006 08:34:29 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Hanselmann <linux-kernel@hansmi.ch>
In-Reply-To: <20060111212056.GC6617@hansmi.ch>
References: <20051225212041.GA6094@hansmi.ch>
	<200512252304.32830.dtor_core@ameritech.net>
	<1135575997.14160.4.camel@localhost.localdomain>
	<d120d5000601111307x451db79aqf88725e7ecec79d2@mail.gmail.com>
	<20060111212056.GC6617@hansmi.ch>
Content-Type: text/plain
Date: Thu, 12 Jan 2006 08:34:17 +1100
Message-Id: <1137015258.5138.20.camel@localhost.localdomain>
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

On Wed, 2006-01-11 at 22:20 +0100, Michael Hanselmann wrote:
> On Wed, Jan 11, 2006 at 04:07:37PM -0500, Dmitry Torokhov wrote:
> > Ok, I am looking at the patch again, and I have a question - do we
> > really need these 3 module parameters? If the goal is to be compatible
> > with older keyboards then shouldn't we stick to one behavior?
> 
> The old keyboard was controlled by ADB (Apple Desktop Bus) commands sent
> by pbbuttonsd. That doesn't work for the USB keyboard because the
> conversion is not done in hardware like with the old ones. ioctl's would
> also be possible, but I'm not sure wether they would be easy to do for
> USB devices. Module parameters can be changed using sysfs.

Yeah, but the question is why 3 ? I think one (on/off) is enough. Do you
have any case where people actually change the other ones ?

Ben.
