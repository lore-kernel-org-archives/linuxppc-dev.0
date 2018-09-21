Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Gnlj29q4zF3Px
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Sep 2018 19:06:41 +1000 (AEST)
Date: Fri, 21 Sep 2018 19:06:39 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
 linuxppc-dev@lists.ozlabs.org, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael
 Ellerman <mpe@ellerman.id.au>
Subject: Re: [REVIEW][PATCH 0/9] signal/powerpc: siginfo cleanups
Message-ID: <20180921190639.36c4bcf8@canb.auug.org.au>
In-Reply-To: <878t3yitze.fsf@xmission.com>
References: <878t3yitze.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/L83Adti=lF2bierENe4AgKL"; protocol="application/pgp-signature"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Sig_/L83Adti=lF2bierENe4AgKL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Eric,

On Tue, 18 Sep 2018 19:41:09 +0200 ebiederm@xmission.com (Eric W. Biederman=
) wrote:
>
> Folks please review and double check me.  I think I have kept these
> changes simple and obviously correct but I am human and mess up
> sometimes.

Its always good to see a nicely set out patch series like this.

--=20
Cheers,
Stephen Rothwell

--Sig_/L83Adti=lF2bierENe4AgKL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluktJ8ACgkQAVBC80lX
0GzDLQgAjiA+cJSVkM6LtgzOLLTCs4Co5C770JYclf8Z1UezSfK0DvVUbyEL1FZs
ric3KQQVU5qyNzMM3qJX+UJjQUlFMumsFcbp9eRV4Uavyanvv0JQgnbYo/L/u9Fc
E+pjhUK3qSPF0tJs4nC+szglI+DMIvGFl64Y7RN2/CFev1w61uEvOanZgdkVlA4W
ArjpONz2GSebGRcKE6fJghjqLwQMGFe9pU9umSSLZSv9XuX1hINYGaTN6zqy8f+Q
1pgc4YvMgvNXcAPEoTM2B3fUPkDgw+F7WKMYVjX4nLsV1z9qE4BWli99UHGC6aTp
AWJ64EKghrxlKCDpEjKm9Iq7BhDiCw==
=Kblr
-----END PGP SIGNATURE-----

--Sig_/L83Adti=lF2bierENe4AgKL--
