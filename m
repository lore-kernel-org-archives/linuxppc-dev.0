Return-Path: <haokexin@gmail.com>
Received: from mail-qg0-x22c.google.com (mail-qg0-x22c.google.com
 [IPv6:2607:f8b0:400d:c04::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1D6991A0701
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2015 15:38:30 +1100 (AEDT)
Received: by qgfh3 with SMTP id h3so7345076qgf.13
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2015 21:38:28 -0700 (PDT)
Date: Wed, 11 Mar 2015 12:38:11 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 03/15] fbdev: aty128fb: replace PPC_OF with PPC
Message-ID: <20150311043811.GF28582@pek-khao-d1.corp.ad.wrs.com>
References: <1422712065-9403-1-git-send-email-haokexin@gmail.com>
 <1422712065-9403-4-git-send-email-haokexin@gmail.com>
 <1424995875.4645.42.camel@kernel.crashing.org>
 <20150227010549.GA10596@pek-khao-d1.corp.ad.wrs.com>
 <54FEE230.6030006@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="jaoouwwPWoQSJZYp"
In-Reply-To: <54FEE230.6030006@ti.com>
Cc: linux-fbdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Paul Mackerras <paulus@samba.org>,
 Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--jaoouwwPWoQSJZYp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2015 at 02:23:12PM +0200, Tomi Valkeinen wrote:
> > I just sent out a v2 [1] a few hours earlier with some minor updates. W=
e plan
> > to merge this patch series via the powerpc tree in 4.1 cycle if I can c=
ollect
> > all the acks from the corresponding driver maintainers.
>=20
> Fbdev changes look ok to me.

Hi Tomi,

I assume that I can add a "Acked-by: Tomi Valkeinen <tomi.valkeinen@ti.com>"
for all the following patches, right?
  http://patchwork.ozlabs.org/patch/443890/
  http://patchwork.ozlabs.org/patch/443891/
  http://patchwork.ozlabs.org/patch/443892/
  http://patchwork.ozlabs.org/patch/443893/
  http://patchwork.ozlabs.org/patch/443894/
  http://patchwork.ozlabs.org/patch/443895/
  http://patchwork.ozlabs.org/patch/443897/

Thanks,
Kevin

--jaoouwwPWoQSJZYp
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJU/8azAAoJEJNY7TDerrFxM0gIAMU/onSFczQCkrA765tFAUmb
MeySoXOfj1z6FI2aU65Buylgo9Q7J1AUoj3wLlKHVPhNVaXKM8jJFVl+ovs87adf
8GERHXxa1x7lxuEuBQEoK/NUF8wUY5RzHBDbKkf3pPIDBj9P0y1mL/LXftQxi0mg
2/Nyjg9qxkarMStPerflmY7mLHnHgGKD/jwyqSJZugI1nwPh3iVJtodl2i2FKj20
qjuk/xb9zw67VMrUdUmdRq2OzRe930YcW54psQYknWuya9NqIVQSyTCgeI4SqJZM
YE2iC9wOzP/G7WfCLYJYzdU2dN0UiY/tKnd0D8Fy8ru/n2w0z7VEM3xc0ZerdRo=
=i1Om
-----END PGP SIGNATURE-----

--jaoouwwPWoQSJZYp--
