Date: Wed, 24 May 2000 16:57:33 +0200
From: Bernhard Reiter <bernhard@intevation.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Powerbook hard freeze summary (sort of)
Message-ID: <20000524165733.A12296@cheops.usf.Uni-Osnabrueck.DE>
References: <20000524161837.M6396@cheops.usf.Uni-Osnabrueck.DE> <20000524144958.10978@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
In-Reply-To: <20000524144958.10978@mailhost.mipsys.com>; from bh40@calva.net on Wed, May 24, 2000 at 04:49:58PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

Thanks for the answer.
How can we proceed to further debug this problem?

I have to admit that  am not very experienced with low level hardware=20
issues and apple hardware in general.
It seems that there is more than one person having these kind of problems.

	Bernhard

On Wed, May 24, 2000 at 04:49:58PM +0200, Benjamin Herrenschmidt wrote:
> On Wed, May 24, 2000, Bernhard Reiter <bernhard@intevation.de> wrote:
>=20
> >
> >It might as well be a design problem of the Powerbooks. Can any of the=
=20
> >hardware kernel hackers comments on the differences in architecture
> >for powerbooks and the other G3s? Maybe a linux driver is written sloppy
> >in this area not taking in account how the hardware actually works?
>=20
> The Lombard PowerBook uses the same architecture as the first generation
> iMacs (and this same memory controller is also used on the beige and B&W
> G3s at least). If there is a problem, it's either a memory controller
> problem (bogus revision ? incorrect setup ?), or a specific issue with
> the design of the memory connector/logic.
>=20
> The Pismo uses the same chipset as the new iMacs, G4s (sawtooth) and iBoo=
k.
>=20

--=20
Professional Service around Free Software                (intevation.net) =
=20
The FreeGIS Project				            (freegis.org)
Association for a Free Informational Infrastructure            (ffii.org)

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (SunOS)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjkr7dwACgkQh9ag3dpKERaTSgCfVzLpDBcpPDuo5tJqnRxBLNhO
Z3QAn2OKPcVf+P55JonPd9UaEVXn8UAE
=nao1
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
