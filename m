Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 6327FDDD0C
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Oct 2008 15:58:26 +1100 (EST)
Date: Fri, 24 Oct 2008 15:58:13 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: linux-next: ttydev tree build failure
Message-Id: <20081024155813.ee16dd57.sfr@canb.auug.org.au>
In-Reply-To: <20081023083406.671d4101@lxorguk.ukuu.org.uk>
References: <20081023172938.0460b191.sfr@canb.auug.org.au>
	<20081023083406.671d4101@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__24_Oct_2008_15_58_13_+1100__j_u1ofSxxpeC6tW"
Cc: linux-next@vger.kernel.org,
	Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
	ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Fri__24_Oct_2008_15_58_13_+1100__j_u1ofSxxpeC6tW
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Alan, Hendrik,

On Thu, 23 Oct 2008 08:34:06 +0100 Alan Cox <alan@lxorguk.ukuu.org.uk> wrot=
e:
>
> On Thu, 23 Oct 2008 17:29:38 +1100
> Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>=20
> > Hi Alan,
> >=20
> > Today's linux-next build (powerpc ppc64_defconfig) failed like this:
> >=20
> > drivers/char/hvc_console.c: In function 'hvc_set_winsz':
> > drivers/char/hvc_console.c:532: warning: passing argument 2 of 'tty_do_=
resize' from incompatible pointer type
> > drivers/char/hvc_console.c:532: error: too many arguments to function '=
tty_do_resize'
> >=20
> > Caused by commit eb6ab2d361a49470ca9785c70482772c19e49bec
> > ("pty-simplify-resize") from the ttydev tree interacting with commit
> > febde3711992a64ea83a47a719f68a90c4b0927a ("hvc_console: Add support for
> > tty window resizing").
> >=20
> > The former added another call to the function that the latter changed.
> >=20
> > I applied the following patch
>=20
> Patch is correct.
>=20
> Do the hvc patches have dependancies on the PPC tree as well as the tty
> tree ?

The powerpc patches including these hvc_console patches have now gone
upstream to Linus' tree ...

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__24_Oct_2008_15_58_13_+1100__j_u1ofSxxpeC6tW
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkkBVeUACgkQjjKRsyhoI8z95wCeKjTtj0xvFqR6rJ0tKCQ4vz9m
InsAnR4UuDztoJpQBQSc/J6cNRneSM7W
=1mrv
-----END PGP SIGNATURE-----

--Signature=_Fri__24_Oct_2008_15_58_13_+1100__j_u1ofSxxpeC6tW--
