Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4A5511A096D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2015 14:42:37 +1000 (AEST)
Received: from mail-pa0-x231.google.com (mail-pa0-x231.google.com
 [IPv6:2607:f8b0:400e:c03::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B3083140E31
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Jul 2015 14:42:36 +1000 (AEST)
Received: by pacan13 with SMTP id an13so82520725pac.1
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Jul 2015 21:42:33 -0700 (PDT)
Message-ID: <1438144834.28422.46.camel@axtens.net>
Subject: Re: [PATCH] cxl: Don't ignore add_process_element result when
 attaching context
From: Daniel Axtens <dja@axtens.net>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, benh@kernel.crashing.org, mikey@neuling.org,
 imunsie@au.ibm.com
Date: Wed, 29 Jul 2015 14:40:34 +1000
In-Reply-To: <1438143932.17434.1.camel@ellerman.id.au>
References: <1438142842-31603-1-git-send-email-dja@axtens.net>
 <1438143932.17434.1.camel@ellerman.id.au>
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-6nszhhwxlM4uNArg98Tf"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-6nszhhwxlM4uNArg98Tf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2015-07-29 at 14:25 +1000, Michael Ellerman wrote:
> On Wed, 2015-07-29 at 14:07 +1000, Daniel Axtens wrote:
> > Previously, when attaching a context in dedicated mode, we ignored
>=20
> Previously? You mean currently? Now is before this patch is applied.
I do mean currently. Apologies for the temporal confusion :)

>=20
> > the result of add_process_element, which could potentially fail.
> >=20
> > If add_process_element returns and error, pass it back to the caller.
>                                    ^
>=20
> I can fix.
>=20
Many thanks: it's good to know that my spelling mistakes will only be
immortalised in the list archives rather than in the kernel's git
history. :p


--=20
Regards,
Daniel

--=-6nszhhwxlM4uNArg98Tf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: GPGTools - https://gpgtools.org

iQIcBAABCgAGBQJVuFlDAAoJEPC3R3P2I92FwxMP/0IPGYeW+kEcy9XRMtYU2EFU
UDnao62DD/Dmj9qu5inKlTwztO/ZwLMVvO6xcfsXm1556ym8Ulhy+4O7YiqqKCUA
pJoMOZ6QrFpf0F9zvL/HSbu7TOq5eREWI+Tg70mbctssmhS5+Yl9aypH02vFFj1V
MWgCCLqE8CizubvwIsagO4nvPtkNzOwNz3Y7QecBFyhHDhJFvu9xNq66y1hcTNt2
Bg/jCvmBSQpJXtRL0Ym0FOhfC/vCY3EZ1GDc70aDbUWIsj7poL0W6OFM7WW3W7C9
nzDjw23VCzyNqT0kOJM+ly31uFl98WuvHgpK/FQqdzxC16A6RBfdS45ooHJ7erRC
x1c6St+bi2W/fI6PJSyP9Zt0dpDitwMLzocekzvtUaHMRdUaY+Nb/ZG1e3Ek4mJe
m7Al91hOCqIzml0CQD0/1lDR8Jtg3L84Xj+jZXpKDqkqTlFU9bMjx6vqM0CsnyAn
KbG7M0t3TyapOXxv7bDS37c2a+ePfmxWONN1CSMlTR7BwekjsDLN+7uhjb/HhHUc
AxhkFxFagQLDOBulVmAHfeOvvo+B05DAHrqo0FQWBxbWLFu4WRauPhMhgd3lZxLL
x6uJG+8hGBCWX9lM12hv0dqXdHxjS/LHGJKg74QCdBUk0QFRbue5ExQ8fSOpSmBb
fhpjzzXZXV1bXVc2C8gb
=dp1X
-----END PGP SIGNATURE-----

--=-6nszhhwxlM4uNArg98Tf--
