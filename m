Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id B02C1DEF38
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 23:43:17 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org,
 jwboyer@linux.vnet.ibm.com
Subject: Re: [PATCH] add a simple 405EP based board
Date: Thu, 21 Aug 2008 15:42:37 +0200
References: <200808211007.59965.super.firetwister@gmail.com>
	<1219319729.26429.40.camel@jdub.homelinux.org>
In-Reply-To: <1219319729.26429.40.camel@jdub.homelinux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200808211542.38395.arnd@arndb.de>
Cc: Markus Brunner <super.firetwister@googlemail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 21 August 2008, Josh Boyer wrote:
> On Thu, 2008-08-21 at 10:07 +0200, Markus Brunner wrote:
> > This adds support for a simple ppc405ep board.=20
> > At the moment, there are no 405ep boards in arch/powerpc, so this can b=
e used as a template
> > for new boards, or migrating them from arch/ppc.
> > I2c, UART and EMAC are working. PCI could not be tested, so it was not =
included in the dts.
>=20
> I plan on adding more 405 board support very soon. =A0When I do, it'll be
> along the lines of the patch series I just sent out for 44x. =A0There's
> really no reason to have a per CPU/board file if we can avoid it.
>=20

This may be a stupid question, but is there really a reason to keep 40x and=
 44x
setup files separate? AFAICT, the ppc_md structures are the same, so even y=
ou
can never have a common binary between 40x and 44x, you may have the same p=
latform
file.

	Arnd <><
