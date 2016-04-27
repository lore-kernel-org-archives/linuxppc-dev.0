Return-Path: <boqun.feng@gmail.com>
Received: from mail-ig0-x22c.google.com (mail-ig0-x22c.google.com
 [IPv6:2607:f8b0:4001:c05::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qw32C0lnhzDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Apr 2016 00:56:34 +1000 (AEST)
Received: by mail-ig0-x22c.google.com with SMTP id u10so75160330igr.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Apr 2016 07:56:34 -0700 (PDT)
Date: Wed, 27 Apr 2016 22:59:37 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Pan Xinhui <xinhui@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 peterz@infradead.org, paulmck@linux.vnet.ibm.com, tglx@linutronix.de
Subject: Re: [PATCH V4] powerpc: Implement {cmp}xchg for u8 and u16
Message-ID: <20160427145937.GM3369@insomnia>
References: <5715D04E.9050009@linux.vnet.ibm.com>
 <571782F0.2020201@linux.vnet.ibm.com>
 <5720837D.6050807@linux.vnet.ibm.com>
 <20160427135817.GJ3369@insomnia> <20160427145034.GL3369@insomnia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="oiL9LJXJsdjS5rzq"
In-Reply-To: <20160427145034.GL3369@insomnia>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--oiL9LJXJsdjS5rzq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 27, 2016 at 10:50:34PM +0800, Boqun Feng wrote:
>=20
> Sorry, my bad, we can't implement cmpxchg like this.. please ignore
> this, I should really go to bed soon...
>=20
> But still, we can save the "tmp" for xchg() I think.
>=20

No.. we can't. Sorry for all the noise.

This patch looks good to me.

FWIW, you can add

Acked-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

--oiL9LJXJsdjS5rzq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXINPVAAoJEEl56MO1B/q4PAsH/RTRO38BJInLKev/QqrL/dnO
mPrTOZrX/CzzqfKqpIxDLOS8SJ9eOpc+QNgQJwfMaJF6b8RSKJHBfB3ePGMsi3tT
WFjaoAfDu+LrswF6dgutSvndxD/Iy0GOcJpc+/CwYM1W7v5tTPiPIHyxAhueyeaQ
O3nqtVEqpEOr3Rv3+pNAbxfwODaQKqOeY4x4QymHxePFRhZ9U+mXHnwm2dY/KyWV
oHaLWGL1lXNc0PiKhvjolFpByZiYPD8M1RfVorlCL4/7JjnyhUVHtdMdhte4ScHd
KLHrHSPyGYgEvy+xOY6sff6M1e5eGqBNaOwPPKq7x8F75KOeCnHh9TbtbGrvXzY=
=LEN2
-----END PGP SIGNATURE-----

--oiL9LJXJsdjS5rzq--
