Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 08D3FDDE9D
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Aug 2007 02:19:24 +1000 (EST)
Date: Sat, 18 Aug 2007 02:19:17 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] Fix 8xx compile failure
Message-Id: <20070818021917.142f0c45.sfr@canb.auug.org.au>
In-Reply-To: <6E87D0B2-29EB-4068-9BF0-F8373C61B256@kernel.crashing.org>
References: <Pine.LNX.4.64.0708170823150.31758@blarg.am.freescale.net>
	<20070818015542.b8e2df67.sfr@canb.auug.org.au>
	<6E87D0B2-29EB-4068-9BF0-F8373C61B256@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Sat__18_Aug_2007_02_19_17_+1000_2nt3xHk7WZtbX6+S"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Sat__18_Aug_2007_02_19_17_+1000_2nt3xHk7WZtbX6+S
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Kumar,

On Fri, 17 Aug 2007 11:11:20 -0500 Kumar Gala <galak@kernel.crashing.org> w=
rote:
>
> On Aug 17, 2007, at 10:55 AM, Stephen Rothwell wrote:
>=20
> > On Fri, 17 Aug 2007 08:24:02 -0500 (CDT) Kumar Gala =20
> > <galak@kernel.crashing.org> wrote:
> >>
> >> diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/=20
> >> fsl_soc.c
> >> index 727453d..f6943fc 100644
> >> --- a/arch/powerpc/sysdev/fsl_soc.c
> >> +++ b/arch/powerpc/sysdev/fsl_soc.c
> >> @@ -36,6 +36,7 @@
> >>  #include <sysdev/fsl_soc.h>
> >>  #include <mm/mmu_decl.h>
> >>  #include <asm/cpm2.h>
> >> +#include <asm/of_platform.h>
> >
> > linux/of_platform.h should be used these days.
>=20
> ok fixed.

I notice that the master branch of your tree has both includes in this
file now :-)  Git's merges are not always perfect.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sat__18_Aug_2007_02_19_17_+1000_2nt3xHk7WZtbX6+S
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGxcqLTgG2atn1QN8RAjgVAKCFdM0PIwTO2B5900GDvvnK+IgbZACcCnx4
YJiE5o5un+rvATc+8n7xoLc=
=+l7f
-----END PGP SIGNATURE-----

--Signature=_Sat__18_Aug_2007_02_19_17_+1000_2nt3xHk7WZtbX6+S--
