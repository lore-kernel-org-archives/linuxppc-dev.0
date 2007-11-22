Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 3CE54DDEFD
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Nov 2007 09:20:59 +1100 (EST)
Date: Fri, 23 Nov 2007 09:20:54 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Dale Farnsworth <dale@farnsworth.org>
Subject: Re: [PATCH 03/10] powerpc: Add kexec support for PPC_85xx platforms
Message-Id: <20071123092054.30e1a23d.sfr@canb.auug.org.au>
In-Reply-To: <20071122154607.GA26447@xyzzy.farnsworth.org>
References: <20071122154159.GA24711@xyzzy.farnsworth.org>
	<20071122154607.GA26447@xyzzy.farnsworth.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__23_Nov_2007_09_20_54_+1100_TJbBc+M=kQ1fUXDZ"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Fri__23_Nov_2007_09_20_54_+1100_TJbBc+M=kQ1fUXDZ
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

More nits ...

On Thu, 22 Nov 2007 08:46:07 -0700 Dale Farnsworth <dale@farnsworth.org> wr=
ote:
>
> @@ -259,6 +260,11 @@ define_machine(mpc85xx_ads) {
>  	.show_cpuinfo		=3D mpc85xx_ads_show_cpuinfo,
>  	.get_irq		=3D mpic_get_irq,
>  	.restart		=3D fsl_rstcr_restart,
> +#ifdef CONFIG_KEXEC
> +	.machine_kexec_prepare =3D default_machine_kexec_prepare,
> +	.machine_kexec =3D default_machine_kexec,
> +	.machine_crash_shutdown	=3D default_machine_crash_shutdown,
> +#endif

Please line these up for consistency.

> @@ -352,6 +353,11 @@ define_machine(mpc85xx_cds) {
>  #else
>  	.restart	=3D fsl_rstcr_restart,
>  #endif
> +#ifdef CONFIG_KEXEC
> +	.machine_kexec_prepare =3D default_machine_kexec_prepare,
> +	.machine_kexec =3D default_machine_kexec,
> +	.machine_crash_shutdown	=3D default_machine_crash_shutdown,
> +#endif

And here

> @@ -224,6 +225,11 @@ define_machine(mpc8572_ds) {
>  #endif
>  	.get_irq		=3D mpic_get_irq,
>  	.restart		=3D fsl_rstcr_restart,
> +#ifdef CONFIG_KEXEC
> +	.machine_kexec_prepare =3D default_machine_kexec_prepare,
> +	.machine_kexec =3D default_machine_kexec,
> +	.machine_crash_shutdown	=3D default_machine_crash_shutdown,
> +#endif

And again ...

> @@ -202,6 +203,11 @@ define_machine(mpc85xx_mds) {
>  	.init_IRQ	=3D mpc85xx_mds_pic_init,
>  	.get_irq	=3D mpic_get_irq,
>  	.restart	=3D fsl_rstcr_restart,
> +#ifdef CONFIG_KEXEC
> +	.machine_kexec_prepare =3D default_machine_kexec_prepare,
> +	.machine_kexec =3D default_machine_kexec,
> +	.machine_crash_shutdown	=3D default_machine_crash_shutdown,
> +#endif

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__23_Nov_2007_09_20_54_+1100_TJbBc+M=kQ1fUXDZ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHRgDKTgG2atn1QN8RAogbAKCAZBUQ8urhoKWfew8VyFaobYCKRwCdG3qU
mBURPxMkt7EW6xOXFTZI1us=
=9L96
-----END PGP SIGNATURE-----

--Signature=_Fri__23_Nov_2007_09_20_54_+1100_TJbBc+M=kQ1fUXDZ--
