Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 051E4B7B69
	for <linuxppc-dev@ozlabs.org>; Sun, 18 Oct 2009 23:37:55 +1100 (EST)
Date: Sun, 18 Oct 2009 23:37:49 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH 2/3] powerpc: Create PPC_WARN_ALIGNMENT to match
	PPC_WARN_EMULATED
Message-Id: <20091018233749.0a17ff78.sfr@canb.auug.org.au>
In-Reply-To: <20091018111126.GL4808@kryten>
References: <20091018110929.GK4808@kryten>
	<20091018111126.GL4808@kryten>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Sun__18_Oct_2009_23_37_49_+1100_hhor9XLfdVfYPguI"
Cc: a.p.zijlstra@chello.nl, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, paulus@samba.org, mingo@elte.hu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Sun__18_Oct_2009_23_37_49_+1100_hhor9XLfdVfYPguI
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Anton,

On Sun, 18 Oct 2009 22:11:26 +1100 Anton Blanchard <anton@samba.org> wrote:
>
> @@ -66,8 +66,12 @@ extern void ppc_warn_emulated_print(cons
> =20
>  #else /* !CONFIG_PPC_EMULATED_STATS */
> =20
> -#define PPC_WARN_EMULATED(type)	do { } while (0)
> +#define __PPC_WARN_EMULATED(type)	do { } while (0)
> +#define __PPC_WARN_ALIGNMENT(type)	do { } while (0)

I think this last line is not needed?

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sun__18_Oct_2009_23_37_49_+1100_hhor9XLfdVfYPguI
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkrbDB0ACgkQjjKRsyhoI8xEIQCggsBJxLWjQl03PpJo4bGUJZOl
1WMAn3KZuaX751h1SrDhXxiJBnDmY/l9
=TRv2
-----END PGP SIGNATURE-----

--Signature=_Sun__18_Oct_2009_23_37_49_+1100_hhor9XLfdVfYPguI--
