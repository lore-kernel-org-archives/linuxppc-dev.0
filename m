Return-Path: <dja@axtens.net>
Received: from mail-pa0-x244.google.com (mail-pa0-x244.google.com
 [IPv6:2607:f8b0:400e:c03::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sKQxn42nVzDrcZ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Aug 2016 11:07:09 +1000 (AEST)
Received: by mail-pa0-x244.google.com with SMTP id vy10so2107315pac.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Aug 2016 18:07:09 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: Simon Guo <wei.guo.simon@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/ptrace: Fix cppcheck issue in
 gpr32_set_common/gpr32_get_common.
In-Reply-To: <20160824073826.GA16442@simonLocalRHEL7.x64>
References: <1471695863-8660-1-git-send-email-wei.guo.simon@gmail.com>
 <878tvmrjoc.fsf@possimpible.ozlabs.ibm.com>
 <20160824073826.GA16442@simonLocalRHEL7.x64>
Date: Thu, 25 Aug 2016 11:06:45 +1000
Message-ID: <871t1dr716.fsf@possimpible.ozlabs.ibm.com>
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
Content-Transfer-Encoding: quoted-printable

Simon Guo <wei.guo.simon@gmail.com> writes:

> I think keeping tm_active argument for "ifndef CONFIG_PPC_TRANSACTIONAL_M=
EM"=20
> case (with __maybe_unused prefix) will be somehow strange -- Whatever
> value is provided in the caller function for tm_active, programmer might =
be=20
> puzzled and cost sometime to think about it.  I don't like to use=20
> "__maybe_unused" to bypass this warning.

Fair enough. I don't have strong feelings either way - we'll see if the
maintainers have any thoughts.

Regards,
Daniel

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: GPGTools - https://gpgtools.org

iQIcBAEBCgAGBQJXvkSlAAoJEPC3R3P2I92FVskQAJnt1bzV9mCuRBrmm/8HgSdH
pjIIZ85zjdO968nkITFlRy4Dv5KbigDoL4pu+sOk/7DflQBkfdoIqic7IMny+CCB
WqxDjOmaLt+STxy1e1gJ2CODHB2G1KAOgAibo1jTy+GUkRIFVxKXw0oNI3Lk4GgM
OfqXziSRxhuxdsHE91N8HRHcRpqhu0SaUs8O5Y1QpUZd7PyBZ7u+ue2ILzeDi8DI
s5drQygrfrJS6ITgbYbWYKAHFe8d6JfbInp+iGpRlui99/QTSBSVYm1bNvya9g07
U55IJC/KQg/zbumT8TPU8ARsfhtAxm+ZuIupWek2V3HD9HE1gx+YW412Rne2KRMT
K5YPK7PrMHpRWwXF35ygu5Y8hIsZV2nXO4AYTicxBBWNcKkd0I7F3qLWVkJPniri
/+/4SuvK7ry6qVqtJQUb+Wl+amoboxjyyMrfYif7Y6uh95P2zkysOu+1zXGNAM4P
+tkR9FpFH8verTNUxrHTuhM1b5kQ+bIswpvrdcfflLaEboMc9fPK8z1ODIRKLj7r
fmIfU1ISwSjok/niqD1NXbNSBktDbvwRWyCeNm5W5UMIK9Ci9gdxMAray9fRfOd2
qJno49quJpC7ng/ANIH2A7gb7jWSVEVAEp19tR/1zro3r0RAHutMkIoBiznn80LS
qwDnn84eLaXaa2Fqoibo
=Kq8w
-----END PGP SIGNATURE-----
--=-=-=--
