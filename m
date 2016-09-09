Return-Path: <dja@axtens.net>
Received: from mail-pa0-x244.google.com (mail-pa0-x244.google.com
 [IPv6:2607:f8b0:400e:c03::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sVdk01rCdzDrp7
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Sep 2016 10:43:51 +1000 (AEST)
Received: by mail-pa0-x244.google.com with SMTP id ez1so3026561pab.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Sep 2016 17:43:50 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 1/5] powerpc/cell: drop unused iic_get_irq_host()
In-Reply-To: <6411576.kd9HS3NQth@wuerfel>
References: <1473139963-7496-1-git-send-email-dja@axtens.net>
 <6411576.kd9HS3NQth@wuerfel>
Date: Fri, 09 Sep 2016 10:43:33 +1000
Message-ID: <87wpildhsa.fsf@possimpible.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--=-=-=
Content-Type: text/plain

Hi Arnd,

> I'm currently experimenting with a patch that adds -Wmissing-declaration to
> the normal kernel CFLAGS for everyone, and fixing up the warnings I get with
> that on ARM.
>
> Are you looking at all the powerpc specific code? If we can catch all the
> existing warnings for some of the major architectures, we can hopefully
> enable this in the mainline kernel at some point so we don't need sparse
> for it any more.

At the moment I'm just trying to squash sparse warnings on powerpc. This
particular catch came from making something static via a dodgy python
script and then Andrew finding it was EXPORTed. Removing the EXPORT
threw the warning - so it's a bit more complex than just a sparse
warning.

I think powerpc has the missing prototype warnings enabled and -Werror
as well.

Andrew Donellan was telling me there's a Coccinelle script that looks
for things that are both static and EXPORTed - maybe that's worth
following up on this point?

Regards,
Daniel

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: GPGTools - https://gpgtools.org

iQIcBAEBCgAGBQJX0gW1AAoJEPC3R3P2I92FbYcP/jCL2IUQKhzgKFJ8pb5Nwb1Z
Te4usx72lxTTXzgz+eGfVb6ClR0wcuFg2t2vXP5lldmQLqMBq0LTdoeKchTXB8Ru
29V3eo85H2tEybClz6Be2txpe1QTEUU3wwwlpYa/pxyU/RohVUJWrtOB4qxVDZVb
uSWIZslIRvxDBLsQRfTkKxTRayktx7AuEwf3jmNiZMvcOdz6E2iaEewalTZBg1Z+
Z5VcUOgx7bQTbr+gp11gDY/qc4QodZvA8BW2TDg0KeI6t94vfggNPgjd37npw7k7
3C9UmZioZkpt2+jfx2IKDVfUaoq0uISbQOMD3C/1X6FpdujoaWFORgwZUPXt0NlL
k/nY48bQRKHq+q2X4Kn+a8fPKkT6NvcRopT7oyXB14c6ZENfQPWslWOtRU1xPhr/
/GS/1amN5hb5RByvH1jJR6J1DN6x/6sY+WTjx1j0Axc6TamAvlAp7YV6BMJP6ncj
5stXEOl+RE/VylmLmZbhr1/dVFLrThwJ9fp3t08hX6Ty5DRvy7kIXTKiMnBQbDLa
8zVkHJx6NKSBUnOu9ubiur02GRXJb1UIsS4QJBOx5vEFzvMgCI7G0YveC845k+hB
z8FtIZnPQMbSwaOSAMi5aJkYWfPlfVn/nH+zXnrq90tCAdrUrCGBtyKC7FlAnbuI
/gcU663ryLztBaDvXZDa
=kjJu
-----END PGP SIGNATURE-----
--=-=-=--
