Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 2/4 V4] MSI support on 83xx/85xx/86xx board
From: Michael Ellerman <michael@ellerman.id.au>
To: Jason Jin <Jason.jin@freescale.com>
In-Reply-To: <1210323810-24833-2-git-send-email-Jason.jin@freescale.com>
References: <1210323810-24833-1-git-send-email-Jason.jin@freescale.com>
	<1210323810-24833-2-git-send-email-Jason.jin@freescale.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-WhfgqU6RgxIWpvc4SlU6"
Date: Fri, 09 May 2008 22:21:59 +1000
Message-Id: <1210335719.11689.5.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-WhfgqU6RgxIWpvc4SlU6
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2008-05-09 at 17:03 +0800, Jason Jin wrote:
> This MSI driver can be used on 83xx/85xx/86xx board.
> In this driver, virtual interrupt host and chip were
> setup. There are 256 MSI interrupts in this host, Every 32
> MSI interrupts cascaded to one IPIC/MPIC interrupt.
> The chip was treated as edge sensitive and some necessary
> functions were setup for this chip.

> diff --git a/arch/powerpc/sysdev/fsl_msi.c b/arch/powerpc/sysdev/fsl_msi.=
c
> new file mode 100644
> index 0000000..be3304d
> --- /dev/null
> +++ b/arch/powerpc/sysdev/fsl_msi.c
> @@ -0,0 +1,446 @@

...

> +static int fsl_msi_host_match(struct irq_host *h, struct device_node *no=
de)
> +{
> +	/* Exact match*/
> +	return h->of_node =3D=3D node;
> +}

This is the default behaviour, so technically you don't need this
routine - but I'm not fussed.

Acked-by: Michael Ellerman <michael@ellerman.id.au>

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-WhfgqU6RgxIWpvc4SlU6
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBIJEHndSjSd0sB4dIRAspVAJ4q3YeVAHT1kE0zjGETaGjpr2aVDgCfeYXv
XxttpUHtkq2H2qxjQ8C9aOY=
=+7KF
-----END PGP SIGNATURE-----

--=-WhfgqU6RgxIWpvc4SlU6--
