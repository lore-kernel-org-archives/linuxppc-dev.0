Date: Sun, 15 Apr 2001 21:06:11 -0800
From: Ethan Benson <erbenson@alaska.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: boot params
Message-ID: <20010415210611.H2127@plato.local.lan>
References: <20010412162639.K2127@plato.local.lan> <XFMail.010413103837.pochini@shiny.it> <20010413012419.R2127@plato.local.lan> <3ADA7DD1.CF75ED02@opersys.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UH+blv0jeghwtTzK"
In-Reply-To: <3ADA7DD1.CF75ED02@opersys.com>; from karym@opersys.com on Mon, Apr 16, 2001 at 01:06:25AM -0400
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--UH+blv0jeghwtTzK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 16, 2001 at 01:06:25AM -0400, Karim Yaghmour wrote:
> Ethan Benson wrote:
> >=20
> > i do not screw with the bootstrap partition directly. its too much
> > trouble and will just get corrupted.  i edit /etc/yaboot.conf and run
> > ybin.
>=20
> How does it get "corrupted"? I've been using hcopy to move things
> around and haven't had any problems. Are you suggesting that problems
> may arise from this type of manipulation?

the kernel HFS driver is unreliable.  hfsutils is fine, and thats what
ybin uses.  ybin is just far more convenient then doing everything
manually. =20

--=20
Ethan Benson
http://www.alaska.net/~erbenson/

--UH+blv0jeghwtTzK
Content-Type: application/pgp-signature
Content-Disposition: inline


--UH+blv0jeghwtTzK--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
