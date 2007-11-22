Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 06E05DDF38
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Nov 2007 09:17:36 +1100 (EST)
Date: Fri, 23 Nov 2007 09:17:27 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Dale Farnsworth <dale@farnsworth.org>
Subject: Re: [PATCH 01/10] powerpc: Set up OF properties for ppc32 kexec
Message-Id: <20071123091727.6e6fcd7a.sfr@canb.auug.org.au>
In-Reply-To: <20071122154517.GA26340@xyzzy.farnsworth.org>
References: <20071122154159.GA24711@xyzzy.farnsworth.org>
	<20071122154517.GA26340@xyzzy.farnsworth.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__23_Nov_2007_09_17_27_+1100_M9g8Ph6mK6G..OuQ"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Fri__23_Nov_2007_09_17_27_+1100_M9g8Ph6mK6G..OuQ
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dale,

Just a nit ...

On Thu, 22 Nov 2007 08:45:17 -0700 Dale Farnsworth <dale@farnsworth.org> wr=
ote:
>
> +static struct property crashk_base_prop =3D {
> +	.name =3D "linux,crashkernel-base",
> +	.length =3D sizeof(unsigned long),
> +	.value =3D &crashk_res.start, };
                                    ^^
Should be on a new line.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__23_Nov_2007_09_17_27_+1100_M9g8Ph6mK6G..OuQ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHRf/8TgG2atn1QN8RAomOAJ4shih5yv+AvuA0SyIS7+0sWir0yQCZAbBg
m5ykfn5zklai8Ml6pEAOw7E=
=nC5z
-----END PGP SIGNATURE-----

--Signature=_Fri__23_Nov_2007_09_17_27_+1100_M9g8Ph6mK6G..OuQ--
