Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 6AC45DDE2E
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Oct 2007 09:41:49 +1000 (EST)
Date: Tue, 2 Oct 2007 09:41:30 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] powerpc: Implement logging of unhandled signals
Message-Id: <20071002094130.98cdcff6.sfr@canb.auug.org.au>
In-Reply-To: <20071001203242.GA14091@lixom.net>
References: <20071001203242.GA14091@lixom.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__2_Oct_2007_09_41_30_+1000_CYQmXZtzEo7sMQb1"
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__2_Oct_2007_09_41_30_+1000_CYQmXZtzEo7sMQb1
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Olof,

On Mon, 1 Oct 2007 15:32:42 -0500 Olof Johansson <olof@lixom.net> wrote:
>
> +	char fmt32[] =3D KERN_INFO "%s[%d]: unhandled signal %d " \
> +			"at %08lx nip %08lx lr %08lx code %x\n";
> +	char fmt64[] =3D KERN_INFO "%s[%d]: unhandled signal %d " \
> +			"at %016lx nip %016lx lr %016lx code %x\n";

const char ... ?

> +static char fmt32[] =3D KERN_INFO \
> +	"%s[%d]: bad frame in %s: %08lx nip %08lx lr %08lx\n";
> +static char fmt64[] =3D KERN_INFO \
> +	"%s[%d]: bad frame in %s: %016lx nip %016lx lr %016lx\n";

again?

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__2_Oct_2007_09_41_30_+1000_CYQmXZtzEo7sMQb1
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHAYWvTgG2atn1QN8RAl4aAJ98acnGiLHihYK6ciF3iVNQHip6gwCeNhcd
3deum3qZYNkOrG6xoXhbYXo=
=nxmy
-----END PGP SIGNATURE-----

--Signature=_Tue__2_Oct_2007_09_41_30_+1000_CYQmXZtzEo7sMQb1--
