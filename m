Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 65020DE2D3
	for <linuxppc-dev@ozlabs.org>; Thu,  1 May 2008 01:47:27 +1000 (EST)
Date: Thu, 1 May 2008 01:47:18 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] Xilinx: Fix compile warnings
Message-Id: <20080501014718.bca63e31.sfr@canb.auug.org.au>
In-Reply-To: <Pine.LNX.4.64.0804301025270.19599@blarg.am.freescale.net>
References: <Pine.LNX.4.64.0804301025270.19599@blarg.am.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__1_May_2008_01_47_18_+1000_to.AQ/A656P6K_V="
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__1_May_2008_01_47_18_+1000_to.AQ/A656P6K_V=
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Kumar,

On Wed, 30 Apr 2008 10:25:46 -0500 (CDT) Kumar Gala <galak@kernel.crashing.=
org> wrote:
>
> arch/powerpc/sysdev/xilinx_intc.c: In function =C3=A2=C2=80=C2=98xilinx_i=
ntc_init=C3=A2=C2=80=C2=99:
> arch/powerpc/sysdev/xilinx_intc.c:111: warning: format =C3=A2=C2=80=C2=98=
%08X=C3=A2=C2=80=C2=99 expects type =C3=A2=C2=80=C2=98unsigned int=C3=A2=C2=
=80=C2=99, but argument 2 has type =C3=A2=C2=80=C2=98resource_size_t=C3=A2=
=C2=80=C2=99
> drivers/char/xilinx_hwicap/xilinx_hwicap.c: In function =C3=A2=C2=80=C2=
=98hwicap_setup=C3=A2=C2=80=C2=99:
> drivers/char/xilinx_hwicap/xilinx_hwicap.c:626: warning: cast to pointer =
from integer of different size
> drivers/char/xilinx_hwicap/xilinx_hwicap.c:646: warning: format =C3=A2=C2=
=80=C2=98%x=C3=A2=C2=80=C2=99 expects type =C3=A2=C2=80=C2=98unsigned int=
=C3=A2=C2=80=C2=99, but argument 6 has type =C3=A2=C2=80=C2=98resource_size=
_t=C3=A2=C2=80=C2=99

If you compile with LANG=3DC, you don't get those strange annotations in
your error messages ...

The fix looks good though.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__1_May_2008_01_47_18_+1000_to.AQ/A656P6K_V=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIGJSLTgG2atn1QN8RAkP0AJ0SEk3BEomlrYwWvJsMqcZnxJRYwACfayqO
BGmNBSHCjCFtBLOOI2Q1UY0=
=McFr
-----END PGP SIGNATURE-----

--Signature=_Thu__1_May_2008_01_47_18_+1000_to.AQ/A656P6K_V=--
