Date: Mon, 30 Oct 2000 01:16:02 -0900
From: Ethan Benson <erbenson@alaska.net>
To: Martin Costabel <costabel@wanadoo.fr>
Cc: "Timothy A. Seufert" <tas@mindspring.com>,
        Michael Norton <mnorton@cisco.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: kernel source rpm
Message-ID: <20001030011602.O3768@plato.local.lan>
References: <200010281936.MAA18635@cisco.com> <v04220802b622ea31cf0b@[10.0.0.42]> <39FD404C.2E213ADA@wanadoo.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZmZU9S7l/XJx5q9b"
In-Reply-To: <39FD404C.2E213ADA@wanadoo.fr>; from costabel@wanadoo.fr on Mon, Oct 30, 2000 at 10:33:00AM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--ZmZU9S7l/XJx5q9b
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 30, 2000 at 10:33:00AM +0100, Martin Costabel wrote:

> > Don't do that.  Kernel header files are not intended to be directly
> > #include'd into user applications.  Use the the GNU C and/or C++
> > libraries and headers like you're supposed to, and you will not
> > depend on kernel files at all.
>=20
> This is correct in the Linus-approved True Linux Userspace (tm). Problem
> is that on RedHat based systems like linuxppc, glibc doesn't contain
> /usr/include/linux except as a symlink to /usr/src/linux/include/linux.
> So you need either kernel sources from some archive or the
> "kernel-headers" RPM.

or Debian GNU/Linux

/me ducks

--=20
Ethan Benson
http://www.alaska.net/~erbenson/

--ZmZU9S7l/XJx5q9b
Content-Type: application/pgp-signature


--ZmZU9S7l/XJx5q9b--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
