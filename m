Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Gn0F2nz3zF3PN
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Sep 2018 18:32:29 +1000 (AEST)
Date: Fri, 21 Sep 2018 18:32:28 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael
 Ellerman <mpe@ellerman.id.au>
Subject: Re: [REVIEW][PATCH 4/9] signal/powerpc: Remove pkey parameter from
 __bad_area_nosemaphore
Message-ID: <20180921183228.6140665c@canb.auug.org.au>
In-Reply-To: <20180918175850.4437-4-ebiederm@xmission.com>
References: <878t3yitze.fsf@xmission.com>
 <20180918175850.4437-4-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/95WVGHuS4Ewzn/t6D3.S4zV"; protocol="application/pgp-signature"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Sig_/95WVGHuS4Ewzn/t6D3.S4zV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Eric,

On Tue, 18 Sep 2018 19:58:45 +0200 "Eric W. Biederman" <ebiederm@xmission.c=
om> wrote:
>
> Now that bad_key_fault_exception no longer calls __bad_area_nosemaphore
> there is no reason for __bad_area_nosemaphore to handle pkeys.
>=20
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Again, very straight forward given that _exception(a,b,c,d) -> _exception_p=
key(a,b,c,d,0).

Reviewed-by: Stephen Rothwell <sfr@canb.auug.org.au>

--=20
Cheers,
Stephen Rothwell

--Sig_/95WVGHuS4Ewzn/t6D3.S4zV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlukrJwACgkQAVBC80lX
0GyKbwf7BQb2XOvMXtY2v569PpZmtI/71bKz1VQmyj/9KFSIR7BVVVoyN3KvMAi6
Zd/XI2a9faGJkyb6qWIDnHxLHNktEiqzU+oyn/EjSwh270K+U4z9qEyfpAtXTO0e
yWFjpGY57WUxFyXWXNRz+quhG4QEnMswLn/QtOcNcIzZ9Xwb/VXaGmqf7dBWLCr+
sTgjTFUKl4a8ccyu4YotV+rSU/e/BFDt6VqU6FD8a0xJSCF1NKEu+fhs8GXMZFkz
uk2q86HJ3AhhksBz1mhjRMm8QKIjzliB2hBRw+C6bglkWijcUcE4tq0tfiujvFLE
fgHkjFe52spf3N4FFG0vMUwbcbForA==
=kobP
-----END PGP SIGNATURE-----

--Sig_/95WVGHuS4Ewzn/t6D3.S4zV--
