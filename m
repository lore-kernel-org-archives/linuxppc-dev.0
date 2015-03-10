Return-Path: <haokexin@gmail.com>
Received: from mail-qg0-x22b.google.com (mail-qg0-x22b.google.com
 [IPv6:2607:f8b0:400d:c04::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 027B41A03A0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2015 23:21:57 +1100 (AEDT)
Received: by qgdz60 with SMTP id z60so1194451qgd.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2015 05:21:55 -0700 (PDT)
Date: Tue, 10 Mar 2015 20:21:47 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: book3e_64: fix the align size for paca_struct
Message-ID: <20150310122147.GB8745@pek-khao-d1.corp.ad.wrs.com>
References: <1425726893-30605-1-git-send-email-haokexin@gmail.com>
 <1425806006.4636.223.camel@kernel.crashing.org>
 <20150309011314.GA13617@pek-khao-d1.corp.ad.wrs.com>
 <1425886285.4636.241.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="0eh6TmSyL6TZE2Uz"
In-Reply-To: <1425886285.4636.241.camel@kernel.crashing.org>
Cc: Scott Wood <scottwood@freescale.com>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
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

On Mon, Mar 09, 2015 at 06:31:25PM +1100, Benjamin Herrenschmidt wrote:
> On Mon, 2015-03-09 at 09:13 +0800, Kevin Hao wrote:
> > On Sun, Mar 08, 2015 at 08:13:26PM +1100, Benjamin Herrenschmidt wrote:
> > > On Sat, 2015-03-07 at 19:14 +0800, Kevin Hao wrote:
> > > > All the cache line size of the current book3e 64bit SoCs are 64 byt=
es.
> > > > So we should use this size to align the member of paca_struct.
> > > > With this change we save 192 bytes. Also change it to __aligned(siz=
e)
> > > > since it is preferred over __attribute__((aligned(size))).
> > >=20
> > > Why should we favor the book3e CPUs over the book3s ones ?
> >=20
> > Why do you think so? This only change the align size of the paca_struct=
's
> > members which are private to book3e CPUs, and should not have any effect
> > to book3s ones. Did I miss something?
>=20
> No, your explanation was lacking that important detail :-)

Sorry for the confusion, I will add this information in the commit log.

Thanks,
Kevin

--0eh6TmSyL6TZE2Uz
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJU/uHbAAoJEJNY7TDerrFxERgH/3qvBHYIIA3HzW+DbV8k7zcc
jMP84zm+WQFFqYwYIGCjpTSGWNaM+eUJzuRgvBjVT420SwqJ0aI7bkRS4q92XeM7
O2O27BN9y0qORddL0Xyn7L/LbxRl5GK16EVB1NhZEIqfythTJz1FXHuJQ5Wu/izS
ZkbbbgagKHHyHHGJQtZxkYG5VU3V/aj+34XCaQ9OwBHa4tmF4Eq9pgkw1jr6JAhK
UQmycxDQFVpEd0LaTldbPj8AgaX5dvXryMBwDvzB/+xdtM+HAlBqGgHmcDPt/+SN
lYuGd7AWiSeBR1pa1/GY98z2qh2GxeW8tvSQe2Og40DagkA6HZ89slUaIU2G+3I=
=88Ij
-----END PGP SIGNATURE-----

--0eh6TmSyL6TZE2Uz--
