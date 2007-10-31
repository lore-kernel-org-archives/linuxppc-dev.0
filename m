Return-Path: <stuart.yoder@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3019FDDDF3
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Nov 2007 05:05:51 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l9VI5k75029085
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2007 11:05:46 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l9VI5kbx000776
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2007 13:05:46 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: RFC:  replace device_type with new "class" property?
Date: Wed, 31 Oct 2007 11:05:45 -0700
Message-ID: <9696D7A991D0824DBA8DFAC74A9C5FA3035F2B93@az33exm25.fsl.freescale.net>
In-Reply-To: <20071031170610.GA4444@loki.buserror.net>
References: <9696D7A991D0824DBA8DFAC74A9C5FA30359F9BB@az33exm25.fsl.freescale.net>
	<20071029212213.GA28073@lixom.net>
	<20071030005146.GF29263@localhost.localdomain>
	<9696D7A991D0824DBA8DFAC74A9C5FA3035F26EE@az33exm25.fsl.freescale.net>
	<20071030232730.GD2784@localhost.localdomain>
	<9696D7A991D0824DBA8DFAC74A9C5FA3035F2AC3@az33exm25.fsl.freescale.net>
	<20071031170610.GA4444@loki.buserror.net>
From: "Yoder Stuart-B08248" <stuart.yoder@freescale.com>
To: "Wood Scott-B07421" <scottwood@freescale.com>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=20

> -----Original Message-----
> From: Wood Scott-B07421=20
> Sent: Wednesday, October 31, 2007 12:06 PM
> To: Yoder Stuart-B08248
> Cc: David Gibson; Olof Johansson; linuxppc-dev@ozlabs.org
> Subject: Re: RFC: replace device_type with new "class" property?
>=20
> On Wed, Oct 31, 2007 at 08:31:02AM -0700, Yoder Stuart-B08248 wrote:
> > This works...but certainly is weaker with respect to
> > standardization.  My previous argument had the assumption
> > that something like "mac-address" in a network node was
> > _required_, and thus needed a class id of some sort to tie
> > the standardized node to.
>=20
> It is certainly not required -- the device could have an=20
> eeprom, or it might
> not be ethernet at all.

Fine, I picked a bad example. My point was that if a
property was _required_ that it should have a class id
of some sort that ties it back to the standard that
required it.

Stuart
