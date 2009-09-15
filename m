Return-Path: <michael@ellerman.id.au>
Subject: Re: [RFC] powerpc/irq: Add generic API for setting up cascaded IRQs
From: Michael Ellerman <michael@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1253008958.8375.213.camel@pasglop>
References: <20090912054410.21847.63718.stgit@localhost.localdomain>
	<1252736925.8375.65.camel@pasglop>
	<fa686aa40909120705wdc8928ei75e9b8c952d1e45@mail.gmail.com>
	<1253008958.8375.213.camel@pasglop>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-C1or3xhht7cMvHphg6Zi"
Date: Tue, 15 Sep 2009 21:04:16 +1000
Message-Id: <1253012656.5795.39.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-C1or3xhht7cMvHphg6Zi
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2009-09-15 at 20:02 +1000, Benjamin Herrenschmidt wrote:
> > I'm a reverse polish kind of guy.  I preferring 'subject'_'action'
> > over 'action'_'subject' just because it groups like subjects together.
> >  But it doesn't matter much, especially in this case where 'subject'
> > is in a group of exactly 1.  :-)
> >=20
> > I'll do whichever you prefer.
>=20
> I just caught myself calling something relocs_check instead of
> check_relocs so I suppose it's fair game :-)

Yeah but that sounds stupid :)

> Whatever you want.

I want a pony. And setup_cascade() is definitely better IMHO.

cheers

--=-C1or3xhht7cMvHphg6Zi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkqvdKgACgkQdSjSd0sB4dIpQACeMNYUWgRJV8V2BHcpnLyT2Std
QdgAoMEcNxeEWUEceRlGroDHerEFCTCU
=GtMd
-----END PGP SIGNATURE-----

--=-C1or3xhht7cMvHphg6Zi--
