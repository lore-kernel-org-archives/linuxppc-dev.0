Return-Path: <haokexin@gmail.com>
Received: from mail-pa0-x22c.google.com (mail-pa0-x22c.google.com
 [IPv6:2607:f8b0:400e:c03::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E29401A0052
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Aug 2015 16:46:01 +1000 (AEST)
Received: by padfo6 with SMTP id fo6so240953pad.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2015 23:45:59 -0700 (PDT)
Date: Fri, 21 Aug 2015 14:45:47 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH 3/8] jump_label: introduce
 DEFINE_STATIC_KEY_{TRUE,FALSE}_ARRAY macros
Message-ID: <20150821064547.GD12451@pek-khao-d1.corp.ad.wrs.com>
References: <1440072876-8321-1-git-send-email-haokexin@gmail.com>
 <1440072876-8321-4-git-send-email-haokexin@gmail.com>
 <20150821062826.GA566@gmail.com>
 <20150821063458.GC12451@pek-khao-d1.corp.ad.wrs.com>
 <20150821064059.GA2934@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="5p8PegU4iirBW1oA"
In-Reply-To: <20150821064059.GA2934@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--5p8PegU4iirBW1oA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2015 at 08:40:59AM +0200, Ingo Molnar wrote:
> Please also Cc: peterz and me to the next submission of the series - stat=
ic key=20
> (and jump label) changes go through the locking tree normally, and there'=
s a=20
> number of changes pending already for v4.3:

Sure.

Thanks,
Kevin

--5p8PegU4iirBW1oA
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV1skbAAoJEJNY7TDerrFxCLMIAKEQ0TjMvM/2Ncp2wDCfzYIX
x23Vz8eCV38+dExtHTW70xfyLgTdXHatQHnkT5FYeRsaSnMuGH2OSjmxc7vRUMuC
gtLY0a0cX87qXX5TS98BBGh3YjwLF62OYyjFNprzQbOcQTkQFLDOSuJwhV/z5u/p
5mTIAUsnwdD2IVz/QRyDJRwyAMmwmx6rgvbGFyZ1RkGEcMO39GaK4hjmLgljiZ0g
aho4qqptwxWYWNb/C4STzDv8mvlhIvAbzBwjeEA82jQFJ3oiErJ6hxa3YoXVhFGw
e3ypeIyZ/QrYeN9rmBwFpYk42zKfkB/w/KmfZ4eeICrDkYCGJKgqbf3SyQAvB2k=
=iXCf
-----END PGP SIGNATURE-----

--5p8PegU4iirBW1oA--
