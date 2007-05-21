Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] [POWERPC] Comment out a currently unused function
From: Michael Ellerman <michael@ellerman.id.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20070521154026.640320cd.sfr@canb.auug.org.au>
References: <20070521154026.640320cd.sfr@canb.auug.org.au>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-vKjgQ0CfDm54gMQg4Yn1"
Date: Mon, 21 May 2007 17:19:30 +1000
Message-Id: <1179731970.5579.0.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-vKjgQ0CfDm54gMQg4Yn1
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2007-05-21 at 15:40 +1000, Stephen Rothwell wrote:
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/macintosh/windfarm_smu_sat.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>=20
> --=20
> Cheers,
> Stephen Rothwell                    sfr@canb.auug.org.au
>=20
> diff --git a/drivers/macintosh/windfarm_smu_sat.c b/drivers/macintosh/win=
dfarm_smu_sat.c
> index 1043b39..42b767a 100644
> --- a/drivers/macintosh/windfarm_smu_sat.c
> +++ b/drivers/macintosh/windfarm_smu_sat.c
> @@ -400,10 +400,12 @@ static int __init sat_sensors_init(void)
>  	return i2c_add_driver(&wf_sat_driver);
>  }
> =20
> +#if 0	/* uncomment when module_exit() below is uncommented */
>  static void __exit sat_sensors_exit(void)
>  {
>  	i2c_del_driver(&wf_sat_driver);
>  }
> +#endif

Why not remove it? You can always get it back with git.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-vKjgQ0CfDm54gMQg4Yn1
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGUUgCdSjSd0sB4dIRAgl9AKC5iXIk3ftcGGtosGBpWJUfBIaVugCdG01V
J0YDEa/Pxp7SWiqEnXnyr6I=
=sqlz
-----END PGP SIGNATURE-----

--=-vKjgQ0CfDm54gMQg4Yn1--
