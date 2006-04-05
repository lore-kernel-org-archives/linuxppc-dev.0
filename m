Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id ED49E679E0
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Apr 2006 02:03:22 +1000 (EST)
Date: Thu, 6 Apr 2006 02:03:13 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 00/15] powerpc: move some header files
Message-Id: <20060406020313.186a74ad.sfr@canb.auug.org.au>
In-Reply-To: <C40B1083-7953-4104-8FA3-5B9B4EBE1A77@kernel.crashing.org>
References: <11442138494042-git-send-email-sfr@canb.auug.org.au>
	<C40B1083-7953-4104-8FA3-5B9B4EBE1A77@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__6_Apr_2006_02_03_13_+1000_w=Z7DNSiqt65fR2B"
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__6_Apr_2006_02_03_13_+1000_w=Z7DNSiqt65fR2B
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 5 Apr 2006 09:28:55 -0500 Kumar Gala <galak@kernel.crashing.org> wr=
ote:
>
> How about we do the following to remove the include hack:
>=20
> don't move the following (determine what needs them to build and =20
> fixup, I dont believe any of these need to exist at this point in =20
> arch/powerpc for it to build any supported arch/powerpc platform:

I only moved the files that were actually required to build the defconfigs
for the three 32 bit builds in arch/powerpc ...

>   b/include/asm-powerpc/amigappc.h  |    9 ++----
>   b/include/asm-powerpc/bootinfo.h  |    8 ++---
>   b/include/asm-powerpc/mpc8xx.h    |   10 +++---
>   b/include/asm-powerpc/ocp.h       |    7 ++--
>   b/include/asm-powerpc/ocp_ids.h   |    6 ++--
>   b/include/asm-powerpc/open_pic.h  |   10 +++---

So maybe I could attempt to remove the dependencies instead of moving the
files.  You are right that it is worth it if we can just get rid of these
files.

> Duplicate these headers (then I'll go through and clean them up, =20
> removing arch/ppc'ism):
>=20
>   b/include/asm-powerpc/mpc83xx.h   |    7 ++--
>   b/include/asm-powerpc/mpc85xx.h   |    9 ++----

I guess that would work, but Paulus is going to not like me as he already
put all these patches into the powerpc tree.  :-)

Something to keep me entertained for another day.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__6_Apr_2006_02_03_13_+1000_w=Z7DNSiqt65fR2B
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEM+pHFdBgD/zoJvwRAvSuAJ9PhD7pOYVgBBmVCXwGa24VigqMlwCfSC7i
p8D9+FSikpzPtEmRXIezmTE=
=NUhP
-----END PGP SIGNATURE-----

--Signature=_Thu__6_Apr_2006_02_03_13_+1000_w=Z7DNSiqt65fR2B--
