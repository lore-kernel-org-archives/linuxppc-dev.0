Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 5C854B7079
	for <linuxppc-dev@ozlabs.org>; Mon,  9 Nov 2009 16:15:06 +1100 (EST)
Date: Mon, 9 Nov 2009 16:15:02 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 09/16] powerpc: Replace old style lock initializer
Message-Id: <20091109161502.ab064092.sfr@canb.auug.org.au>
In-Reply-To: <1257548144.13611.267.camel@pasglop>
References: <20091106223547.784916750@linutronix.de>
	<20091106223806.762624109@linutronix.de>
	<1257548144.13611.267.camel@pasglop>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Mon__9_Nov_2009_16_15_02_+1100_VXaAjp_Frxudoo9n"
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>,
	LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Mon__9_Nov_2009_16_15_02_+1100_VXaAjp_Frxudoo9n
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Thomas,

On Sat, 07 Nov 2009 09:55:44 +1100 Benjamin Herrenschmidt <benh@kernel.cras=
hing.org> wrote:
>
> On Fri, 2009-11-06 at 22:41 +0000, Thomas Gleixner wrote:
> > plain text document attachment
> > (power-replace-old-style-lock-init.patch)
> > SPIN_LOCK_UNLOCKED is deprecated. Init the lock array at runtime
> > instead.
> >=20
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Cc: linuxppc-dev@ozlabs.org
> > ---
>=20
> Looks reasonable. But iseries can be a bitch, so we do need to test it
> on monday.

Tested-by: Stephen Rothwell <sfr@canb.auug.org.au>
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__9_Nov_2009_16_15_02_+1100_VXaAjp_Frxudoo9n
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkr3pVYACgkQjjKRsyhoI8xGQwCgnRc8jgHeGJFueccVWDyc4HFd
ShUAniFJkr80jd342IXlM8QZOF+zBsdI
=QbRQ
-----END PGP SIGNATURE-----

--Signature=_Mon__9_Nov_2009_16_15_02_+1100_VXaAjp_Frxudoo9n--
