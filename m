Date: Tue, 23 May 2000 01:10:19 -0800
From: Ethan Benson <erbenson@alaska.net>
To: Andreas Tobler <toa@pop.agri.ch>
Cc: Linux -Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: OF & adaptec2940UW on 7200
Message-ID: <20000523011019.R7243@plato.local.lan>
References: <39295A52.9E767503@pop.agri.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="t5UUIFOgpLXgUtsP"
In-Reply-To: <39295A52.9E767503@pop.agri.ch>; from toa@pop.agri.ch on Mon, May 22, 2000 at 06:03:43PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--t5UUIFOgpLXgUtsP
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

On Mon, May 22, 2000 at 06:03:43PM +0200, Andreas Tobler wrote:
>=20

[snip]
>=20
> Now I think I miss the /sd and /st entries behind the /ADPT entry. I
> followed the parts of the yaboot-faq, to find out about disk naming
> under OF.
> I set the boot-device like this: /bandit@F2000000/ADPT,2940UW@E/@2 for
> the second disk.
> On boot cmd it only says can't open the above.

have you tried /bandit@F2000000/ADPT,2940UW@E/@2:0 <-- notice the :0

you need to specify that partition number to quik, quik uses partition
0 to indicate that it should use the parititon marked bootable in the
partition table.  i think you could specify the root partition here as
well but im not sure of that.

> Are there some people having a similar card/experience?
> Also, creating alias'es under this OF doesn't seem to work. (OF-1.0.5)
> 0 > nvalias sd /bandit@F2000000/ADPT,2940UW@E  ok
> 0 > nvstore NVRAMRC not valid

dev aliases are only tested on newworld hardware (imacs, blue G3, g4s
etc) its not guarenteed to work on older OF.  (and it seems it does
not)  it could just be a different command too hard to say.=20

let me know if your kernel (if 2.2.15) boots ;-) =20

--=20
Ethan Benson
http://www.alaska.net/~erbenson/

--t5UUIFOgpLXgUtsP
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEUEARECAAYFAjkqSvsACgkQJKx7GixEevzFBgCggjgxKLxmkS4utZC1jctRzoJE
o3AAl3ufcLmoya5k/qPUcPlrLatUWhg=
=fIJT
-----END PGP SIGNATURE-----

--t5UUIFOgpLXgUtsP--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
