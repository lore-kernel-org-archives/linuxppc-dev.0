Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 1ACFEDDFB6
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Aug 2008 17:57:48 +1000 (EST)
Date: Wed, 6 Aug 2008 17:57:42 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [RFC/PATCH 2/3] of: add of_lookup_stdout() utility function
Message-Id: <20080806175742.6bb26b8d.sfr@canb.auug.org.au>
In-Reply-To: <20080806174233.3da5daea.sfr@canb.auug.org.au>
References: <20080806055214.30717.86092.stgit@trillian.secretlab.ca>
	<20080806060239.30717.79273.stgit@trillian.secretlab.ca>
	<1218003249.7893.19.camel@localhost>
	<fa686aa40808052334m2946298aw453afce8b47e6bf7@mail.gmail.com>
	<20080806174233.3da5daea.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__6_Aug_2008_17_57_42_+1000_J3WOZP2QMjKcIVB0"
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, miltonm@bga.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__6_Aug_2008_17_57_42_+1000_J3WOZP2QMjKcIVB0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 6 Aug 2008 17:42:33 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> Could you also send an email to Dave Miller to see if he has any objectio=
ns
> to this function being generic (since the Sparc guys share this code).

So I should read ahead :-)

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__6_Aug_2008_17_57_42_+1000_J3WOZP2QMjKcIVB0
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkiZWXYACgkQjjKRsyhoI8zqtwCfbCsgtQS4tagYidQStmnoAyo2
Hl4AoIMVNhM2xGMIdtpzd4fWxzRwbx6E
=znNf
-----END PGP SIGNATURE-----

--Signature=_Wed__6_Aug_2008_17_57_42_+1000_J3WOZP2QMjKcIVB0--
