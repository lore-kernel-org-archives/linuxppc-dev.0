Return-Path: <haokexin@gmail.com>
Received: from mail-pa0-x22d.google.com (mail-pa0-x22d.google.com
 [IPv6:2607:f8b0:400e:c03::22d])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 30BD12C00A2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Sep 2013 10:59:06 +1000 (EST)
Received: by mail-pa0-f45.google.com with SMTP id rd3so4427548pab.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Sep 2013 17:59:02 -0700 (PDT)
Date: Wed, 25 Sep 2013 08:58:43 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v3 3/3] powerpc/85xx: use one kernel option for all the
 CoreNet_Generic boards
Message-ID: <20130925005843.GA20572@pek-khao-d1.corp.ad.wrs.com>
References: <1379991797-29222-1-git-send-email-haokexin@gmail.com>
 <1379991797-29222-4-git-send-email-haokexin@gmail.com>
 <1380062492.24959.123.camel@snotra.buserror.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="pWyiEgJYm5f9v55/"
In-Reply-To: <1380062492.24959.123.camel@snotra.buserror.net>
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2013 at 05:41:32PM -0500, Scott Wood wrote:
> On Tue, 2013-09-24 at 11:03 +0800, Kevin Hao wrote:
> > +	  and B4 QDS boards
[...]
>=20
> Is there any difference between the 32-bit and 64-bit versions of this
> config symbol, other than the help text?

No. As you know some of these boards only support 32bit kernel and some of
them only support 64bit kernel. It will definitely cause confusion when usi=
ng
only one kernel option for all these boards. So I divide this into two opti=
ons
(even the same name) for 32bit and 64bit respectively.

Thanks,
Kevin
>=20
> -Scott
>=20
>=20
>=20

--pWyiEgJYm5f9v55/
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJSQjVDAAoJEJNY7TDerrFx+ncH/3u1sprp0SRq0OV4vV+i/H+A
1c7gbzUYc00fTa55iQU1oNzjV0xTCZF+jpTd5Ff7KNwwohi5VsZJFswluo59Tejv
Ak3L0Em4hGDYQPByuOdGrXoKHcZgMVqNpT/367ZwLC38qEnJR9yd/4+vG+WT+LsP
Sy1v2lcNdeswN6a3GnBtHIf6UcNeyzu6wQoehnBM9WCSqgJQWCrTwx0FvwnoZMrJ
ZyrkYgGEIdO2XLDj4tEzjVLOXy/NpUqBK3QwAGl4xWjoa/se82/F3hrbZoErLgYL
YLwRxZAW6lu/IfIAZ/LfIjseeVyzVnIjcefArO/XolFCE/N2FY9YKC05BDHmj54=
=3kYl
-----END PGP SIGNATURE-----

--pWyiEgJYm5f9v55/--
