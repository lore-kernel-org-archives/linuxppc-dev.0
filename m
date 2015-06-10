Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 854E31A0023
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2015 15:08:03 +1000 (AEST)
Received: from mail-pd0-x235.google.com (mail-pd0-x235.google.com
 [IPv6:2607:f8b0:400e:c02::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C0F651402AB
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Jun 2015 15:08:01 +1000 (AEST)
Received: by pdjm12 with SMTP id m12so29382511pdj.3
 for <linuxppc-dev@ozlabs.org>; Tue, 09 Jun 2015 22:07:59 -0700 (PDT)
Message-ID: <1433912822.3096.31.camel@axtens.net>
Subject: Re: [PATCH V8 04/10] powerpc, perf: Re organize PMU based branch
 filter processing in POWER8
From: Daniel Axtens <dja@axtens.net>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, mikey@neuling.org, sukadev@linux.vnet.ibm.com
Date: Wed, 10 Jun 2015 15:07:02 +1000
In-Reply-To: <1433763511-5270-4-git-send-email-khandual@linux.vnet.ibm.com>
References: <1433763511-5270-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1433763511-5270-4-git-send-email-khandual@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
 protocol="application/pgp-signature"; boundary="=-azs/bSmJKgUdiSE8Y+sW"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-azs/bSmJKgUdiSE8Y+sW
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable


>  	/* Every thing else is unsupported */
>  	return -1;
You're returning -1 as a unsigned 64bit number. Other code that reads
this value tests for -1 and I think it works everywhere just because it
wraps around consistently. But I would still rather not do this and I'm
surprised it doesn't throw a warning.

Regards,
Daniel

--=-azs/bSmJKgUdiSE8Y+sW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: GPGTools - https://gpgtools.org

iQIcBAABCAAGBQJVd8X3AAoJEPC3R3P2I92FkYQQAMiHC/3u3sWRnLUz7e8JwYWm
StAzphhggJv/dT0bgpNvMoMCB8+XAfciA5A0TF+tuoZqsL6Xit87wzEAsqgd992N
GVQU004L5ZVM96xU7NGXTCcEpujh5FHhYiVTbfOQz5n7NjrB9JF0osZusvBKT25L
j+zY7tnYsg6ds3ljnAUW6b3FHBeCTB4zTDYHhfNzXd8DlAiGpAlfbUUN1sWmHMRk
xskBsr0C40su0MIXlYzk2QFy1H+GrI+3Hrl4vZ0cSWrbZQRMm2wqOcpYSpdYao1S
nevqWU4YKCOXuh61XcoxTLOo6xnYWfY6gfIwJYw6Pto4335q8mMDvRx5VBlwaILY
jWQnnxNxgAaJIQ6yQ0g0PxsH6nEmC4EFwrAKatpLp9ZEUHjQMNVDyFyzn3tf12xE
KIUBIhIRBvMU0S7Nl/jxwYVYmnAyAgAFyTgeTuBG6erYG+Fnftax0G3NJ+Gv6PkG
RnJ+dzx/nAc8REpOWd/TQYnHycJiRMwmM50QjouxQQeYozzSe5yCbXt4pW4dRrBk
5lXinx4uNnNPL8Uh6ChAV+dHUNElGyrxcs9QYD6k+da6iTR0wfAop9nO8v+Y4Ry4
2rSgQIaH5GB4p28jI62Hz/zlsP9otiN1d5sk4ft4Q8+fZCEUisR4dEpbAMrZj0vV
yu5kJHataQRcfefbxruK
=qo4E
-----END PGP SIGNATURE-----

--=-azs/bSmJKgUdiSE8Y+sW--
