Date: Sun, 3 Sep 2000 22:59:22 +0200
From: Bernhard Reiter <bernhard@intevation.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: pppd modem problem (2.4.0-test7 lombard)
Message-ID: <20000903225922.B6803@cheops.usf.Uni-Osnabrueck.DE>
References: <20000902121218.B16589@cheops.usf.Uni-Osnabrueck.DE> <39B0D6D7.DE13ABA9@pop.agri.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PmA2V3Z32TCmWXqI"
In-Reply-To: <39B0D6D7.DE13ABA9@pop.agri.ch>; from toa@pop.agri.ch on Sat, Sep 02, 2000 at 12:30:47PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--PmA2V3Z32TCmWXqI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

(Just again for the mailinglist:)

The new pppd worked.
Thanks again,
	Bernhard

On Sat, Sep 02, 2000 at 12:30:47PM +0200, Andreas Tobler wrote:
> Bernhard Reiter wrote:
>=20
> > I am using pppd 2.3.10 and
>=20
> [snip]=20
>=20
> > I also have the problem that after that sometimes, the ttS0 port cannot
> > be opened anymore.
> >=20
> > Am I missing something obvious here?
>=20
> May an update to pppd-2.4.0 would be an idea. I run here almost the lates=
t dev
> kernels on my wallstreet and I have no problems using pppd with ttyS0.
>=20
> The pkg you'll find here: ftp://linuxcare.com.au/pub/ppp/
> It is a tar.gz, if you prefer an rpm then I attach the spec file. With th=
is spec
> file and the source you can build your own rpm with rpm -ba file.spec (-ba
> stands for binary, all. The binary rpm and the src.rpm will be built. Thi=
s has
> to be done in the appropriate place)
>=20
> If the spec is ok?? Don't know for me it works.
>=20
> Good luck
>=20
> Andreas


--=20
Professional Service around Free Software                (intevation.net) =
=20
The FreeGIS Project				            (freegis.org)
Association for a Free Informational Infrastructure            (ffii.org)

--PmA2V3Z32TCmWXqI
Content-Type: application/pgp-signature
Content-Disposition: inline


--PmA2V3Z32TCmWXqI--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
