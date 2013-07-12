Return-Path: <haokexin@gmail.com>
Received: from mail-pd0-x234.google.com (mail-pd0-x234.google.com
 [IPv6:2607:f8b0:400e:c02::234])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id F3E832C0326
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jul 2013 15:06:07 +1000 (EST)
Received: by mail-pd0-f180.google.com with SMTP id 10so8126162pdi.39
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jul 2013 22:06:04 -0700 (PDT)
Date: Fri, 12 Jul 2013 13:05:54 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/2] powerpc/math-emu: keep track of the instructions
 unimplemented by FPU
Message-ID: <20130712050554.GC32154@pek-khao-d1.corp.ad.wrs.com>
References: <1373545315-9219-1-git-send-email-haokexin@gmail.com>
 <1373545315-9219-3-git-send-email-haokexin@gmail.com>
 <1373546721.19894.90.camel@pasglop>
 <20130712020749.GA32154@pek-khao-d1.corp.ad.wrs.com>
 <1373601363.19894.134.camel@pasglop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="t0UkRYy7tHLRMCai"
In-Reply-To: <1373601363.19894.134.camel@pasglop>
Cc: Scott Wood <scottwood@freescale.com>,
 linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--t0UkRYy7tHLRMCai
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2013 at 01:56:03PM +1000, Benjamin Herrenschmidt wrote:
> On Fri, 2013-07-12 at 10:07 +0800, Kevin Hao wrote:
> > There are two invocations of do_mathemu() in the traps.c. The one in the
> > function program_check_exception() doesn't call the PPC_WARN_EMULATED.
> > This is also the one I try to fix. Of course my patch will definitely c=
orrupt
> > the one in function SoftwareEmulation(). I will respin a new patch to
> > fix this. Sorry for my mistake.
>=20
> Put the call in the caller (in program_check_exception). It keeps the code
> in math-emu simpler and is consistent with what we do elsewhere.

Sure. V2 coming soon.

Thanks,
Kevin

>=20
> Cheers,
> Ben.
>=20
>=20

--t0UkRYy7tHLRMCai
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJR346yAAoJEJNY7TDerrFxvfkH/0tlMDqK74Urg/ls4LCd2sdU
kLUk+TFKDL2R63Vle3rDx4H+ex/uWR6uhTNxObjAtWfcYJuqH3QV3uAZqbJB9f1q
bIdSTxQc8vSDLV+BU4JReaX9Ug2yJE//KicyZEkFtOq8rjrs3sEuSPnq/lT5ilad
DGMVjt8RiSco2AgCoGKtOa/PXYmuRBS5/ZfFLiwZpO7dLwJHogLyp0iCx7Ml4W2C
biK6zQrR1Y/IQLvQrRyPmWoIlc2iV9BX5Vyy/pcNXbfFw53i8gAP4huiDB/K2o4b
GY+91GQlf6PeUw2W3er54zgKOlot3lb8Dy0vE3QpXaBNviZ9MPopC94WBhrvEOQ=
=pQLw
-----END PGP SIGNATURE-----

--t0UkRYy7tHLRMCai--
