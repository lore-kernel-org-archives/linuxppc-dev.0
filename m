Return-Path: <tony@bakeyournoodle.com>
Date: Wed, 15 May 2013 15:32:59 +1000
From: Tony Breeds <tony@bakeyournoodle.com>
To: Alistair Popple <alistair@popple.id.au>
Subject: Re: [PATCH] powerpc: Update currituck pci/usb fixup for new board
 revision
Message-ID: <20130515053258.GB1280@thor.bakeyournoodle.com>
References: <1368057988-7353-1-git-send-email-alistair@popple.id.au>
 <cone.1368060133.955601.31795.1000@mexican>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="b5gNqxB1S1yM7hjW"
In-Reply-To: <cone.1368060133.955601.31795.1000@mexican>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--b5gNqxB1S1yM7hjW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 09, 2013 at 10:42:13AM +1000, Alistair Popple wrote:
> The currituck board uses a different IRQ for the pci usb host
> controller depending on the board revision. This patch adds support
> for newer board revisions by retrieving the board revision from the
> FPGA and mapping the appropriate IRQ.
>=20
> Signed-off-by: Alistair Popple <alistair@popple.id.au>

Acked-by: Tony Breeds <tony@bakeyournoodle.com>
=20
Yours Tony

--b5gNqxB1S1yM7hjW
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (GNU/Linux)

iQIcBAEBCAAGBQJRkx4KAAoJEEsCiJRY75GKAG0QAIvKw4NBfA0NG16zpza0pxIh
pil/FLUz2ZMujppNpSqifnqYzcIdfG0/afaYV71lLsCSSCy8auMWVpNzBGjHmIWe
CiAE1O1nrNLd2y9zNQ7ePt2X6IRr2yssX9iFhbbJNfhosrIagL6iDoSPGP37O0GU
XVIzYcCoDPQpFl6gs1CFhbdGJuzSIQUfa7FXzIFC/h892q6YCDUEfYN2Fi7QyD9y
pDW6g64keVdjyYzeCtWy1vyUmxoZ90XkR+gOZNivKJDXm7tZnLyORCei6ImakBLw
+gtXrrjeqW4A3eW1TPmsbydY6TvMQceAErKLFW8NRUUV9955bioR48zW5zvizpq2
Kigws3nPZaBCigcpkSok/J8OOs5GsqwNr+zQw/1ZbKeZGSlP1vAzjCZcFv7g9y8A
Cjwkrmpg0YSl/dFZoKVVRAcz4IVlTFlpMiwbgjAfRqJJ3NytSYYPEsVx8+wFaUQF
J12f6pPeFBDQEIzamWwD5EGTueY9ZfMDvgsU4vJ1SbE8qaWJ4G0uDonFgweDYHN8
TOZtBSWfbt6K/VsiklWSqg0g5GlQJ5sO1uzR+b+Z80fL290aHhX7q6mw02XtaDQx
jqFmrjfOeW54xojKUnS78bMt9lGckYLUTaVz21ihT/zEg/X4H07kLXDouZ3uRDQP
VkZHXboNF3Bmg/mxdd6x
=ZTug
-----END PGP SIGNATURE-----

--b5gNqxB1S1yM7hjW--
