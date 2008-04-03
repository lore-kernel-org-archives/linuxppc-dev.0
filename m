Return-Path: <johannes@sipsolutions.net>
Subject: Re: printk time confusion?
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Herrenschmidt <benh@ozlabs.org>
In-Reply-To: <1207219724.10388.319.camel@pasglop>
References: <1207146186.3957.11.camel@johannes.berg>
	<1207219724.10388.319.camel@pasglop>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-qM+VvskrpyMlBM2Q8i4V"
Date: Thu, 03 Apr 2008 13:07:24 +0200
Message-Id: <1207220844.3636.42.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Arnd Bergmann <arndb@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-qM+VvskrpyMlBM2Q8i4V
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> > Not sure whether the lockdep patches or something else is causing this
> > as I haven't checked w/o the patches yet, but I seem to be having some
> > confusion of printk timestamps:
>=20
> Tried reverting the patches ?

No, not yet, I'll do that later today.


> > [  155.982345] ioctl32(gnome-terminal:6543): Unknown cmd fd(31) cmd(000=
0530b){t:'S';sz:0} arg(0fd7bbe0) on /dev/pts/8

> > Yes, these entries really were printed in that order. Btw, what's with
> > the unknown ioctls?
>=20
> Proably ioctl's that lack a 32 bits conversion, you'll have to dig in
> the pty stuff to find out which ones it is and if it can be a problem...

Yeah, I'll have to see, I just thought Arnd might already know :)

johannes

--=-qM+VvskrpyMlBM2Q8i4V
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUAR/S6a6Vg1VMiehFYAQJsdA//W93YEX8OEiz+xx99eUen8edaB0UKmyqJ
ll7+mE050sYjbwbkhXaIRJeLsJWbmBkiCpST9rl5ujTUMqhAbtMtgR2BHBs+eBWC
V6R9yRQg6xtPl9ooZIyq0dQ1dg4btowuc/XKNoQWqXLUDGTt4bVAGlhbyZYaqXyd
eArKyw9FZ+xk5aZ4UwXkDOCjCrkj9haXrSbtVgxsyxs4IoxohfT7JKVBmXlGTxam
tmYjRSVDALzBQkTF8KTs7dyh0DOEAYJ6XXx+R3WBOW8JadD3+2/5ghWEXocnwIO7
QjAcXE7LTs63dVBI7ri7EQuYAiwGEGdawLRuuDG6O3rM74lKczFJajohYDMmOFdi
IljyyTJwLI4tCwaiOgTbEnoH9fxNkDF5dboqZAjT9TipWW8Iy02mv/H+N/reJsdG
MNv0TqnM7och4NJ5aDxOpt6To+J3hklx0WjtAha8q0UhdDj6E98cUP/HtdVxjDRv
mri494QJY18YW61ZUrTj0vse/Tsy8gDbps8aLYITRM41lcyUJoj7Yns2EU2hwKsz
T2F5rhmw94rISRR6+SVTO4aYrXSZxwwXIlkgCK7Pf1OfgJaG34tHcFu6g9A4+D9K
Ps3L1dcfNVHNpIH4SCGzGdqxpnULYufzj8nV9RKWl4hwGrHIf6jEIoXMg2i+9iOW
2Aih0sedjfU=
=1HwU
-----END PGP SIGNATURE-----

--=-qM+VvskrpyMlBM2Q8i4V--
