Return-Path: <johannes@sipsolutions.net>
Subject: Re: printk time confusion?
From: Johannes Berg <johannes@sipsolutions.net>
To: Andreas Schwab <schwab@suse.de>
In-Reply-To: <jehcejqjpj.fsf@sykes.suse.de>
References: <1207146186.3957.11.camel@johannes.berg>
	<1207219724.10388.319.camel@pasglop>  <jehcejqjpj.fsf@sykes.suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-0VL1C/mkjLdmcib6HW5O"
Date: Thu, 03 Apr 2008 13:12:39 +0200
Message-Id: <1207221159.3636.44.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Arnd Bergmann <arndb@de.ibm.com>, Benjamin Herrenschmidt <benh@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-0VL1C/mkjLdmcib6HW5O
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> >> [  155.982345] ioctl32(gnome-terminal:6543): Unknown cmd fd(31) cmd(00=
00530b){t:'S';sz:0} arg(0fd7bbe0) on /dev/pts/8

> > Proably ioctl's that lack a 32 bits conversion, you'll have to dig in
> > the pty stuff to find out which ones it is and if it can be a problem..=
.
>=20
> 0x53xx is claimed by cdrom.h, and 0x530b is CDROMSUBCHNL.  Of course, a
> tty does not implement cdrom ioctls.

Humm ok, then the first question is why gnome-terminal tries that, and
the second why it would printk something?

johannes

--=-0VL1C/mkjLdmcib6HW5O
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUAR/S7pqVg1VMiehFYAQKjvA/+J8S1u+Qy3jFIynBSNKFBaTf6FthfW6hl
SK296uwIUO3khjYcBKgwOwqW8Wtn2l6TmozEAgTtcVizbjouOmPTsK9v4us93YXf
4ve5chAdRLnoE3MtyzHjhON8m1vnI8WXPPpJFHDqYyRKAqUNRRqWWxX9kKqsKNjJ
Z7rSq+aqJIzY708SrMUmSumjEtHZwZOa2L1BZDdrKMIPisdjkZoV293cUNWlQNsz
GxcbW+A71RgACDVDJlqsh7OEuXOK3wmPUbuD/Snoscgc2f2StwpzrlEszHJzoDlX
R9M2KjC0TWBE01XgKXZqMyNoRKXZs/8CEwMGMIJjOn6Pmo7nH+i95dqvbaIPZiXQ
mtPVoSFXvHwcZboX8VWCLLA7k7jGYFql4k/LfmRQCyE2OM0N2QDpA5Nqn2N6L5is
YdE6qM4NIlaFzs/xnK08Jaqlybqw2C0buafCL/cv0W0oDuCkpa45JacHWxpT9tdf
9SgybG0y1xCY1xSSikYdOesYNJA5ye0Fyg+LycYNttjF7sOGgKwjzJN/rm0flzYh
p8qL7Q51hugV5muzkgMlYMDEcBN6QI7Jrk1FTxT3NZmPUi2P5ZE5F42PCJu5ubk0
pLYsD3K+F/pO8uKHkz6lsFYVpisTwjY/g8ZvoH1XjYELC/UBvV8ocsG1cCq2OIjb
NxAN2sRC5hs=
=uYwT
-----END PGP SIGNATURE-----

--=-0VL1C/mkjLdmcib6HW5O--
