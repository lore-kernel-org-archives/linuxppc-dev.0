Date: Thu, 20 Jul 2000 08:55:51 -0400
From: Josh Huber <huber@mclx.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: problems about __cli()
Message-ID: <20000720085551.B11770@mclx.com>
References: <200007200919.KAA12257@hyperion.valhalla.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="K8nIJk4ghYZn606h"
In-Reply-To: <200007200919.KAA12257@hyperion.valhalla.net>; from iain@sandoe.co.uk on Thu, Jul 20, 2000 at 10:19:54AM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--K8nIJk4ghYZn606h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 20, 2000 at 10:19:54AM +0100, Iain Sandoe wrote:
>=20
[snip]
>=20
> It is *vital* to make sure that there is a symlink named 'linux' in /usr/=
src
> that points to your /usr/src/your-kernel-foo-bar/ because there are symli=
nks
> in /usr/include that expect to use this to find the build-specific header=
s.

A couple notes:

You don't have to put your kernel in /usr/src, and you DON'T have to
symlink /usr/src/linux to it before you build.  The symlinks (on
broken RedHat derivatives) in /usr/include should point to the kernel
headers that your libc was built againt, otherwise you risk breaking
binary compatibility.

--=20
Josh
6B21489A | GnuPG ID/Fingerprint | huber@mclx.com |
61F0 6138 BE7B FEBF A223  E9D1 BFE1 2065 6B21 489A

--K8nIJk4ghYZn606h
Content-Type: application/pgp-signature
Content-Disposition: inline


--K8nIJk4ghYZn606h--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
