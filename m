Return-Path: <haokexin@gmail.com>
Received: from mail-pa0-x233.google.com (mail-pa0-x233.google.com
 [IPv6:2607:f8b0:400e:c03::233])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F342B1A01C9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Oct 2014 09:35:07 +1100 (AEDT)
Received: by mail-pa0-f51.google.com with SMTP id lj1so4236583pab.24
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Oct 2014 15:35:06 -0700 (PDT)
Date: Fri, 17 Oct 2014 06:34:58 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/2] powerpc: move ppc_init() to common place
Message-ID: <20141016223458.GB9593@pek-khao-d1.corp.ad.wrs.com>
References: <1413458321-23880-1-git-send-email-haokexin@gmail.com>
 <1413458321-23880-2-git-send-email-haokexin@gmail.com>
 <1413496486.7417.11.camel@aoeu.buserror.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="0eh6TmSyL6TZE2Uz"
In-Reply-To: <1413496486.7417.11.camel@aoeu.buserror.net>
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


--0eh6TmSyL6TZE2Uz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2014 at 11:54:46PM +0200, Scott Wood wrote:
> On Thu, 2014-10-16 at 19:18 +0800, Kevin Hao wrote:
> > So they can be used by ppc64 board. Also remove the unneeded {} to
> > make checkpatch happy.
> >=20
> > Signed-off-by: Kevin Hao <haokexin@gmail.com>
> > ---
> >  arch/powerpc/include/asm/machdep.h |  2 +-
> >  arch/powerpc/kernel/setup-common.c | 15 +++++++++++++++
> >  arch/powerpc/kernel/setup_32.c     | 15 ---------------
> >  3 files changed, 16 insertions(+), 16 deletions(-)
>=20
> This is unnecessary -- why not just use machine_arch_initcall?

OK, I will drop this patch.

Thanks,
Kevin

--0eh6TmSyL6TZE2Uz
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUQEgSAAoJEJNY7TDerrFxIf8H/3ySCc0xkIfTmO7olrLxzZ7L
DofEXUrIFPXoIsM082KrIDck7YWIj+oZPYJIZBEdwUQ5RafVPgdxak/SjE63GJgJ
eSa36JlIQL2ncpEUaLSIgg+M9atuXszldCPz5oXpVA8LP/7z/NamA5xavE1ecAdb
P8QZQKwmwd8NmjtW4cJGimwTPHK26EuL7JZhuQBgHd5c3/3yim3hhn7oaolDskxM
rkO2M2SN3lf6KH9zwohiWOV4eO1LUg673Wd6RLoJ9xE1Wb711E41cv7gojAiGK+P
3ey5SQVNjfJSraDmsw0v4Gg+uMzEq1qwHEmYFzBuYwdb8tieIkjUBVKztMF1x50=
=rwhA
-----END PGP SIGNATURE-----

--0eh6TmSyL6TZE2Uz--
