Date: Thu, 12 Apr 2001 16:26:40 -0800
From: Ethan Benson <erbenson@alaska.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: boot params
Message-ID: <20010412162639.K2127@plato.local.lan>
References: <3AD60DB2.559B12F8@denise.shiny.it>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0FAxone1iWZ10Obo"
In-Reply-To: <3AD60DB2.559B12F8@denise.shiny.it>; from pochini@denise.shiny.it on Thu, Apr 12, 2001 at 10:18:58PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--0FAxone1iWZ10Obo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 12, 2001 at 10:18:58PM +0200, Giuliano Pochini wrote:
>=20
> I'm trying to make the new aic7xxx driver work on my blue G3 and I
> need to pass boot parameters to the kernel. I'm using yaboot. How
> can I do ? Am I the only one who has problems with the new driver ?

in your image=3D section:

	append=3D"whatever"

and rerun ybin. =20

which new driver are you referring to?  in 2.4?  i have never had to
do anything special to get this driver working on my blue g3 with a
2930. =20

--=20
Ethan Benson
http://www.alaska.net/~erbenson/

--0FAxone1iWZ10Obo
Content-Type: application/pgp-signature
Content-Disposition: inline


--0FAxone1iWZ10Obo--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
