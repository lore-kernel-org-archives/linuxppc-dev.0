Date: Fri, 13 Apr 2001 01:24:19 -0800
From: Ethan Benson <erbenson@alaska.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: boot params
Message-ID: <20010413012419.R2127@plato.local.lan>
References: <20010412162639.K2127@plato.local.lan> <XFMail.010413103837.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+sObS8/rhx1YpqEF"
In-Reply-To: <XFMail.010413103837.pochini@shiny.it>; from pochini@shiny.it on Fri, Apr 13, 2001 at 10:38:37AM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--+sObS8/rhx1YpqEF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 13, 2001 at 10:38:37AM +0200, Giuliano Pochini wrote:
>=20
> Do you rerun ybin ?  I just change yaboot.conf and it works.

i do not screw with the bootstrap partition directly. its too much
trouble and will just get corrupted.  i edit /etc/yaboot.conf and run
ybin.

> I have problem with devices running at different clocks on the same bus.
> v6.1.11 hangs during bus scanning.

interesting.. never had any problems like that..

--=20
Ethan Benson
http://www.alaska.net/~erbenson/

--+sObS8/rhx1YpqEF
Content-Type: application/pgp-signature
Content-Disposition: inline


--+sObS8/rhx1YpqEF--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
