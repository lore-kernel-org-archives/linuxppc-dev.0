Return-Path: <sfr@canb.auug.org.au>
Date: Wed, 7 Sep 2005 11:02:17 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jon Loeliger <jdl@freescale.com>
Message-Id: <20050907110217.78c9d8bf.sfr@canb.auug.org.au>
In-Reply-To: <1126039509.25148.54.camel@cashmere.sps.mot.com>
References: <1125607912.16685.111.camel@cashmere.sps.mot.com>
	<20050902163708.12c1abe3.sfr@canb.auug.org.au>
	<1126039509.25148.54.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__7_Sep_2005_11_02_17_+1000_IfkJR+.z0y7h+/q5"
Cc: linuxppc64-dev@ozlabs.org, linuxppc-dev@ozlabs.org
Subject: Re: PATCH Merge more include files
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__7_Sep_2005_11_02_17_+1000_IfkJR+.z0y7h+/q5
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 06 Sep 2005 15:45:09 -0500 Jon Loeliger <jdl@freescale.com> wrote:
>
> I'll start using _ASM_POWERPC_ from now on.  I will
> also submit a different patch to do a round of this
> sort of cleanup.

OK, thanks.

> Can we get an official call on the GPL header in
> include files?  I'm defaulting to adding them for now.

And I've been removing them :-)
It actually often depends on which of the asm-ppc or asm-ppc64 files you ac=
tually
copy.

You are right, we need a statement.

> Thanks.  More coming, of course.

Great.

> So, will you resubmit patches based on your 3/3 patch
> that cover the slid-through the cracks set, or shall I?
> I'm thinking pmac_features.h, dbdma.h, keylargo.h, etc.

I took those out because they were controversial and may require
some more thought about where they actually end up.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__7_Sep_2005_11_02_17_+1000_IfkJR+.z0y7h+/q5
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDHjwfFdBgD/zoJvwRAoIrAJ9z/JrXNRfClWXRNsqRKhpuciUvMgCeLema
k+ANLQeCx3zyGVJgcvvL3x4=
=WVVi
-----END PGP SIGNATURE-----

--Signature=_Wed__7_Sep_2005_11_02_17_+1000_IfkJR+.z0y7h+/q5--
