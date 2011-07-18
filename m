Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.tip.net.au [IPv6:2402:b800:7003:1::44])
	by ozlabs.org (Postfix) with ESMTP id DAC2FB6F8B
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 18 Jul 2011 19:35:37 +1000 (EST)
Date: Mon, 18 Jul 2011 19:35:25 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
	<paulus@samba.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: linux-next: build failure after merge of the final tree
Message-Id: <20110718193525.f7ee20f705da1f0ed84955b8@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Mon__18_Jul_2011_19_35_25_+1000_G893vTy6vEziphYl"
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
	Avi Kivity <avi@qumranet.com>, Marcelo Tosatti <mtosatti@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Mon__18_Jul_2011_19_35_25_+1000_G893vTy6vEziphYl
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the final tree, today's linux-next build (powerpc
allysconfig) failed like this:

arch/powerpc/kernel/exceptions-64s.S: Assembler messages:
arch/powerpc/kernel/exceptions-64s.S:1151: Error: attempt to move .org back=
wards
arch/powerpc/kernel/exceptions-64s.S:1160: Error: attempt to move .org back=
wards

This is probably powerpc or kvm tree related.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__18_Jul_2011_19_35_25_+1000_G893vTy6vEziphYl
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOI/5dAAoJEDMEi1NhKgbsoBQH/jmLT1Ye+7LHoHgv1rBrUVJs
XrbavM9XnFLkC20ges+0daBMNsZqbXqD3uaxo10vCMtLEO97Rc9nDDaJXIZeZa++
QF/8bZyXxHG9xlRLLLSZo/7vVUz1Sb0NPHJ1wWu9icN6Xly/k4pel7qrxkA36NMH
7t8+B7iu2dOswZDJaVSmwCfqVN0QQ5pd8U4CdD6fldtX5hKxCQEebdbQTWYE0A9r
qGwPOcrJTLeBkdWCugpaBhosU9qF92fnZBYdjHEkQUg5/mYIXgyCLRmLP8JS+gxC
0u56L9uKbmDrw8FuUlFH7pN2mZLDC/kSW/eFK1E66PyR6Z6JPA5/8rXtsH/eTvY=
=kIiU
-----END PGP SIGNATURE-----

--Signature=_Mon__18_Jul_2011_19_35_25_+1000_G893vTy6vEziphYl--
