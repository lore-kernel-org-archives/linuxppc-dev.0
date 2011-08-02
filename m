Return-Path: <B04825@freescale.com>
Received: from VA3EHSOBE007.bigfish.com (va3ehsobe006.messaging.microsoft.com
	[216.32.180.16]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id ED6A0B70C7
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Aug 2011 11:57:50 +1000 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] drivers/misc: introduce Freescale Data Collection
	Manager driver
Date: Tue, 2 Aug 2011 01:57:45 +0000
Message-ID: <4E375998.1020901@freescale.com>
References: <1312235334-15036-1-git-send-email-timur@freescale.com>
	<20110801234645.GA15792@sirena.org.uk> <4E373D88.80006@freescale.com>
	<20110802015050.GA17286@opensource.wolfsonmicro.com>
In-Reply-To: <20110802015050.GA17286@opensource.wolfsonmicro.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"arnd@arndb.de" <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Mark Brown wrote:
> I'd expect that things like the _lowest, _highest and _average
> attributes which a number of drivers have are what you're looking for.

Yes, but then all I'm doing is presenting numbers that don't change to an=20
interface, simply on the basis that the numbers represent sensor values.

If I'm running a sensor application, I'm doing it to get real-time=20
monitoring of the sensors in my system.  The DCM on our boards is not=20
capable of real-time results.  So you're not actually "monitoring" the=20
hardware.  The data from the DCM is available only *after* you stop=20
running the background process.

> At the very least it seems obvious how you might extend the interface if
> some features you need are missing.  The subsystem has fairly extensive
> documentation in Documentation/hwmon.

I just don't see how it fits.  Yes, I could do it, but then I'd end up=20
with something that doesn't make any sense.  I would have to use a custom=20
interface to start monitoring and then another interface to stop it.  Then=
=20
I would query the results use the hwmon interface, but the results would=20
be static.  That just seems silly.

--=20
Timur Tabi
Linux kernel developer at Freescale=
