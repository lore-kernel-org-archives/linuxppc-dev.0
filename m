Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 50996DE176
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Aug 2008 17:42:52 +1000 (EST)
Date: Wed, 6 Aug 2008 17:42:33 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [RFC/PATCH 2/3] of: add of_lookup_stdout() utility function
Message-Id: <20080806174233.3da5daea.sfr@canb.auug.org.au>
In-Reply-To: <fa686aa40808052334m2946298aw453afce8b47e6bf7@mail.gmail.com>
References: <20080806055214.30717.86092.stgit@trillian.secretlab.ca>
	<20080806060239.30717.79273.stgit@trillian.secretlab.ca>
	<1218003249.7893.19.camel@localhost>
	<fa686aa40808052334m2946298aw453afce8b47e6bf7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__6_Aug_2008_17_42_33_+1000_iLgV_x16Y7oSsaKW"
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, miltonm@bga.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__6_Aug_2008_17_42_33_+1000_iLgV_x16Y7oSsaKW
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Grant,

On Wed, 6 Aug 2008 00:34:04 -0600 "Grant Likely" <grant.likely@secretlab.ca=
> wrote:
>
> On Wed, Aug 6, 2008 at 12:14 AM, Michael Ellerman
> <michael@ellerman.id.au> wrote:
> > On Wed, 2008-08-06 at 00:02 -0600, Grant Likely wrote:
> >> From: Grant Likely <grant.likely@secretlab.ca>
> >>
> >> of_lookup_stdout() is useful for figuring out what device to use as ou=
tput
> >> for early boot progress messages.  It returns the node pointed to by t=
he
> >> linux,stdout-path property in the chosen node.
> >
> > Nice. You don't feel like converting all the places that currently do it
> > by hand to use this do you :)
>=20
> Yep, I'll do this.  :-)

Could you also send an email to Dave Miller to see if he has any objections
to this function being generic (since the Sparc guys share this code).

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__6_Aug_2008_17_42_33_+1000_iLgV_x16Y7oSsaKW
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkiZVekACgkQjjKRsyhoI8wOHgCfT+et2gvXb4aVEJEuSvny6LEB
+voAn0+HcjO2tXiSGPN0j25shZVJ3dh5
=+G5V
-----END PGP SIGNATURE-----

--Signature=_Wed__6_Aug_2008_17_42_33_+1000_iLgV_x16Y7oSsaKW--
