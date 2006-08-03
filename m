Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 0345367BDD
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Aug 2006 13:57:40 +1000 (EST)
Date: Thu, 3 Aug 2006 13:57:17 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Mike Kravetz <kravetz@us.ibm.com>
Subject: Re: [RFC] asm code for Hypervisor Call Instrumentation
Message-Id: <20060803135717.754bd37f.sfr@canb.auug.org.au>
In-Reply-To: <20060802175947.GA7489@w-mikek2.ibm.com>
References: <20060802175947.GA7489@w-mikek2.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__3_Aug_2006_13_57_17_+1000_H.5yMtcSw7uNyn1z"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__3_Aug_2006_13_57_17_+1000_H.5yMtcSw7uNyn1z
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Mike,

On Wed, 2 Aug 2006 10:59:47 -0700 Mike Kravetz <kravetz@us.ibm.com> wrote:
>
> +#else
> +
> +#define STACKFRAMESIZE	0
> +#define HCALL_INST_PRECALL	nop
> +#define HCALL_INST_POSTCALL	nop

Why even "nop", why not just blank?

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__3_Aug_2006_13_57_17_+1000_H.5yMtcSw7uNyn1z
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFE0XQkFdBgD/zoJvwRAtRhAJ4zIXvlEvsbLPKA55jKT1R37iOjDwCdFCzW
rKxZjbP8x+gQqJFTVW6gG6c=
=vc5M
-----END PGP SIGNATURE-----

--Signature=_Thu__3_Aug_2006_13_57_17_+1000_H.5yMtcSw7uNyn1z--
