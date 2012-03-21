Return-Path: <tony@bakeyournoodle.com>
Date: Thu, 22 Mar 2012 09:14:03 +1100
From: Tony Breeds <tony@bakeyournoodle.com>
To: Robert Berger <robert.karl.berger@gmail.com>
Subject: Re: kilauea compilation breaks with v3.3 kernel and ELDK 4.2
Message-ID: <20120321221402.GA18735@thor.bakeyournoodle.com>
References: <4F69C553.6070409@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
In-Reply-To: <4F69C553.6070409@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 21, 2012 at 02:10:59PM +0200, Robert Berger wrote:
> Hi,
>=20
> Up to 3.2.x I was able to compile a mainline kernel for the kilauea
> board, but...
>=20
> http://git.denx.de/?p=3Dlinux-denx.git;a=3Dcommitdiff;h=3D075bcf5879225d0=
c2a119c23d8046b890e051e81
>=20
> shows, that mfdcrx was introduced in the v3.3 kernel.
>=20
> The problem is that for ppc-linux-gcc (GCC) 4.2.2 (which comes with the
> ELDK 4.2) this assembly instruction is not known and the build breaks.

If the instruction is available on your platform but not in your
toolchain we can do something ugly (as we hav in the past) and replace
"mfdrcx" with ".long xxxx".  That will bypass the compiler breakage.
=20
> What puzzles me is that also stuff for boards is being compiled which is
> not really needed like treeboot-currituck.c even when I configure the
> kernel for a kilauea board.

Can you either propvide the config file or the name of the config target
so I look into why it's enabling the currituck platform.

Yours Tony

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJPalKqAAoJEEsCiJRY75GKhwsP/Rqk8CNcAWc/8r4CU4UACvs1
5h/YNqxZKE03/+HrIVXer51huTyMB9uOIDZbNb95L+hNr+mgdo5trLWD2IJa7wU+
xPcoEro0PUVgFrpCx7jp9qkh//tynlDrFxSotF1N2NjafWTIOsRf2w8tg7+AoIkx
1v9NW9MFlhi9Y7RHMBTMqkm2iDg9s2pROITyuLaqwzxz3oI4bX24qhzcAFa7Y4T3
cNvT01+laZstPnjn4Vxy2w8NWexOTAYG4g88gnzj1RHx1jbsVUmsuEAVAlPA+OzI
CBHaz4kROAuiej1+VhOTeA6WHdLPplLFqSZYSRetaWRmW5Tm2lUoAzQRdZQ/bAow
i8PXoc8Zwat/E5YkVFWqZliVpHuBWp2B1E3KzGaQrVBGQKxDk3pXb9FhMN4Vf48Q
LUEcCAEcQFCBjEiqJfLCE2W1BiJDXzKw8c/Y0Z3A6B0OLx0F4KS/DX0jkei/OpL2
ttQHZDcRaOFsLOBNnfvy2YTpbv7Q+fe3RIWUQg+cKLW9jYejd0MQl/75r/E/JhWu
g/5gu1ETcqGOTD4+k1VoAUWFQ4hmD8BJUhfPtiPyMpamd9g2C8e6g6PM/OmvgTd6
CtXohKMjt9z1RS5CWTWwq3DxQrah5WH/sW14qxo9eNXL/ro3f/+UUuk0VWLsh5aR
J9TxufwbXnRyRG5XAgUs
=TpY4
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
