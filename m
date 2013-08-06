Return-Path: <haokexin@gmail.com>
Received: from mail-pb0-x230.google.com (mail-pb0-x230.google.com
 [IPv6:2607:f8b0:400e:c01::230])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E46AB2C007A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Aug 2013 11:21:59 +1000 (EST)
Received: by mail-pb0-f48.google.com with SMTP id ma3so4041767pbc.21
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Aug 2013 18:21:57 -0700 (PDT)
Date: Tue, 6 Aug 2013 09:21:47 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v2 6/8] powerpc: introduce early_get_first_memblock_info
Message-ID: <20130806012147.GB24317@pek-khao-d1.corp.ad.wrs.com>
References: <1372942454-25191-7-git-send-email-haokexin@gmail.com>
 <1374884281.30721.40@snotra>
 <20130804004531.GD19141@pek-khao-d1.corp.ad.wrs.com>
 <1375747168.13074.100.camel@snotra.buserror.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="MfFXiAuoTsnnDAfZ"
In-Reply-To: <1375747168.13074.100.camel@snotra.buserror.net>
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--MfFXiAuoTsnnDAfZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 05, 2013 at 06:59:28PM -0500, Scott Wood wrote:
> On Sun, 2013-08-04 at 08:45 +0800, Kevin Hao wrote:
> >  	memblock_add(base, size);

<snip>

> >  }
>=20
> I think it'd be clearer for it to be an external variable that gets set
> by the relocation code -- plus, the above wouldn't work if this gets
> called twice due to having multiple memory regions.

Got it.

Thanks,
Kevin
>=20
> -Scott
>=20
>=20
>=20

--MfFXiAuoTsnnDAfZ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJSAE+rAAoJEJNY7TDerrFxK4oH/30daKA3Kf3a+UV/bMT0wLvn
wdklQoRsXbcAaj90Y5MR3KuK8E+rlyYiyzyWqEBXHJVv7pS99zKJ4CPPSE4qz5Gp
+2j+ZjZCkDZUyW2oSvci0C50jmHk9UgYKxyAfPAXbDlq6SGUVm30EPOXug/l4xPh
+Lu9HlV31+mnPQkqYXp2EoKpCCE07JZmCUrAcz0svIgnUDl8cvB9BORJspaZp/Yu
as2daYXmjnNEdP2n0D7VLhrfqxEKICsao+9OAMGwjcFsVpb2IPVaItUwAfpmctvh
M9z7lsgjbxRygu7oXaRtv6cfp+WrdOiO6CGMyUHpNsEXToUbe/90v5s+U/q3GrY=
=Jzki
-----END PGP SIGNATURE-----

--MfFXiAuoTsnnDAfZ--
