Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 9EC26B7D52
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Apr 2010 12:09:32 +1000 (EST)
Date: Wed, 28 Apr 2010 12:09:22 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [patch 03/15] powerpc: cpumask: Convert smp_cpus_done to new
	cpumask API
Message-Id: <20100428120922.11d7b47e.sfr@canb.auug.org.au>
In-Reply-To: <20100427013431.787617147@samba.org>
References: <20100427013231.510168034@samba.org>
	<20100427013431.787617147@samba.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__28_Apr_2010_12_09_22_+1000_MJBP4mxgg.ZDBXT3"
Cc: rusty@rustcorp.com.au, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Wed__28_Apr_2010_12_09_22_+1000_MJBP4mxgg.ZDBXT3
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Anton,

On Tue, 27 Apr 2010 11:32:34 +1000 Anton Blanchard <anton@samba.org> wrote:
>
> -	old_mask =3D current->cpus_allowed;
> -	set_cpus_allowed(current, cpumask_of_cpu(boot_cpuid));
> -=09
> +	alloc_cpumask_var(&old_mask, GFP_NOWAIT);

You should probably put an explicit include of linux/gfp.h in this file
for this.  (Maybe linux/cpumask.h should include it - but it doesn't.)

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__28_Apr_2010_12_09_22_+1000_MJBP4mxgg.ZDBXT3
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkvXmNIACgkQjjKRsyhoI8yh9ACfV22N/AMiHTcMC30RoxeFvNbL
IrwAn38XQUdeZGQPt3FnL8UTJiiRfj5z
=dOB2
-----END PGP SIGNATURE-----

--Signature=_Wed__28_Apr_2010_12_09_22_+1000_MJBP4mxgg.ZDBXT3--
