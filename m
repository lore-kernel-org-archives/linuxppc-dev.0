Date: Thu, 26 Jul 2001 05:57:50 -0800
From: Ethan Benson <erbenson@alaska.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: nfs lockd
Message-ID: <20010726055750.J19641@plato.local.lan>
References: <20010726131353.83EABDB9F0@atlas.valhalla.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rOsx1R9haZTS96jr"
In-Reply-To: <20010726131353.83EABDB9F0@atlas.valhalla.net>; from iain@sandoe.co.uk on Thu, Jul 26, 2001 at 02:14:14PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--rOsx1R9haZTS96jr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 26, 2001 at 02:14:14PM +0100, Iain Sandoe wrote:
>=20
> the init scripts start-up of lockd has been failing for quite some time on
> my installations (prob. since 2.4.x started).
>=20
> I believe I'm up-to-date on utils/nfs stuff etc.
>=20
> is this a known problem - or something wrong with my set-up?

the problem is your initscript, lockd is started automatically by the
kernel.  debian's initscript checks whether the userspace lockd
program should be run or not (all that program actually does is tell
the kernel to start the lockd thread if its not already).=20

--=20
Ethan Benson
http://www.alaska.net/~erbenson/

--rOsx1R9haZTS96jr
Content-Type: application/pgp-signature
Content-Disposition: inline


--rOsx1R9haZTS96jr--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
