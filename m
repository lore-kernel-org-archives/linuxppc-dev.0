Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 3/3] ppc64-specific memory notifier support
From: Michael Ellerman <michael@ellerman.id.au>
To: Badari Pulavarty <pbadari@us.ibm.com>
In-Reply-To: <1204307236.10146.1.camel@dyn9047017100.beaverton.ibm.com>
References: <1204217028.28696.10.camel@dyn9047017100.beaverton.ibm.com>
	<1204217166.28696.15.camel@dyn9047017100.beaverton.ibm.com>
	<1204243875.7729.3.camel@concordia.ozlabs.ibm.com>
	<20080229003906.GP16241@localdomain>
	<1204247002.7729.11.camel@concordia.ozlabs.ibm.com>
	<1204307236.10146.1.camel@dyn9047017100.beaverton.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-qlXHE+Qgk2+Xq2aAxq5V"
Date: Mon, 03 Mar 2008 11:49:39 +1100
Message-Id: <1204505379.7570.0.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Nathan Lynch <ntl@pobox.com>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-qlXHE+Qgk2+Xq2aAxq5V
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2008-02-29 at 09:47 -0800, Badari Pulavarty wrote:
> Index: linux-2.6.25-rc2/arch/powerpc/platforms/pseries/hotplug-memory.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-2.6.25-rc2/arch/powerpc/platforms/pseries/hotplug-memory.c	2008=
-02-29 09:25:14.000000000 -0800
> @@ -0,0 +1,98 @@

> +
> +static struct notifier_block pseries_mem_nb =3D {
> +	.notifier_call =3D pseries_memory_notifier,
> +};
> +
> +static int __init pseries_memory_hotplug_init(void)
> +{
> +	if (firmware_has_feature(FW_FEATURE_LPAR))
> +		pSeries_reconfig_notifier_register(&pseries_mem_nb);
> +
> +	return 0;
> +}
> +machine_device_initcall(pseries, pseries_memory_hotplug_init);

Yep that looks good.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-qlXHE+Qgk2+Xq2aAxq5V
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHy0sjdSjSd0sB4dIRAvg2AJ0Roc+7xRkvU9sZImPJPi2wnDd8qACgzLEm
AfwaGAGoarTeROYWa5c4wUo=
=6InW
-----END PGP SIGNATURE-----

--=-qlXHE+Qgk2+Xq2aAxq5V--
