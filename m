Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 8388FDDE25
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jul 2007 10:21:33 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 27/61] cpm2: Fix whitespace in cpm2_clk_setup().
Date: Thu, 19 Jul 2007 02:21:20 +0200
References: <20070718013534.GY15238@ld0162-tx32.am.freescale.net>
In-Reply-To: <20070718013534.GY15238@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200707190221.21405.arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 18 July 2007, Scott Wood wrote:
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
> =A0arch/powerpc/sysdev/cpm2_common.c | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/arch/powerpc/sysdev/cpm2_common.c b/arch/powerpc/sysdev/cpm2=
_common.c
> index 4e840bd..7e3a983 100644
> --- a/arch/powerpc/sysdev/cpm2_common.c
> +++ b/arch/powerpc/sysdev/cpm2_common.c
> @@ -233,7 +233,7 @@ int cpm2_clk_setup(enum cpm_clk_target target, int cl=
ock, int mode)
> =A0=A0=A0=A0=A0=A0=A0=A0}
> =A0
> =A0=A0=A0=A0=A0=A0=A0=A0if (mode =3D=3D CPM_CLK_RX)
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0shift +=3D3;
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0shift +=3D 3;
> =A0
> =A0=A0=A0=A0=A0=A0=A0=A0for (i =3D 0; i < ARRAY_SIZE(clk_map); i++) {
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (clk_map[i][0] =3D=3D =
target && clk_map[i][1] =3D=3D clock) {

While all your 61 patches look really good to me in general, I think you're=
 driving
the 'one patch per logical change' mantra a little too far. E.g. a number o=
f them
could simply have been consolidated under 'fix obvious coding style violati=
ons in
arch/powerpc'.

Having patches that fix a single whitespace bug only causes extra work for =
both
the author and the reviewer without much benefit.

	Arnd <><
