Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 5/9] ps3: Preallocate bootmem memory for ps3fb
From: Michael Ellerman <michael@ellerman.id.au>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <Pine.LNX.4.62.0701251849550.24610@pademelon.sonytel.be>
References: <Pine.LNX.4.62.0701251825390.14799@pademelon.sonytel.be>
	<Pine.LNX.4.62.0701251849550.24610@pademelon.sonytel.be>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-mgCt+0uGL4wdtvkDOC7B"
Date: Tue, 30 Jan 2007 13:29:17 +1100
Message-Id: <1170124157.19887.116.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>, James Simmons <jsimmons@infradead.org>,
	Linux Frame Buffer Device Development
	<linux-fbdev-devel@lists.sourceforge.net>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-mgCt+0uGL4wdtvkDOC7B
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2007-01-25 at 18:50 +0100, Geert Uytterhoeven wrote:
> Preallocate bootmem memory for the PS3 frame buffer device, which needs a
> large block of physically-contiguous memory. The size of this memory bloc=
k is
> configurable:
>   - The config option CONFIG_FB_PS3_DEFAULT_SIZE_M allows to specify the
>     default amount of memory (in MiB) allocated to the virtual frame buff=
er.
>   - The early boot parameter `ps3fb=3Dxxx' allows to override the default=
 value.
>     It will be rounded up to a multiple of 1 MiB, if needed.
>=20
> Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

Rather than doing the alloc in setup.c, defining a structure to the hold
the params, and then exporting the structure - why don't you just do the
alloc in the ps3 fb driver code, and have it all private in there?

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-mgCt+0uGL4wdtvkDOC7B
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBFvq19dSjSd0sB4dIRAvtvAKCcMGFlUACDbMwG8Zve6uNY7MWvdACfWocn
ZhfV5G0TXXLLxMorvMAJ/h0=
=8EgF
-----END PGP SIGNATURE-----

--=-mgCt+0uGL4wdtvkDOC7B--
