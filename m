Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 6AAFDDDE06
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Mar 2009 01:21:26 +1100 (EST)
Date: Sat, 28 Mar 2009 01:21:17 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Steven Rostedt <srostedt@redhat.com>
Subject: Re: linux-next: tracing/powerpc tree build failure
Message-Id: <20090328012117.4669e153.sfr@canb.auug.org.au>
In-Reply-To: <1238158131.22033.10.camel@localhost.localdomain>
References: <20090327230834.93d0221d.sfr@canb.auug.org.au>
	<1238158131.22033.10.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Sat__28_Mar_2009_01_21_17_+1100_cZk=LqB1Ghvdy/83"
Cc: Benjamin, linuxppc-dev@ozlabs.org, linux-next@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Sat__28_Mar_2009_01_21_17_+1100_cZk=LqB1Ghvdy/83
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Steve,

On Fri, 27 Mar 2009 08:48:51 -0400 Steven Rostedt <srostedt@redhat.com> wro=
te:
>
> I knew this was going to break, but I needed to wait till powerpc merged
> with tip before I could make the change.

Yeah, a bit of a pain but we can live with it for a while.

> This is exactly what I would have done.

Thanks for the confirmation.  I guess I will keep applying this until one
tree or the other hits mainline at which point it can be fixed in the
other tree.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sat__28_Mar_2009_01_21_17_+1100_cZk=LqB1Ghvdy/83
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAknM4N4ACgkQjjKRsyhoI8zyXwCgt0zjiyV2mtMCeoFDhoCxnz2t
oIwAnRz2e3ORvJleGZStSfpIDUecj6EQ
=l+wa
-----END PGP SIGNATURE-----

--Signature=_Sat__28_Mar_2009_01_21_17_+1100_cZk=LqB1Ghvdy/83--
