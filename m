Return-Path: <stuart.yoder@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D1E13DDF01
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 00:36:40 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l6AEaYkw024562
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 07:36:35 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l6AEaYWo025073
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 09:36:34 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH v2][POWERPC] document ipic level/sense info
Date: Tue, 10 Jul 2007 07:36:33 -0700
Message-ID: <9696D7A991D0824DBA8DFAC74A9C5FA3030162AA@az33exm25.fsl.freescale.net>
In-Reply-To: <A9B90D06-77BD-49B5-8D2D-300641A973BC@kernel.crashing.org>
References: <200707092235.l69MZRnh015324@ld0164-tx32.am.freescale.net>
	<fa686aa40707091548h5182d6d0r900afc1f35d4f80f@mail.gmail.com>
	<A9B90D06-77BD-49B5-8D2D-300641A973BC@kernel.crashing.org>
From: "Yoder Stuart-B08248" <stuart.yoder@freescale.com>
To: "Segher Boessenkool" <segher@kernel.crashing.org>,
	"Grant Likely" <grant.likely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
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
> From: Segher Boessenkool [mailto:segher@kernel.crashing.org]=20
> Sent: Tuesday, July 10, 2007 8:21 AM
> To: Grant Likely
> Cc: Yoder Stuart-B08248; linuxppc-dev@ozlabs.org; paulus@samba.org
> Subject: Re: [PATCH v2][POWERPC] document ipic level/sense info
>=20
> >> +Sense and level information follows the Linux convention
> >> +(specified in include/linux/interrupt.h) and should be encoded
> >> +as follows:
> >> +
> >> +       2 =3D  high to low edge sensitive type enabled
> >> +       8 =3D  active low level sensitive type enabled
>=20
> > ... but it is probably worthwhile commentting that sense types 1 & 4
> > are not supported; just to fill in the obvious gaps.  :-)
>=20
> Same for sense types 0, 3, 5, 6, ...
>=20
> Just name the sense types 0 and 1, similar to what all other
> OF interrupt controller bindings do.

Actually, all I am trying to do with this patch is document the
current state of things.  The 2/8 sense type usage has been that
way for a long time, and I'll defer to the 83xx maintainers
if they see any value in changing it.

Right now there are many DTS files with level/sense set to values
like 8 and no indication anywhere where those values came from.

Stuart
