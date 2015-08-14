Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 304241A2D8B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2015 17:57:57 +1000 (AEST)
Received: from mail-pa0-x231.google.com (mail-pa0-x231.google.com
 [IPv6:2607:f8b0:400e:c03::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 9956F140216
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Aug 2015 17:57:56 +1000 (AEST)
Received: by pacrr5 with SMTP id rr5so55421731pac.3
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Aug 2015 00:57:55 -0700 (PDT)
Message-ID: <1439538928.29526.8.camel@axtens.net>
Subject: Re: [PATCH v4 06/11] cxl: Refactor adaptor init/teardown
From: Daniel Axtens <dja@axtens.net>
To: Ian Munsie <imunsie@au1.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, mpe <mpe@ellerman.id.au>, benh
 <benh@kernel.crashing.org>, cyrilbur <cyrilbur@gmail.com>, "Matthew R.
 Ochs" <mrochs@linux.vnet.ibm.com>, Manoj Kumar <kumarmn@us.ibm.com>, mikey
 <mikey@neuling.org>
Date: Fri, 14 Aug 2015 17:55:28 +1000
In-Reply-To: <1439531040-sup-2913@delenn.ozlabs.ibm.com>
References: <1439439089-25151-1-git-send-email-dja@axtens.net>
 <1439439089-25151-7-git-send-email-dja@axtens.net>
 <1439531040-sup-2913@delenn.ozlabs.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-m8plotWM5QwApJx0dqa9"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-m8plotWM5QwApJx0dqa9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable


> These seem a bit odd here (though perfectly harmless) - not sure these
> need to be done again on recovery (but maybe I'm wrong?) - seems more
> like something that should be done early in cxl_init_adapter?
>=20
I was really trying to get init to do _only_ things that are once-off
operations. As such, I put things in configure that were safe to do more
than once, even if they didn't have to be.

I have respun with the style changes reverted.

> Acked-by: Ian Munsie <imunsie@au1.ibm.com>
>=20

--=20
Regards,
Daniel

--=-m8plotWM5QwApJx0dqa9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: GPGTools - https://gpgtools.org

iQIcBAABCgAGBQJVzZ7xAAoJEPC3R3P2I92FqjYP/iH648i93J+LaBbje1zH0G6h
Y1DuENClwcoFw4Gvr+74eKUiD8wUOLt2ui3Ty1RzQMv3B9eGaaXgf6+dMSpQGMA8
6JktzQwF4Jg8rfr6CPvhNaEunt3fQecuDnDwv3dDUROasVrKdpnKfiBpFldQSIsQ
Leun95mMtNwXVE5bULu9IDDri1it5Pxj7p1kP1QDGVKTgdyKHGXfddX71/b2Flz9
oP7WySjrStDUCXoJ+LQdnDpqcQCVqUfXGB3jG95JtPQZnNi4tQoTUQcGJwced4cl
D7VxREtALXNDpZAB4NGEj205enXb5rUW3+ukf65aOCMMw8/pCeVt1wXUZinAWO2X
TImpggU9wJdUpYF5RDl3mRaQvGRRIdVjPN4WcqeI9gkLs33oBS9m+DbGgAGezdo9
RRFmAEz4GINo+agC3TDekxrDZ8P7PDuVqZrXLfVGUN8SFragxkw9j7Y68kgJh9Mi
MUqVD6fnxXh+uK16cSU30qIVF+acizHKsoJryl9xlePshGrMr9uIs2a8TTRQv07K
0LV43U0OYTAtbs/ntIyR3U0mMCihvb+TcsLe/S8zV1BKEK9l1lvFit2+0k3IG2XL
jv8XG5Qlu6HoWBZ61rdWswRe4Vv2mIJMdcMGJ9dOwiCR9WJbw4pFVWahxDpyEPTU
p8Wkec98SFdmHnMqEBow
=uR0B
-----END PGP SIGNATURE-----

--=-m8plotWM5QwApJx0dqa9--
