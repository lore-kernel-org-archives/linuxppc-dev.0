Return-Path: <dedekind1@gmail.com>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
 [209.85.161.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 481FEB7151
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Dec 2011 21:22:27 +1100 (EST)
Received: by ggnv5 with SMTP id v5so6191653ggn.38
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Dec 2011 02:22:23 -0800 (PST)
Message-ID: <1324549440.10300.74.camel@sauron.fi.intel.com>
Subject: RE: [PATCH 1/2] mtd/nand: fixup for fmr initialization of Freescale
 NAND controller
From: Artem Bityutskiy <dedekind1@gmail.com>
To: Liu Shengzhou-B36685 <B36685@freescale.com>
Date: Thu, 22 Dec 2011 12:24:00 +0200
In-Reply-To: <3F453DDFF675A64A89321A1F352810216C9D5C@039-SN1MPN1-005.039d.mgd.msft.net>
References: <1323682853-10750-1-git-send-email-Shengzhou.Liu@freescale.com>
 <1324133097.4240.32.camel@sauron.fi.intel.com>
 <3F453DDFF675A64A89321A1F352810216C9D5C@039-SN1MPN1-005.039d.mgd.msft.net>
Content-Type: multipart/signed; micalg="pgp-sha1";
 protocol="application/pgp-signature";
 boundary="=-hKQ4YhiJxusiMRUOX8cp"
Mime-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 Gala Kumar-B11780 <B11780@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>
Reply-To: dedekind1@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-hKQ4YhiJxusiMRUOX8cp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2011-12-20 at 06:40 +0000, Liu Shengzhou-B36685 wrote:
> > -----Original Message-----
> > From: Artem Bityutskiy [mailto:dedekind1@gmail.com]
> > Sent: Saturday, December 17, 2011 10:45 PM
> > To: Liu Shengzhou-B36685
> > Cc: linuxppc-dev@lists.ozlabs.org; Wood Scott-B07421;
> > dwmw2@infradead.org; Gala Kumar-B11780; linux-mtd@lists.infradead.org
> > Subject: Re: [PATCH 1/2] mtd/nand: fixup for fmr initialization of
> > Freescale NAND controller
> >=20
> > On Mon, 2011-12-12 at 17:40 +0800, Shengzhou Liu wrote:
> > > There was a bug for fmr initialization, which lead to  fmr was always
> > > 0x100 in fsl_elbc_chip_init() and caused FCM command timeout before
> > > calling fsl_elbc_chip_init_tail(), now we initialize CWTO to maximum
> > > timeout value and not relying on the setting of bootloader.
> > >
> > > Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
> >=20
> > Pushed both to l2-mtd-2.6.git, thanks!
> >=20
> > --
> > Best Regards,
> > Artem Bityutskiy
>=20
> I noted it had been applied in linux-next.git tree.
> Does it still need to l2-mtd-2.6.git?=20
> Thanks.

It is in linux-next because it is pulled there from l2-mtd-2.6.git.
Thanks for head up, but no, it should stay in the l2-mtd-2.6.git.
David Woodhouse then should take care of merging the l2 tree upstream.

--=20
Best Regards,
Artem Bityutskiy

--=-hKQ4YhiJxusiMRUOX8cp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJO8wVAAAoJECmIfjd9wqK0b3sQALv1+62DO8rqyM/R9DMiy38T
breXjzaUgzKLhLGyAdEFFM2ryaEosQIMrQCIzdQq/Q3pPwcWNHH6IidAw/BDXvhV
HDfd6uFTg/3lc1wZWWDEUwaPOJ15ADYyShxDV4Bey9NmeTSW8XAm0hiNwEyZ47nw
1z14vyGtQ9gdFTu1gTS/VB13OR3ZqAbRntyK3qETTNSsbQEdNPAPArJQnGWN792v
ybXGzg7XaPRIk+CstLLeMgkxr08q8gGZRd3cNb4h0jbOj9uNZKeV+6umpEU7cW6h
XTBRd6RWJXhFXjm9huVmqIFYCBOv12tP6sUex8P/KseC8J4iOTHbepi5ydQkrl9V
ZbsImHxTLCqOU6bFVwuKl9uUEWThwevGjtN+WJI0YYWkD1HgdsNDS/uhrURf4l1D
F4nPdDyCNc+x5Jg2aaFVpg+IK69TUmK9JZtL7mUDyg+3K2H21RHabxOYpwtPvqS5
sirmRlMCMLVyQDtuYLJhklfo9zUrATmA0+tSqDyw1mCrmMjh7AaHawLHNUhRMH1g
lQwZhE3Novw2OEEZB9y+eOdvGVVYBjkU6/1Agdcgc1F2Oo0XqAZEoQ1nClDA1Kyn
CYgBejMvaH64UwzR7FrMvRNO9RjnYycdK3eIFVnClkvNSsZ+UUe87ZsAoEnw4huD
Ef6EbYj0iwH20cYGJfpX
=0njV
-----END PGP SIGNATURE-----

--=-hKQ4YhiJxusiMRUOX8cp--
