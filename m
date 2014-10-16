Return-Path: <haokexin@gmail.com>
Received: from mail-pa0-x229.google.com (mail-pa0-x229.google.com
 [IPv6:2607:f8b0:400e:c03::229])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7AD551A037E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Oct 2014 09:31:34 +1100 (AEDT)
Received: by mail-pa0-f41.google.com with SMTP id eu11so4286670pac.28
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Oct 2014 15:31:32 -0700 (PDT)
Date: Fri, 17 Oct 2014 06:31:24 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 0/2] fix a kernel panic on fsl corenet board when
 CONFIG_CLK_PPC_CORENET is enabled
Message-ID: <20141016223124.GA9593@pek-khao-d1.corp.ad.wrs.com>
References: <1413458321-23880-1-git-send-email-haokexin@gmail.com>
 <1413496162.7417.9.camel@aoeu.buserror.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
In-Reply-To: <1413496162.7417.9.camel@aoeu.buserror.net>
Cc: Jingchang Lu <jingchang.lu@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 Mike Turquette <mturquette@linaro.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2014 at 11:49:22PM +0200, Scott Wood wrote:
> On Thu, 2014-10-16 at 19:18 +0800, Kevin Hao wrote:
> > Hi,
> >=20
> > This tries to fix a kernel panic introduced by commit da788acb2838
> > ("clk: ppc-corenet: Fix Section mismatch warning").
>=20
> That patch is just wrong and should be reverted, separately from any new
> attempt to fix the section mismatch warning.

OK, I will make a patch to revert that first.

Thanks,
Kevin

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUQEc8AAoJEJNY7TDerrFxNnMIAM8rAgnKuBf9Jl/oBWfwLbS4
Abgv/IvS7k2/E8aLA4T6OUfrUgbPjUb7YAT23bSVVfO1oNvl5BUPiJ2upIxGVjWM
0H8lGWUGf1Lah9U8IUAUf2JIRO0zVY2RtzUxnaVqwHofF6S11smEkVWs6sCKPteT
G82+IuFpopyS6E94yL9dlgKZcCL/j94vNCPAbfYxAIyPbvgUNkdsoIpP0fT8y6QO
Hyepkc/AqNApA86EeOJdeahfGIytzOQSECm965O533zz7HX05WjaQ111aXt0LvWl
7m7CuK3LU9nCMPAcJN5mp+U//NVxhL/RJkeNp73RUXclxrKFbbnw9R4ZmmEzbXs=
=exgM
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--
