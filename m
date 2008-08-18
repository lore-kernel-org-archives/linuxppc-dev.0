Return-Path: <michael@ellerman.id.au>
Subject: Re: bug in lmb_enforce_memory_limit()
From: Michael Ellerman <michael@ellerman.id.au>
To: David Miller <davem@davemloft.net>
In-Reply-To: <20080815.195724.238982506.davem@davemloft.net>
References: <1218713213.10673.17.camel@localhost>
	<20080815.152501.193746275.davem@davemloft.net>
	<1218847582.7576.6.camel@localhost>
	<20080815.195724.238982506.davem@davemloft.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-c79z47Sp4XdFXzhOzGt9"
Date: Mon, 18 Aug 2008 12:00:32 +1000
Message-Id: <1219024832.8115.4.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-c79z47Sp4XdFXzhOzGt9
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2008-08-15 at 19:57 -0700, David Miller wrote:
> From: Michael Ellerman <michael@ellerman.id.au>
> Date: Sat, 16 Aug 2008 10:46:22 +1000
>=20
> > On Fri, 2008-08-15 at 15:25 -0700, David Miller wrote:
> > > Sounds great.  Mind if I push the following to Linus?
> >=20
> > Looks good to me.
> >=20
> > I'll test it on Monday. I don't know if I have a system with memory
> > holes to test on, but I take it you do?

Works for me.

Although I can't find a system with holes (the newer hypervisors make
things look contiguous I think), so I can't really test the interesting
case.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-c79z47Sp4XdFXzhOzGt9
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBIqNfAdSjSd0sB4dIRAuLoAKDGkcAyDoQIvDQDulY9hVlH7ijvRACfSdG7
AhnupINivEMKKWB9nEwUTrs=
=r4o0
-----END PGP SIGNATURE-----

--=-c79z47Sp4XdFXzhOzGt9--
