Return-Path: <haokexin@gmail.com>
Received: from mail-pb0-x22c.google.com (mail-pb0-x22c.google.com
 [IPv6:2607:f8b0:400e:c01::22c])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0C3972C009D
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Jul 2013 22:00:05 +1000 (EST)
Received: by mail-pb0-f44.google.com with SMTP id uo1so4220048pbc.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Jul 2013 05:00:02 -0700 (PDT)
Date: Mon, 8 Jul 2013 19:59:52 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Kumar Gala <galak@kernel.crashing.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Scott Wood <scottwood@freescale.com>
Subject: question about the e200 support
Message-ID: <20130708115951.GD1005@pek-khao-d1.corp.ad.wrs.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="hxkXGo8AKqTJ+9QI"
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--hxkXGo8AKqTJ+9QI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

It seems that Kumar added the e200 core support for linux in 2005. But we
never add a e200 board since then. I doubt if anyone will do that in the
future. Is this just reserved for out of tree users? If not, how about
drop the e200 core support from kernel? It will definitely make the
e500 code more readable without all these useless #ifdef for CONFIG_E200.
What are you guys opinions?

Thanks,
Kevin

--hxkXGo8AKqTJ+9QI
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJR2qm3AAoJEJNY7TDerrFxUy8H/2r6m5B69bkR/Dzx/+KmUEFd
MMlumMfZ64TpcnWGE3z9SDgVduxpNyKge6fGEeuB+EpmR7PkP315nMtLGvtrI5U9
WaeUdhYLRiHcfKgcCpcBPydKGfYWnsAaRM56owLr4zs8ATgWg+bnx3k5P+k4XfWM
x3lSxTvOC/++1/Tix0GJPwKEFKb1NWhc4eDutT4do/hjkQtAOTQDKrhs0hzSI2qy
P6JFD3a0lITxBDghsmKJMG9wGpTjfIT90wzf1KE88JFzWvfDbW+qpBly4L4dfxYV
kHccY1J1CQT4sjAVbM1WHmNt1cLUkXDD3O6mXcLIKc4XF5QLqTVrBE3wyN/F6DQ=
=3oOk
-----END PGP SIGNATURE-----

--hxkXGo8AKqTJ+9QI--
