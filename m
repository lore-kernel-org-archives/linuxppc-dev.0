Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E9815DDEB6
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Jun 2007 00:23:02 +1000 (EST)
Subject: Re: [PATCH] [POWERPC] Some extra via-pmu exports
From: Johannes Berg <johannes@sipsolutions.net>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200706061605.48983.arnd@arndb.de>
References: <20070521150531.e498340a.sfr@canb.auug.org.au>
	<200706061605.48983.arnd@arndb.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-k4EbGDMEWOPyRnFidAUc"
Date: Wed, 06 Jun 2007 16:23:01 +0200
Message-Id: <1181139781.3666.3.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-k4EbGDMEWOPyRnFidAUc
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-06-06 at 16:05 +0200, Arnd Bergmann wrote:
> On Monday 21 May 2007, Stephen Rothwell wrote:
> > pmu_battery_count, pmu_batteries, pmu_power_flags were only exported
> > for 32 bit builds but are now needed for 64 bit as well.
> >=20
> > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
>=20
> I haven't seen this one show up in 2.6.22-rc or powerpc.git yet,
> but I think we should have it in there to avoid build breakage.
>=20
> I stumbled over the same bug and wanted to submit a fix when
> I saw it was posted already.

Actually, I think that with the latest patch I sent that disallows you
to build APM-emulation for 64-bit (which doesn't make sense) this
shouldn't be a problem any more. Are tehre still some that need
exporting?

johannes

--=-k4EbGDMEWOPyRnFidAUc
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGZsNF/ETPhpq3jKURAkUTAKCxAXvmi3Wg9paKRp8M7+37w9bETwCgmcn/
pc1E2p6X8UcPyiiYcr6C2BI=
=IASt
-----END PGP SIGNATURE-----

--=-k4EbGDMEWOPyRnFidAUc--
