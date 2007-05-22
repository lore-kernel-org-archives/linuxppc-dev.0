Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7909BDDE29
	for <linuxppc-dev@ozlabs.org>; Tue, 22 May 2007 19:23:10 +1000 (EST)
Subject: Re: [PATCH 07/13] Implement arch disable/enable irq hooks.
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1179825335.32247.829.camel@localhost.localdomain>
References: <20070507182950.GF26920@ld0162-tx32.am.freescale.net>
	<1179762902.9122.19.camel@johannes.berg>
	<1179818066.32247.812.camel@localhost.localdomain>
	<1179824589.3673.1.camel@johannes.berg>
	<1179825335.32247.829.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-b+3BWjVrB0EWFvr9DJ46"
Date: Tue, 22 May 2007 11:24:17 +0200
Message-Id: <1179825857.5004.1.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-b+3BWjVrB0EWFvr9DJ46
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2007-05-22 at 19:15 +1000, Benjamin Herrenschmidt wrote:

> Global version calls into the ppc_md hooks and possibly provide a
> useable default if no hook is there (Scott's implementation looks like a
> reasonably good default).

Yes, I agree, for powermac for the pfuncs I'll need to override it but I
doubt Guennadi will for example need to change it for his stuff.

johannes

--=-b+3BWjVrB0EWFvr9DJ46
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGUrbB/ETPhpq3jKURAkRyAJ9k6IJna2S9z7ij0r5CvubSRgKmBgCfZtKC
M/Vo0rqWb+k4gzqanYTnSkI=
=SWh5
-----END PGP SIGNATURE-----

--=-b+3BWjVrB0EWFvr9DJ46--
