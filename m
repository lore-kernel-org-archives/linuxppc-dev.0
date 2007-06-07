Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net
	[151.189.21.41])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 432FEDDEE2
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Jun 2007 23:11:21 +1000 (EST)
In-Reply-To: <200706070044.35056.arnd@arndb.de>
References: <1181147873.5674.116.camel@rhino>
	<200706070044.35056.arnd@arndb.de>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <03cba9c332c7a7fc58208ef8eeed55c9@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Create add_rtc() function to enable the RTC CMOS driver
Date: Thu, 7 Jun 2007 15:11:15 +0200
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> +=A0=A0=A0=A0=A0=A0=A0np =3D of_find_compatible_node(NULL, NULL, =
"pnpPNP,b00");

> Doesn't this conflict with a potential isapnp driver for the same
> device? If you have multiple isapnp devices, it may be better
> to add a bus driver for the isapnp host, and use device drivers
> for that bus instead of platform devices.

"pnpPNP" devices are not ISA PNP devices; indeed, they
are exactly those legacy PC ISA devices that are not
ISA PNP.


Segher
