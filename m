Return-Path: <haokexin@gmail.com>
Received: from mail-qa0-x230.google.com (mail-qa0-x230.google.com
 [IPv6:2607:f8b0:400d:c00::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6C2531A0001
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Feb 2015 12:06:02 +1100 (AEDT)
Received: by mail-qa0-f48.google.com with SMTP id dc16so10635312qab.7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Feb 2015 17:05:59 -0800 (PST)
Date: Fri, 27 Feb 2015 09:05:49 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 03/15] fbdev: aty128fb: replace PPC_OF with PPC
Message-ID: <20150227010549.GA10596@pek-khao-d1.corp.ad.wrs.com>
References: <1422712065-9403-1-git-send-email-haokexin@gmail.com>
 <1422712065-9403-4-git-send-email-haokexin@gmail.com>
 <1424995875.4645.42.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
In-Reply-To: <1424995875.4645.42.camel@kernel.crashing.org>
Cc: linux-fbdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Tomi Valkeinen <tomi.valkeinen@ti.com>, Paul Mackerras <paulus@samba.org>,
 Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 27, 2015 at 11:11:15AM +1100, Benjamin Herrenschmidt wrote:
> On Sat, 2015-01-31 at 21:47 +0800, Kevin Hao wrote:
> > The PPC_OF is a ppc specific option which is used to mean that the
> > firmware device tree access functions are available. Since all the
> > ppc platforms have a device tree, it is aways set to 'y' for ppc.
> > So it makes no sense to keep a such option in the current kernel.
> > Replace it with PPC.
> >=20
> > Signed-off-by: Kevin Hao <haokexin@gmail.com>
>=20
> For this and generally the whole series,
>=20
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Thanks Ben.

>=20
> Which tree do we expect this to go through ?

I just sent out a v2 [1] a few hours earlier with some minor updates. We pl=
an
to merge this patch series via the powerpc tree in 4.1 cycle if I can colle=
ct
all the acks from the corresponding driver maintainers.

[1] https://lists.ozlabs.org/pipermail/linuxppc-dev/2015-February/125331.ht=
ml

Thanks,
Kevin

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJU78LtAAoJEJNY7TDerrFxz1wH/RHF9qNesB2DqntsnRqlVQiG
t7aFJPo+T8IHvGKlt6w8RXMoUHFHj7hB9jjB86s+Pfl63eB6qIc5qvD8ty8eBk4a
98hzmB8RuyEsKu0mC9bZVSYLYFr9wkbNhHMJNRAlmndk08shS82JNVU3bmLQXQOG
z2CheuW1l7x6N508hTWgeXPZd8aHHwsZAVwdC3Wm9YLxPnvwWiWS05wNKvzyk5NI
NSZ2drghdtATkSTrBLCaHVwl4P3ksKnK/KsX0lm+r9pMzh+4grqmoKejJRwEtWa4
k5soQWcl4fTwV6ein/X8QgMPbR6uShsXjFbi0qDDnlrEm+6+Ev+HfvXQGEBUIMA=
=cfO6
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--
