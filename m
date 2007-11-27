Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id A726ADDE1E
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Nov 2007 08:33:36 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2/3] [libata] pata_of_platform: OF-Platform PATA device
	driver
Date: Tue, 27 Nov 2007 22:32:58 +0100
References: <20071127153708.GA12490@localhost.localdomain>
	<20071127153908.GB14183@localhost.localdomain>
	<20071127212222.GB10829@lixom.net>
In-Reply-To: <20071127212222.GB10829@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200711272233.00456.arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>, linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 27 November 2007, Olof Johansson wrote:
> On Tue, Nov 27, 2007 at 06:39:08PM +0300, Anton Vorontsov wrote:
> > This driver nicely wraps around pata_platform library functions,
> > and provides OF platform bus bindings to the PATA devices.
>=20
> > +static struct of_device_id pata_of_platform_match[] =3D {
> > +=A0=A0=A0=A0=A0{ .compatible =3D "pata-platform", },
> > +};
>=20
> "pata-platform" really means nothing outside of linux. A more
> generic label would be useful.

Maybe the name of the standards it supports? Could be
"ata-4", "ata-5" and the like, or the exact transfer mode, like
"pata-udma-5", "pata-pio-3", "sata-150", etc.

	Arnd <><
