Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id 94A69DDE48
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Apr 2007 03:03:58 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: SPI devices and OF
Date: Wed, 4 Apr 2007 19:03:46 +0200
References: <20070404110916.GA9910@localhost.localdomain>
	<acd2a5930704040451u55ae7619wfa1aaa84aebdf72@mail.gmail.com>
	<4850DC60-A560-4A38-8416-ADA776B69509@kernel.crashing.org>
In-Reply-To: <4850DC60-A560-4A38-8416-ADA776B69509@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200704041903.46629.arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 04 April 2007, Kumar Gala wrote:
> I don't think this is a good idea for SPI devices. =A0The effort vs =A0
> reward isn't worth it. =A0The simple fact that the 'chip select' =A0
> mechanism ends up being board specific is too much of a pain to =A0
> figure out how to deal with in the device tree. =A0I think its ok if we =
=A0
> put information about the controller in the tree, but trying to do =A0
> the devices as well at this point doesn't seem like its much of a win.
>=20

I'm not following your argumentation. If the chip select is board specific,
isn't the device tree for that board _exactly_ the place where that
information should be? Where else would you get it from?

	Arnd <><
