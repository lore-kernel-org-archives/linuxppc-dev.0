Date: Wed, 5 Apr 2000 04:16:55 -0800
From: Ethan Benson <erbenson@alaska.net>
To: Tim Wojtulewicz <Tim.Wojtulewicz@NAU.EDU>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Setting up yaboot
Message-ID: <20000405041655.B421@plato.localdomain.local>
References: <200004040459.XAA03713@lists.linuxppc.org> <38EA7D15.C453ED94@uncc.edu> <38EACD97.113001FE@dana.ucc.nau.edu> <20000405083212.B7710@suse.de> <a04301800b510a9fc6322@[134.114.64.240]>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/WwmFnJnmDyWGHa4"
In-Reply-To: <a04301800b510a9fc6322@[134.114.64.240]>; from Tim.Wojtulewicz@NAU.EDU on Wed, Apr 05, 2000 at 01:34:42AM -0700
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--/WwmFnJnmDyWGHa4
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 05, 2000 at 01:34:42AM -0700, Tim Wojtulewicz wrote:
>=20
> If I boot into OF, then type 'boot' at the prompt, I get the
> following error message:
>=20
> boot load-size=3D196 adler32=3D2e0879a0
>=20
> DEFAULT CATCH, code=3D70 at %SRR0: ff80b320  %SRR1:0000b030

ain't OF great ;-)

> Here's what I have for a os-chooser script:

this probably isn't it given the above gibberish, but try adding
PowerBook3,1 to the <COMPATIBLE> line below.=20

if that does not work try loading this script directly (or just load
yaboot directly) like so:

boot ultra0:10,ofboot.b (or whatever its called)

or=20

boot ultra0:10,yaboot  <-- this one should work if not something is
really borked.

> <CHRP-BOOT>
> <COMPATIBLE>
> iMac,1 PowerMac1,1 PowerBook1,1 PowerMac2,1 PowerMac3,1 PowerBook2,1
> </COMPATIBLE>
> <DESCRIPTION>
> Linux/PPC Yaboot bootloader
> </DESCRIPTION>
> <BOOT-SCRIPT>
> " get-key-map" " keyboard" open-dev $call-method
> dup 20 dump
> 5 + c@ 08 =3D if
> " Booting MacOS ..." cr " boot ultra0:9,\\:tbxi" eval
> else
> " Booting Yaboot ..." cr " boot ultra0:10,\\yaboot" eval
> then
> </BOOT-SCRIPT>
> </CHRP-BOOT>
>=20
> As before, my MacOS partition is #9, and my boot partition is #10.
>=20
> Thanks.
>=20
> Tim
>=20
>=20

--=20
Ethan Benson
http://www.alaska.net/~erbenson/

--/WwmFnJnmDyWGHa4
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjjrLrcACgkQJKx7GixEevxMZwCdHc7u1DMb9BcrtD2PxLHhqNZ7
yh4An3fWkAOuPfISXhRKDnBldWYAWr07
=o8Ae
-----END PGP SIGNATURE-----

--/WwmFnJnmDyWGHa4--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
