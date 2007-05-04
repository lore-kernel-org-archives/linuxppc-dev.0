Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 46A97DE004
	for <linuxppc-dev@ozlabs.org>; Fri,  4 May 2007 20:51:14 +1000 (EST)
Subject: Re: [PATCH] powerpc: dart iommu suspend
From: Johannes Berg <johannes@sipsolutions.net>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20070503142441.GA31110@lixom.net>
References: <17969.56735.644629.328360@cargo.ozlabs.ibm.com>
	<1178195106.13233.108.camel@johannes.berg>
	<1178195312.13233.111.camel@johannes.berg>
	<1178195447.6353.40.camel@localhost.localdomain>
	<1178196492.8233.1.camel@johannes.berg>
	<20070503142441.GA31110@lixom.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-SHo/5FCyBN5z6IPPttrn"
Date: Fri, 04 May 2007 12:51:42 +0200
Message-Id: <1178275903.7408.3.camel@johannes.berg>
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-SHo/5FCyBN5z6IPPttrn
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2007-05-03 at 09:24 -0500, Olof Johansson wrote:

> > Maybe somebody can offer opinions on other iommus?
>=20
> The PWRficient iommu

[...]

> I don't know what's happened to the IBM bloa^WPAPR platforms

[...]

Thanks for this analysis. I guess that we really want the save/restore
hooks there, and then it doesn't matter if the dart code right now
actually does the copy or if we manage to map it CI up front, we can fix
that later.

johannes


--=-SHo/5FCyBN5z6IPPttrn
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGOxA+/ETPhpq3jKURAtErAJ0TURiiCrX8AQ2jNPyT8LuwanF5lgCfczzT
r/C9aXz14jCUT5NlH9iLWNc=
=o4TM
-----END PGP SIGNATURE-----

--=-SHo/5FCyBN5z6IPPttrn--
