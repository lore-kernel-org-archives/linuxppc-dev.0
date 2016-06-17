Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rW5WL2pjfzDqsV
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jun 2016 13:35:58 +1000 (AEST)
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rW5WK0nv9z9t1l
 for <linuxppc-dev@ozlabs.org>; Fri, 17 Jun 2016 13:35:56 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id i123so2238634pfg.3
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Jun 2016 20:35:56 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc/align: Use #ifdef __BIG_ENDIAN__ #else for
 REG_BYTE
In-Reply-To: <6933845.bk2S1M4pvP@wuerfel>
References: <1466080421-25188-1-git-send-email-mpe@ellerman.id.au>
 <6933845.bk2S1M4pvP@wuerfel>
Date: Fri, 17 Jun 2016 13:35:35 +1000
Message-ID: <8760t8mqrc.fsf@possimpible.ozlabs.ibm.com>
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

> It would be better to fix the sparse compilation so the same endianess
> is set that you get when calling gcc.

I will definitely work on a patch to sparse! I'd still like this or
something like it to go in though, so we can keep working on reducing
the sparse warning count while the sparse patch is in the works.

Regards,
Daniel

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: GPGTools - https://gpgtools.org

iQIcBAEBCgAGBQJXY3AHAAoJEPC3R3P2I92F+HIP/198vbgGRGcFFjCZf3NiJOLr
NF24JAakSSXabXbJ6UUUtBFJhvNeiFL2SnMBTuqbKcPeDqeJsSLgrRSWGXNknAmh
f/B85fFH0k3C/XU7XryoAZTdoQI2mKQob81j9ksm8ZerPbsT10rODavIB0Me/erT
HTMWLexjnj4rPRvwN3a6lVz9Gge0xd6cQxIHdM1YhCj/h3g9i8yFD0vqsE7JyT4w
AuypdxMECR7BH5lVZQGvRmUEpNy7VAE44wIyEv/ESHVxHwrjdHxU8h6Z1imm5PSJ
+nPY13iAxHrYEaTXmUqrkgJ5SXLar+1/FQqYNqMHcgNZpiQZOcbhK8NzNUL9odcb
Io/605ZYMvvkyXWhDnOfrPS6D7m2M3Lfq5eRJ5Chz20Fveg04f6voYm2vyFaGlHU
g7hZO1x4VBV1wD/VO6rqXifLpIGaxhqmGO5HLLA5punHxvzR3PE7ht+GXcGL6KLQ
ZM7WnUYL6IKR5vAL0QIID9HO9InTRCw25C50jfmSKiq8oeLcqAid/IJWGR3yAy2r
858ju4rd9WnJLzL4vkBCKPo7kOWfXSosAZGHiayx4+Z9ZoSXOYkGkScW8x8d4kw9
qDQbN7TvXjRfJo2+26VE77DOFMZRDMLtU4OPzmPeCLh8FaI0bZZmB+PUstWyUhT3
YCmjFc2QplwODhXE45Yo
=ovZ/
-----END PGP SIGNATURE-----
--=-=-=--
