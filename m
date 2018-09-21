Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Gn6m5wCmzF3PZ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Sep 2018 18:38:08 +1000 (AEST)
Date: Fri, 21 Sep 2018 18:38:07 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael
 Ellerman <mpe@ellerman.id.au>
Subject: Re: [REVIEW][PATCH 5/9] signal/powerpc: Factor the common exception
 code into exception_common
Message-ID: <20180921183807.700623bd@canb.auug.org.au>
In-Reply-To: <20180918175850.4437-5-ebiederm@xmission.com>
References: <878t3yitze.fsf@xmission.com>
 <20180918175850.4437-5-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_//TK0bzvZq/Kez6spvh++oVH"; protocol="application/pgp-signature"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Sig_//TK0bzvZq/Kez6spvh++oVH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Eric,

On Tue, 18 Sep 2018 19:58:46 +0200 "Eric W. Biederman" <ebiederm@xmission.c=
om> wrote:
>
> It is brittle and wrong to populate si_pkey when there was not a pkey
> exception.  The field does not exist for all si_codes and in some
> cases another field exists in the same memory location.
>=20
> So factor out the code that all exceptions handlers must run
> into exception_common, leaving the individual exception handlers
> to generate the signals themselves.
>=20
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Clearly no change in semantics.

Reviewed-by: Stephen Rothwell <sfr@canb.auug.org.au>

--=20
Cheers,
Stephen Rothwell

--Sig_//TK0bzvZq/Kez6spvh++oVH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlukre8ACgkQAVBC80lX
0Gwkigf/bA/DSSCczbH5itXP3jjiTRk4KR/N1QmKfnFTXvrspspJjGyXr+88oGeY
rVK+HHbcdXuNQmi2dGL3UYhAcBPqmHb/MVEtblEpi9/zxCCku2evwJqQKryfGaKA
fhskO18ZMSD1aRqrJ61YY7kC/ZqQ+oYGIlpZidTX50Usf6Dl1zXmb9mewggnzX24
94ObFYt7duEt5lW+NII1dCxPZMxZM4T1O79efhgPU3IGP9UEjHYzin6Of/AVjU6R
o34/Oo6S7jBAXBTf8sgo2QEwnEz4xu27NQuFHtkG2/LwBlKrKPw/ngHGQiWbzahX
oOWqoaiphleG4+40GHtmmxCLe8VDwA==
=FL4j
-----END PGP SIGNATURE-----

--Sig_//TK0bzvZq/Kez6spvh++oVH--
