Date: Mon, 31 Jul 2000 08:53:55 -0400
From: Josh Huber <huber@mclx.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: LinuxPPC X Server
Message-ID: <20000731085355.B617@mclx.com>
References: <200007302123.WAA28673@hyperion.valhalla.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="GRPZ8SYKNexpdSJ7"
In-Reply-To: <200007302123.WAA28673@hyperion.valhalla.net>; from iain@sandoe.co.uk on Sun, Jul 30, 2000 at 10:24:19PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--GRPZ8SYKNexpdSJ7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 30, 2000 at 10:24:19PM +0100, Iain Sandoe wrote:
>=20
> I think I may have made a configuration mistake (see Michel's mail).

Hmm, that's probably not the reason. (see below)

> However, 300M G3, UW SCSI + 256 Mb RAM =3D=3D> 6.5-ish Hours (*all* day w=
as only
> a slight exaggeration :-).
>=20
> (OK, so I did a kernel build as well [30 mins] and had a screen saver
> running - but... )

I'm guessing that your screen saver might have been using a bit much
CPU.  I built XF4 on my powerbook wallstreet 233 in a little under 2
hours, with no configuration file changes. (except for ProjectRoot).

Definately no UW SCSI and only 160M of ram.  You should be able to
build in 1.5 hours I would think, with that setup. :)

ttyl,

--=20
Josh
6B21489A | GnuPG ID/Fingerprint | huber@mclx.com |
61F0 6138 BE7B FEBF A223  E9D1 BFE1 2065 6B21 489A

--GRPZ8SYKNexpdSJ7
Content-Type: application/pgp-signature
Content-Disposition: inline


--GRPZ8SYKNexpdSJ7--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
