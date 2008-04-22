Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 219FADDE0E
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Apr 2008 13:50:11 +1000 (EST)
Date: Tue, 22 Apr 2008 13:50:05 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Tony Breeds <tony@bakeyournoodle.com>
Subject: Re: [PATCH 1/3] Raise the upper limit of NR_CPUS.
Message-Id: <20080422135005.16b4a65d.sfr@canb.auug.org.au>
In-Reply-To: <767e424a294239aba86aa7da086f6395f7066d14.1208834828.git.tony@bakeyournoodle.com>
References: <767e424a294239aba86aa7da086f6395f7066d14.1208834828.git.tony@bakeyournoodle.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__22_Apr_2008_13_50_05_+1000_GUlLMPPmL97_UMSU"
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__22_Apr_2008_13_50_05_+1000_GUlLMPPmL97_UMSU
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Tony,

On Tue, 22 Apr 2008 13:30:06 +1000 (EST) Tony Breeds <tony@bakeyournoodle.c=
om> wrote:
>
> +void __init initialise_pacas(void)
> +{
> +	int cpu;
> +	unsigned long kernel_toc =3D (unsigned long)(&__toc_start) + 0x8000UL;

This line could do with a comment saying what it is doing ...

> +++ b/include/asm-powerpc/paca.h
>
> +#if   NR_CPUS >=3D 32
> +#define NR_STATIC_PACAS	64

This allocates 64 pacas etc for NR_CPUS =3D=3D 32 so surely that test should
be >?

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__22_Apr_2008_13_50_05_+1000_GUlLMPPmL97_UMSU
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIDWBxTgG2atn1QN8RArUiAJ0TJqlfobdy2/KIyn7NIE+EI6aLrgCfYKuT
7Pz3zBzN8LXxZIPnneTFq/0=
=57Nl
-----END PGP SIGNATURE-----

--Signature=_Tue__22_Apr_2008_13_50_05_+1000_GUlLMPPmL97_UMSU--
