Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 9183CB70A7
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 15 Sep 2010 14:39:11 +1000 (EST)
Date: Wed, 15 Sep 2010 14:39:04 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Yinghai Lu <yinghai@kernel.org>
Subject: Re: linux-next: build warnings after merge of the final tree (tip
	treee related)
Message-Id: <20100915143904.ca226c83.sfr@canb.auug.org.au>
In-Reply-To: <4C90226E.4050306@kernel.org>
References: <20100913132721.5a02cfbc.sfr@canb.auug.org.au>
	<4C8DA517.9000603@kernel.org>
	<20100913143942.7344ada4.sfr@canb.auug.org.au>
	<4C8DDFB4.1020508@kernel.org>
	<20100914145025.977ec2a6.sfr@canb.auug.org.au>
	<4C8FFE76.8070801@kernel.org>
	<20100915102930.5e4d59cb.sfr@canb.auug.org.au>
	<4C90226E.4050306@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__15_Sep_2010_14_39_04_+1000_/zC80piBEq1tdWF3"
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	linux-next@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@elte.hu>, ppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Wed__15_Sep_2010_14_39_04_+1000_/zC80piBEq1tdWF3
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Yinghai,

On Tue, 14 Sep 2010 18:33:34 -0700 Yinghai Lu <yinghai@kernel.org> wrote:
>
> On 09/14/2010 05:29 PM, Stephen Rothwell wrote:
> >=20
> > Do not remove the "extern" key word.
>=20
> why? you got another warning?

It is normal C coding practice to mark declarations in header files with
extern.  It probably doesn't strictly matter for functions, but I have
seen a case where not doing so to a variable lead to multiple definitions
of the variable.  Consistency is also good.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__15_Sep_2010_14_39_04_+1000_/zC80piBEq1tdWF3
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBAgAGBQJMkE3oAAoJEDMEi1NhKgbs9tsH/36cUc0lhYxCRoio5m3qer2a
QRPUy/IAcYC5lp+O3NHzCEvCm3051G9b5A0E5TSMKlTD83JRMoA3ek+zEoQ4dRQY
SKbVqaiWrpw+WLk8oXG8aEW1F+DiTeFUGgsnuG8qEGpPGQ152CRuD028Mfp5bMGW
Rz+FzpnG+KEpQW6X+ouZk+kaYWaDhjXeC5sYEbBann8pVzeLBqXgWtSkR42qHuKh
UAvo360pjYLNQ9FEb61NU51Lxh1Qz5YuQ1538ABGIK9/rHc3KNrDyxJH5BSsKCaY
vI2tgVQXrdBevfeSouUgdP6du5sdykWkiDjFneEY/i4eDqF/i1XOKzdRvCgr2t4=
=hM6n
-----END PGP SIGNATURE-----

--Signature=_Wed__15_Sep_2010_14_39_04_+1000_/zC80piBEq1tdWF3--
