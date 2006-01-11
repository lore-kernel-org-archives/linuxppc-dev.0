Return-Path: <linux-kernel@hansmi.ch>
Received: from hansmi.home.forkbomb.ch (hansmi.home.forkbomb.ch
	[213.144.146.165])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "hansmi.home.forkbomb.ch",
	Issuer "hansmi.home.forkbomb.ch" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 5AA7D681B4
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jan 2006 08:21:11 +1100 (EST)
Date: Wed, 11 Jan 2006 22:20:56 +0100
From: Michael Hanselmann <linux-kernel@hansmi.ch>
To: dtor_core@ameritech.net
Message-ID: <20060111212056.GC6617@hansmi.ch>
References: <20051225212041.GA6094@hansmi.ch>
	<200512252304.32830.dtor_core@ameritech.net>
	<1135575997.14160.4.camel@localhost.localdomain>
	<d120d5000601111307x451db79aqf88725e7ecec79d2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <d120d5000601111307x451db79aqf88725e7ecec79d2@mail.gmail.com>
Cc: linux-kernel@killerfox.forkbomb.ch, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Vojtech Pavlik <vojtech@suse.cz>,
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

On Wed, Jan 11, 2006 at 04:07:37PM -0500, Dmitry Torokhov wrote:
> Ok, I am looking at the patch again, and I have a question - do we
> really need these 3 module parameters? If the goal is to be compatible
> with older keyboards then shouldn't we stick to one behavior?

The old keyboard was controlled by ADB (Apple Desktop Bus) commands sent
by pbbuttonsd. That doesn't work for the USB keyboard because the
conversion is not done in hardware like with the old ones. ioctl's would
also be possible, but I'm not sure wether they would be easy to do for
USB devices. Module parameters can be changed using sysfs.

Greets,
Michael
