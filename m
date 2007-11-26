Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 980BCDDF8C
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Nov 2007 03:07:11 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/3] [POWERPC] Add docs for Freescale 83xx SATA device
	tree nodes
Date: Mon, 26 Nov 2007 17:06:55 +0100
References: <Pine.LNX.4.64.0711202310280.24220@blarg.am.freescale.net>
	<200711252322.09370.arnd@arndb.de>
	<CAF0919C-0116-403C-A8C5-024B43480D77@kernel.crashing.org>
In-Reply-To: <CAF0919C-0116-403C-A8C5-024B43480D77@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200711261706.56376.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 26 November 2007, you wrote:
> On Nov 25, 2007, at 4:22 PM, Arnd Bergmann wrote:

> > Should this maybe also mandate a compatible property that is defined
> > in a way to match the generic (p)ata_of_platform driver?
>=20
> Is there something about the (p)ata_of_platform driver you think we =A0
> can use. =A0The SATA controller here is a unique piece of HW and =A0
> requires a unique driver so I'm not sure what we get from =A0
> (p)ata_of_platform.

All ata controllers I've dealt with so far are to some degree compatible
to the old PC style controllers. My point was that this should ideally
be reflected in the device tree so that you could in theory use the
ata_of_platform driver, even if you normally would prefer the new
driver for performance reasons.

If your controller doesn't have the legacy register set, this clearly
doesn't make any sense and you should not list it as compatible with
something generic.

	Arnd <><
