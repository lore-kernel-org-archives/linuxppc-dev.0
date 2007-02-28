Return-Path: <stuart.yoder@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 332D7DDE9F
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Mar 2007 02:56:59 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l1SFutcl014149
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Feb 2007 08:56:56 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l1SFutd2004161
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Feb 2007 09:56:55 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [RFC] powerpc: Document new property called interrupt-parents
Date: Wed, 28 Feb 2007 08:56:55 -0700
Message-ID: <9696D7A991D0824DBA8DFAC74A9C5FA302AA071F@az33exm25.fsl.freescale.net>
In-Reply-To: <20070228005615.GE11775@localhost.localdomain>
References: <200702272254.l1RMsjt2030709@ld0164-tx32.am.freescale.net>
	<20070228005615.GE11775@localhost.localdomain>
From: "Yoder Stuart-B08248" <stuart.yoder@freescale.com>
To: "David Gibson" <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> -----Original Message-----
> From: David Gibson [mailto:david@gibson.dropbear.id.au]=20
> Sent: Tuesday, February 27, 2007 6:56 PM
> To: Yoder Stuart-B08248
> Cc: paulus@samba.org; linuxppc-dev@ozlabs.org
> Subject: Re: [RFC] powerpc: Document new property called=20
> interrupt-parents
>=20
> On Tue, Feb 27, 2007 at 04:54:45PM -0600, Stuart Yoder wrote:
> >=20
> > Document new property called interrupt-parents which can
> > be used to represent interrupts for devices that route
> > interrupts to more than one interrupt controller.
>=20
> Well, whatever Segher says, I'm still very concerned about the
> potential for extra difficulty in debugging with this approach.

The issue, as I understand it, is the potential for an old
kernel parser to silently misparse a new dev tree with this
new property.

Do the version and last_comp_version in the blob header
help here?

If new dev trees with this new property were encoded with a
version=3D0x17 and last_comp_version=3D0x17 would the old
kernel parser error out if it only supported up to 0x16?

I'm not sure or not if that is the intended use of those
fields, but I think parser/DTS compatibility issues could
be solved by some kind of versioning.

It's more of a general problem.

Stuart
