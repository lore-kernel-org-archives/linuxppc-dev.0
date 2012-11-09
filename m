Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.tip.net.au
 [IPv6:2402:b800:7003:1::20])
 by ozlabs.org (Postfix) with ESMTP id 80B5A2C024D
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Nov 2012 20:27:05 +1100 (EST)
Date: Fri, 9 Nov 2012 20:26:55 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH 12/14] powerpc: Move get_longbusy_msecs into hvcall.h
 and remove duplicate function
Message-Id: <20121109202655.3a2b2876b97b39c581a36637@canb.auug.org.au>
In-Reply-To: <1352441953-29096-14-git-send-email-mikey@neuling.org>
References: <1352441953-29096-1-git-send-email-mikey@neuling.org>
 <1352441953-29096-14-git-send-email-mikey@neuling.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Fri__9_Nov_2012_20_26_55_+1100_S5=19UW3_7ZqS/k5"
Cc: linuxppc-dev@lists.ozlabs.org, Ian Munsie <imunsie@au1.ibm.com>,
 Matt Evans <matt@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Fri__9_Nov_2012_20_26_55_+1100_S5=19UW3_7ZqS/k5
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Mikey,

On Fri,  9 Nov 2012 17:19:11 +1100 Michael Neuling <mikey@neuling.org> wrot=
e:
>
> From: Ian Munsie <imunsie@au1.ibm.com>
>=20
> I am going to use this in the next patch, better to have this code in
> one place rather than three.
>=20
> Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> ---
>  arch/powerpc/include/asm/hvcall.h         |   20 ++++++++++++++++++++
>  drivers/infiniband/hw/ehca/hcp_if.c       |   20 --------------------
>  drivers/net/ethernet/ibm/ehea/ehea_phyp.h |   20 --------------------
>  3 files changed, 20 insertions(+), 40 deletions(-)

This is identical to patch 10/14 ...

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__9_Nov_2012_20_26_55_+1100_S5=19UW3_7ZqS/k5
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJQnMxgAAoJEECxmPOUX5FETpYP/A47wXjtk1cT0IaPhyXAyiLE
K3ic9ikYe0cMJhhkC2D8l6IXXtfQw2uxV1n5HTlxSe4mOTWj0PZ7gPHUyjyaJdvF
ZxTntHredPwhTKVeUwKtwbtEp+oVzlD/OyXon+0f9JQuaSDS0bh9JTraacyFBr22
IjwQH5q5I0Ab0iBrkhCmwWvDQat8wwQgD6U+gbuWp6WkadCFG9m+cMALngnwZG2R
N/DvAXJSGrGt/cVZFvqo67D5nGftE5lI9COcqmN8peVt40jYeVATbJCSF3pFQmb6
URqbnTvseQbhFFrVAT8GSBqE5NZXWgKRrYTgprFT4BBymlR9oDfYJGusYTTzpS4q
FeieQCB8HZyzaY0+76DtwrtZr4NPQ9v2E4jOU+xm3ApgCaXJ7SWUEXVUqwT0AV6d
AZkamKdW+WEcaaISnCcNj39E99MX1BhK14KRC6Q7/5uh1Nj6wNI4xh9dTTW5xpGw
f6JALQ1prxG1fM1RuvlGiGkq8aXNvyMmmoJH/khOT5DjPMiFIJ/W9WiN4WsIlUCs
FDHujJSzNJz+iRvZ14xuwYaja8thkNBTMMCvPIDwaK3+YBaeCRyuuPDjyWiqNlEc
eJs928HtdPm1YvMrroFlb7YM+W/fUYufzXypzXoZsG+q0GIHYXPUhvXRsgqm+Jra
OZDcl+PyQ9YnIlYoY+3U
=+LrI
-----END PGP SIGNATURE-----

--Signature=_Fri__9_Nov_2012_20_26_55_+1100_S5=19UW3_7ZqS/k5--
