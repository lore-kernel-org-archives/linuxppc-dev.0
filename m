Return-Path: <dja@axtens.net>
Received: from mail-pa0-x241.google.com (mail-pa0-x241.google.com
 [IPv6:2607:f8b0:400e:c03::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AEB3A1A000B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2015 08:57:12 +1100 (AEDT)
Received: by padhk6 with SMTP id hk6so28578087pad.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 13:57:09 -0800 (PST)
From: Daniel Axtens <dja@axtens.net>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Denis Kirjanov <kda@linux-powerpc.org>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: linuxppc patchwork queue
In-Reply-To: <1448273552.3452.7.camel@ellerman.id.au>
References: <CAOJe8K3ny5gsUjEOGA5DqmyW5HyxN8_8d2PqkxAj_JpN-nz7Cw@mail.gmail.com>
 <1448237735.18775.3.camel@ellerman.id.au>
 <CAOJe8K2KSL4yvkZpuJ-ZWiY7L0q8+fgkOp0rKOzCUTgGhmy5Bw@mail.gmail.com>
 <1448273552.3452.7.camel@ellerman.id.au>
Date: Tue, 24 Nov 2015 08:56:54 +1100
Message-ID: <87r3jgv0pl.fsf@gamma.ozlabs.ibm.com>
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

> The main thing you could do, and anyone could do (!), is just review some
> patches. Even if you don't know the area of code that well, you can usually do
> a basic review.
>
> eg. Just the basic stuff:
>  - Is the subject correctly formatted and makes sense.
>  - Is the change log well written and describes the change well.
>  - Does the patch do one logical change.
>  - Are there any obviously bad coding style things.
>  - Can you follow the basics of the change based on the change log and some
>    reading of the code?

Michael gave me the same advice earlier this year, and I found it really
helpful. As a result, I've been trying to do reviews.

I am by no means an expert, but here's what I found starting out:

 - Reviewing is a learned skill - you don't just start doing kernel dev
   and get this magical sense of how to do reviews. This means it's OK
   to start small, and that no-one expects your early reviews to be
   amazing.

 - Reviewing gets much easier when you just jump in and start doing it!

 - A review doesn't have to focus on getting to a reviewed-by
   tag. Asking good questions is equally if not more valuable.

 - It was easier to start with the 'little picture', or what Michael
   calls the 'basic stuff'. Is it good C? Does the commit message make
   sense? Is the spelling right? Does it do weird things without
   explaining them? When you're starting it's OK to leave the 'big
   picture'/architectural/design reviews to other people. I definitely
   still do!

HTH.
Daniel

>
> Another thing I seem to spend a lot of time on is asking people if their patch
> should go to stable or not, and if so what versions. So everyone could help out
> there.
>
> cheers
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: GPGTools - https://gpgtools.org

iQIcBAEBCgAGBQJWU4unAAoJEPC3R3P2I92FmjUQAI0WXlx5MxL6qOva5sbTWSjX
Fyf5a/FfZhGjs9KQYH1knUrzFAzjiZpRfs7Y1fQqlhxCA2sP2z0XxzWapG/IhlVM
OJdiWyENPYRN95VLqPcIV+ji1LB/+9vp1sTT0r40z88B5Qi+zVBjPsapkgbcia/E
FraHZYOQz8Nj2Wr28t/BmR4lvJ8lqvzR74wZng9RyvllJnWuaw5YVe/RVoqCuGO6
NagyzV/vzhMCuTyv4LOb4fh0bC9o6G2hBT3Z/t4J79Vspgj6ODbr6a+PVqy8rzbJ
3+WuIHMSBewxEjvRrOiRK5zTdwrbLHzyJP4xmlFQdsyE5THjD+0XJCvDnw1dh22I
S81UEWCfzCtbSj9PH/wBRQ+eB9UOI0NkKfO2UhWw5rWEsgGsRc4eNCj2iYwwS9a0
qxbg1Oad0bjGqo62Cm9qWuIM+OmLUJupPwTLbARak7PpzFK/XYrkpqTahzFzrMw0
WKsqSLZ+UusBAgnsHpTn3co4FC8uLK59X559DKDvToe9Mw+O8qTLKSzVBtUIqIke
OTUU3W07Kiccv6oUgbI1PeCPcxdWT5lOvm2RrrlOWjR+MIRAwIALM1L9A676NuLo
ONRoLVb7S8bgh4YxT4lWTgSemqIGwHNPSJPO0MVWzBFrHcraxgV+lvNyP7XAsB+d
c7ozi/gtZpI8T3m9g6P1
=ZM9u
-----END PGP SIGNATURE-----
--=-=-=--
