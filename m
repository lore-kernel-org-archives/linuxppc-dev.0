Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42GnkP6b01zF3Cc
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Sep 2018 19:05:33 +1000 (AEST)
Date: Fri, 21 Sep 2018 19:05:32 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael
 Ellerman <mpe@ellerman.id.au>
Subject: Re: [REVIEW][PATCH 9/9] signal/powerpc: Use force_sig_fault where
 appropriate
Message-ID: <20180921190532.1fc443f0@canb.auug.org.au>
In-Reply-To: <20180918175850.4437-9-ebiederm@xmission.com>
References: <878t3yitze.fsf@xmission.com>
 <20180918175850.4437-9-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/LvvCWtQn0+MyTAxO+aensSW"; protocol="application/pgp-signature"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Sig_/LvvCWtQn0+MyTAxO+aensSW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Eric,

On Tue, 18 Sep 2018 19:58:50 +0200 "Eric W. Biederman" <ebiederm@xmission.c=
om> wrote:
>
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Again, looks all good to me.

Reviewed-by: Stephen Rothwell <sfr@canb.auug.org.au>
--=20
Cheers,
Stephen Rothwell

--Sig_/LvvCWtQn0+MyTAxO+aensSW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluktFwACgkQAVBC80lX
0GxUZggAjfzzqiy0I2AO7lFNh2CfaFDcrUYOuRhMUQ8cCkh4xzo0LGIJUjrjSUVg
yiYBNCa1IkxfvhO9p0mCPOo6UFOxVDDmG+szKObU7uUpTLyfqF/YOJucdzvYZj56
8UukU/if+4cPgJCrsLyIYRrnJ3njeKN1UhCy6prUBIXK7hOfK3xGbHUo5MWm31A/
48iwE9rpB2JmBgubhCvEE7cpZWFH1QMjPMn74x8sxPZsU7581Hu+Es5d+eMdH902
nMqyukQvYjrmau3jSAbK/3bspU2LTcB/eBZRkkpX2/loSqgPpqCfuZibjzpWVz98
jx8mpkClmnRO6dkhVEjWcpz758lVzA==
=7xuH
-----END PGP SIGNATURE-----

--Sig_/LvvCWtQn0+MyTAxO+aensSW--
