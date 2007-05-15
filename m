Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id D0F70DDE27
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 19:52:36 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] pasemi: Electra CF driver
Date: Tue, 15 May 2007 11:52:23 +0200
References: <20070515044515.GA6731@lixom.net>
In-Reply-To: <20070515044515.GA6731@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200705151152.23940.arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>, Russell King <rmk+lkml@arm.linux.org.uk>,
	linux-pcmcia@lists.infradead.org, paulus@samba.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 15 May 2007, Olof Johansson wrote:
> Driver for the CompactFlash slot on the PA Semi Electra eval board. It's
> a simple device sitting on localbus, with interrupts and detect/voltage
> control over GPIO.

The driver looks really good, there is nothing for me to complain about.

> The driver is implemented as an of_platform driver, and adds localbus
> as a bus being probed by the of_platform framework.

I supposed "localbus" is what the current firmware ships with in the
device tree, right? If you still have the choice on how this is
represented it might be better not to invent another device-type
but rather make this "soc" or whatever existing type we know about.

	Arnd <><
