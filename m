Date: Wed, 29 Aug 2001 15:28:19 -0800
From: Ethan Benson <erbenson@alaska.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: firewire screwup
Message-ID: <20010829152819.U28241@plato.local.lan>
References: <15244.11337.823289.698210@titan.metzler> <p05100304b7b1e866127d@[10.0.0.42]> <15244.47416.198967.661158@titan.metzler> <p05100300b7b28192a28d@[10.0.0.42]> <20010829041634.M28241@plato.local.lan> <15245.5095.262375.114791@titan.metzler>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yT5CehYOm/p2z10t"
In-Reply-To: <15245.5095.262375.114791@titan.metzler>; from mocm@convergence.de on Wed, Aug 29, 2001 at 06:10:15PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--yT5CehYOm/p2z10t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 29, 2001 at 06:10:15PM +0200, Marcus O.C. Metzler wrote:
>=20
> Ethan Benson writes:
>  >
>  > i did something like that once as well, removing the battery did me no
>  > good whatsoever.  only entering the backup OpenFirmware image worked
>  > and allowed me to reset the nvram.
>  >
>=20
> So, how do I do that?

boot while holding the interupt switch, in the same manner as if you
were performing a firmware upgrade, except keep it down even after the
long tone is heard, after a certain ammount of time you can i think
press command option p r (to reset the nvram) or command option o f to
enter OF.  im not sure of the details, when i did it had a black
screen after the tone, i pressed command option p r and it immediatly
rebooted and all was fine after that.  previously no keyboard input
was accepted at all, all i had was a startup tone, black screen and
nothing. =20

--=20
Ethan Benson
http://www.alaska.net/~erbenson/

--yT5CehYOm/p2z10t
Content-Type: application/pgp-signature
Content-Disposition: inline


--yT5CehYOm/p2z10t--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
