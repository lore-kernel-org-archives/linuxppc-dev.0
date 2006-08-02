Return-Path: <michael@ellerman.id.au>
Subject: Re: lockup during powersave on G3
From: Michael Ellerman <michael@ellerman.id.au>
To: marvin <marvin24@gmx.de>
In-Reply-To: <200608020747.50765.marvin24@gmx.de>
References: <200608020747.50765.marvin24@gmx.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-/ehbDQ62fcdw7TPLpWcN"
Date: Wed, 02 Aug 2006 19:21:20 +1000
Message-Id: <1154510480.26242.18.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-/ehbDQ62fcdw7TPLpWcN
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-08-02 at 07:47 +0200, marvin wrote:
> hi,
>=20
> since kernel 2.6.18-rc1 my b/w G3 mac locks up every time it goes into=20
> powersave mode. Before trying to bisect, is there a candidate I can try t=
o=20
> revert?

By "since" do you mean 2.6.18-rc1 worked and it's broken since then, or
that something earlier worked and it's broken starting from 2.6.18-rc1?

Ben's new irq stuff might be a candidate, that was a pretty big change.=20

cheers

--=20
Michael Ellerman
IBM OzLabs

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-/ehbDQ62fcdw7TPLpWcN
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBE0G6QdSjSd0sB4dIRAudbAKCc1OHWLk6MTYVkFkVlJK1OyYC0wACeNCjI
9pvduUdkk5pKnc6kmUzAKy4=
=ju/F
-----END PGP SIGNATURE-----

--=-/ehbDQ62fcdw7TPLpWcN--
