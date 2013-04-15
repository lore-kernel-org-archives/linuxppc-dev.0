Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.pcug.org.au [203.10.76.10])
 by ozlabs.org (Postfix) with ESMTP id 95D662C010D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Apr 2013 23:30:54 +1000 (EST)
Date: Mon, 15 Apr 2013 23:30:40 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 1/2] powerpc: remove section changes from _GLOBAL() and
 friends
Message-Id: <20130415233040.ca38e79ce08c519554baa865@canb.auug.org.au>
In-Reply-To: <20130415120016.GB12701@concordia>
References: <20121129105525.0e47b3b3e51aebe7ded3b7b6@canb.auug.org.au>
 <20130415120016.GB12701@concordia>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Mon__15_Apr_2013_23_30_40_+1000_VgNgDRebRV3OF2ZH"
Cc: Alan Modra <amodra@au1.ibm.com>, ppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Mon__15_Apr_2013_23_30_40_+1000_VgNgDRebRV3OF2ZH
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On Mon, 15 Apr 2013 22:00:17 +1000 Michael Ellerman <michael@ellerman.id.au=
> wrote:
>
> On Thu, Nov 29, 2012 at 10:55:25AM +1100, Stephen Rothwell wrote:
> > These sometimes produce unexpected results and make it hard to put the
> > start up code (for 64 bit) into the .head.text section.
>=20
> ...
>=20
> > diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel=
/head_fsl_booke.S
> > index 6f62a73..4ec5625 100644
> > --- a/arch/powerpc/kernel/head_fsl_booke.S
> > +++ b/arch/powerpc/kernel/head_fsl_booke.S
> > @@ -776,6 +776,8 @@ tlb_write_entry:
> >  	mfspr	r10, SPRN_SPRG_RSCRATCH0
> >  	rfi					/* Force context change */
> > =20
> > +	,text
> > +
>=20
> I'm assuming this should be .text ?

Indeed.  Oops :-)

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Mon__15_Apr_2013_23_30_40_+1000_VgNgDRebRV3OF2ZH
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJRbAEAAAoJEECxmPOUX5FEy+sQAJfiL300nfyPMjgiqTLoeYnq
TEicXYnZNn/zsApt58q4DoGP5G/JF3uF9Y/RSo0kRoUJUn9Z2zIw1Nz4sIMSXnJS
P4I2oRpdNWIgC8Hm2CmjynpiuprA5CSYg8CQ5prPSP91IlTvu2KFHgFFPhd2pIGQ
s8uQu3fahoNSX+0rPsRkuygb10YZ/YCppCzJmgxF2ATUf73T3DTcAEYMl9sS7FJR
SDSnYuRKHB9TC61EVA0sEJuzX10V9WOo9UE9AUaeJoA/YF84wTJTFr02/YNWGUBL
2eHuYCU2Wf3Zvv5Uy0AmXGa3Misvq5LgWm0P7d0LzJzJg9rsJLLTqdQvjwL+1GMQ
S5/e+lrvH6+iKAa1wGNL9UeHmbg3yKPwQlz/AqfbH04mPGly2OK9n1b+c9Ja87yN
4DONsxNnbG8nJHKtTBEitzWEmtaREKofmReFxd92N188n9VJkFdo3CzQwIPgvPrS
wHjuBNIqkgLjvuJb55bHMXqFRAHqhflhudLN+VFOBEWtt00caIeA/+FbWTMmDQG5
uRjo2QCV1493CBLXaUcG1WB/siKxHB2zGm9YgPjDMD49OhQIt6aAadBAGpOWXPDg
MOSzmFarxvAQxBXcW1oBKKDq4C87D5sD+VJQ3BQQgPneOEgcndGkXOuu9AUe8h9J
uJBss1hhmYW6Z7wZfuIi
=Xijt
-----END PGP SIGNATURE-----

--Signature=_Mon__15_Apr_2013_23_30_40_+1000_VgNgDRebRV3OF2ZH--
