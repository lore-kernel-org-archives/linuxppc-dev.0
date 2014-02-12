Return-Path: <haokexin@gmail.com>
Received: from mail-pb0-x232.google.com (mail-pb0-x232.google.com
 [IPv6:2607:f8b0:400e:c01::232])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7ACCC2C00BA
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Feb 2014 22:33:17 +1100 (EST)
Received: by mail-pb0-f50.google.com with SMTP id rq2so9145970pbb.37
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Feb 2014 03:33:12 -0800 (PST)
Date: Wed, 12 Feb 2014 19:32:52 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: Linux-3.14-rc2: Order of serial node compatibles in DTS files.
Message-ID: <20140212113252.GE15434@pek-khao-d1.corp.ad.wrs.com>
References: <OF6F6A0029.3B20EF5B-ONCA257C7C.0071BFDA-CA257C7C.00732AD3@csc.com>
 <63AEBD99-AA87-4FD7-BBDA-0CE419959F14@kernel.crashing.org>
 <52FAA97F.4060600@gmail.com>
 <1392162080.6733.404.camel@snotra.buserror.net>
 <52FAB65C.4090201@gmail.com>
 <OF9BA019D5.46DA1E29-ONCA257C7D.000089EA-CA257C7D.00020333@csc.com>
 <20140212052816.GA15434@pek-khao-d1.corp.ad.wrs.com>
 <52FB3108.3000202@gmail.com>
 <20140212103153.GC15434@pek-khao-d1.corp.ad.wrs.com>
 <52FB5A56.2050402@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="EXKGNeO8l0xGFBjy"
In-Reply-To: <52FB5A56.2050402@gmail.com>
Cc: Chris Proctor <cproctor@csc.com.au>, Arnd Bergmann <arnd@arndb.de>,
 devicetree <devicetree@vger.kernel.org>,
 Stephen N Chivers <schivers@csc.com.au>, Scott Wood <scottwood@freescale.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--EXKGNeO8l0xGFBjy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2014 at 12:26:14PM +0100, Sebastian Hesselbarth wrote:
> You can cook it down to:
>=20
> 	m =3D matches;
> 	/* Check against matches without compatible string */
> 	while (m->name[0] || m->type[0] || m->compatible[0]) {
> 		if (!m->compatible[0] && of_match_type_or_name(node, m)
> 			return m;
> 		m++;
> 	}

Will do.

Thanks,
Kevin

--EXKGNeO8l0xGFBjy
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAEBAgAGBQJS+1vkAAoJEJNY7TDerrFxuPAH/35IeHA5uhRgxvf6ivmqyALw
KocnO/HzKq55W94q57jrqMlflZFKUe0wBGeF33fdJZD7g1ugdQXDXSGESiMWjIUh
jW3KNq164Fz5DbU17lWMX66pOzOgKzCFlotmQJkOKWFTnPSUOU9HXf6Ff0RtRdRT
1xcotJKHFekTv8ug2VCmcQiU/k7b4SXBrS+7PDYoXWNtRHrOhYb020mzR75EIVe2
Cml9dU4YpXzlo/nOXWt5Fl++MgDQhClt95eZP8xIuXSu117OuC2RleBww55A8W+h
E+/V5dkso+dRB50U0xB0i2lyxzbBfUzpLT6nRKs09gTMRu3bgAcOqvIQYeVEmTo=
=qUn6
-----END PGP SIGNATURE-----

--EXKGNeO8l0xGFBjy--
