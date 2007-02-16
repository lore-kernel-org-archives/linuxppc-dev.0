Return-Path: <stuart.yoder@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 1ED87DDD04
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Feb 2007 03:47:55 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l1GGlqs7005515
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 09:47:52 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l1GGlqJ9007435
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 10:47:52 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 15/16] Add device tree for Ebony
Date: Fri, 16 Feb 2007 09:47:51 -0700
Message-ID: <9696D7A991D0824DBA8DFAC74A9C5FA302A1BE96@az33exm25.fsl.freescale.net>
In-Reply-To: <OF87DD26C1.7685D06A-ONC1257284.00552F00-C1257284.00556891@de.ibm.com>
References: <1171575668.5644.42.camel@localhost.localdomain>
	<OF87DD26C1.7685D06A-ONC1257284.00552F00-C1257284.00556891@de.ibm.com>
From: "Yoder Stuart-B08248" <stuart.yoder@freescale.com>
To: "Hartmut Penner" <HPENNER@de.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Heiko J Schick <SCHICKHJ@de.ibm.com>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Harmut Pennter wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote on 15.02.2007
22:41:08:
>=20
> >=20
> > > Is there a DCR binding?  Are the dcr-* properties documented=20
> > > anywhere:
> > >=20
> > > dcr-reg         // what do these fields mean?
> > > dcr-parent      // in case there is more than one controller??
> > > dcr-controller
> > > dcr-access-method =3D "native"   // what are the other options?
> >=20
> > Yes, we wrote a binding document though I can't find it now. Hartmut
or
> > Heiko, do you have the latest DCR binding document at hand ?
>=20
> I found some draft. It is as you discribed here. I need to check, how
close this=20
> is to what we did at last. Also we need place were we can publish such
a document ...=20

Harmut,

I would suggest creating a text file and putting this in
Documentation/powerpc along with booting-without-of.txt and
mpc52xx-device-tree-bindings.txt.

That is the closest place we have to a centralized repository
at this point.  Hopefully, in the near future power.org will
provide a repository outside of the Linux kernel source.

Stuart
