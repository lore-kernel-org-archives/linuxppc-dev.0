Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 65A951A0044
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Jul 2014 10:55:20 +1000 (EST)
Date: Tue, 1 Jul 2014 10:55:10 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] powerpc: Disable RELOCATABLE for COMPILE_TEST with PPC64
Message-ID: <20140701105510.75718b47@canb.auug.org.au>
In-Reply-To: <1404153930-26568-1-git-send-email-linux@roeck-us.net>
References: <1404153930-26568-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Ah16V83Qnbn0RGe8./=uM8U"; protocol="application/pgp-signature"
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Sig_/Ah16V83Qnbn0RGe8./=uM8U
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Guenter,

On Mon, 30 Jun 2014 11:45:30 -0700 Guenter Roeck <linux@roeck-us.net> wrote:
>
> powerpc:allmodconfig has been failing for some time with the following
> error.
>=20
> arch/powerpc/kernel/exceptions-64s.S: Assembler messages:
> arch/powerpc/kernel/exceptions-64s.S:1312: Error: attempt to move .org ba=
ckwards
> make[1]: *** [arch/powerpc/kernel/head_64.o] Error 1
>=20
> A number of attempts to fix the problem by moving around code have been
> unsuccessful and resulted in failed builds for some configurations and
> the discovery of toolchain bugs.
>=20
> Fix the problem by disabling RELOCATABLE for COMPILE_TEST builds instead.
> While this is less than perfect, it avoids substantial code changes
> which would otherwise be necessary just to make COMPILE_TEST builds
> happy and might have undesired side effects.
>=20
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

I'll dump this in my "fixes" tree today and see how it goes.

Thanks.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Sig_/Ah16V83Qnbn0RGe8./=uM8U
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJTsgb3AAoJEMDTa8Ir7ZwVK7YP/iIJm2oErendYz15HW/RVRoU
BxQQtaYNlBF7CeOaJPtgP1GPtwNaSJdPDIdv97BMAx97A4vs8+/kfV6eG02/J78x
e0CMaI5XFDjCqLnqw6e/x7R0Vzp/9q+7dSuzZ/DyCUJ2GUVCyondFixpVXGbjzzu
PZ677a1DCR2DsZ4DKyg59I93XPbu3Kmj1mvmbvBvN2Y20aIewYOnVlhZ5bLYWHkw
3dcxDrAYdkQtIp1TmOchyc7iSLCMnZTK8iJ0E4CkN3Mk+GczmXc5JLmxpxvj3fS2
o7tGRPTWQbw3uZh74iV+NLmqGTuxknwuyxEAgWga+Ybb7/psgBYvQR8clxCFFp14
0ji3o/Zqr/LXlyGE1IlxLLP5W70Vk61ob9uvlEnFHDloB5yvGWrGC8dVlD7GcWnj
TiW0PBzXqJCwqecH17azb4npJRJ7aTN2Evx08SIzOZy9/1x+xWmFhTgCNGgIgvYG
YR8ZX43WV487FFwQQgGiVOGKWOr4gO9oD8ATZ7UfyLUPzTfk5FgHZNeeCwx8Kvor
Z+Ki5xmykJv6d5nST/KktgK/w/nJBLbhQVTWE7pmiK4mw18Y6T3ecf/v8ZYvWq3g
0QDDbXSj2p6Gl4EDWlSzBPa6/5Y//CtlWMp7ZTZtjlOYXct8CmI83wWIghU/PiJd
wTuayw0kws7LMJJkAMr4
=MSVq
-----END PGP SIGNATURE-----

--Sig_/Ah16V83Qnbn0RGe8./=uM8U--
