Return-Path: <sfr@canb.auug.org.au>
Date: Fri, 30 May 2008 15:25:01 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 2.6.26] electra_cf: Add MODULE_DEVICE_TABLE()
Message-Id: <20080530152501.214c2380.sfr@canb.auug.org.au>
In-Reply-To: <20080529200542.GA20002@lixom.net>
References: <20080529200542.GA20002@lixom.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__30_May_2008_15_25_01_+1000_5+PAhZC_gMkIKNBI"
Cc: linuxppc-dev@ozlabs.org, pasemi-linux@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Fri__30_May_2008_15_25_01_+1000_5+PAhZC_gMkIKNBI
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Olof,

On Thu, 29 May 2008 15:05:44 -0500 Olof Johansson <olof@lixom.net> wrote:
>
> electra_cf: Add MODULE_DEVICE_TABLE()
>    =20
> Add a module device table to electra_cf so that modules can be
> auto-probed/loaded.
>    =20
> [will be included in git pull request later today]

No Signed-off-by?

> diff --git a/drivers/pcmcia/electra_cf.c b/drivers/pcmcia/electra_cf.c
> index 0a6cea1..52d0aa8 100644
> --- a/drivers/pcmcia/electra_cf.c
> +++ b/drivers/pcmcia/electra_cf.c
> @@ -352,6 +352,7 @@ static struct of_device_id electra_cf_match[] =3D {

While you are here, want to make that const?

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__30_May_2008_15_25_01_+1000_5+PAhZC_gMkIKNBI
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIP4+zTgG2atn1QN8RAi7oAJ4x/8/BhiglBdceqduCceguMobjKwCfScxB
L4ZJLy9kI26HSf4QLgJMV98=
=1Oxs
-----END PGP SIGNATURE-----

--Signature=_Fri__30_May_2008_15_25_01_+1000_5+PAhZC_gMkIKNBI--
