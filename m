Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.tip.net.au
 [IPv6:2402:b800:7003:1::20])
 by ozlabs.org (Postfix) with ESMTP id 83F492C0086
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Oct 2012 13:47:57 +1100 (EST)
Date: Thu, 11 Oct 2012 13:47:54 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Tabi Timur-B04825 <B04825@freescale.com>
Subject: Re: linux-next: manual merge of the kvm-ppc tree with the
 powerpc-merge tree
Message-Id: <20121011134754.2e2cbb24842fa991e61cf97c@canb.auug.org.au>
In-Reply-To: <6AE080B68D46FC4BA2D2769E68D765B7080FA8F8@039-SN2MPN1-023.039d.mgd.msft.net>
References: <20121011121841.1b946f996cba995d9a5a2be7@canb.auug.org.au>
 <6AE080B68D46FC4BA2D2769E68D765B7080FA8F8@039-SN2MPN1-023.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Thu__11_Oct_2012_13_47_54_+1100_D4i8oI1jWMbaZHyJ"
Cc: Alexander Graf <agraf@suse.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 David Howells <dhowells@redhat.com>,
 "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Thu__11_Oct_2012_13_47_54_+1100_D4i8oI1jWMbaZHyJ
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 11 Oct 2012 01:47:13 +0000 Tabi Timur-B04825 <B04825@freescale.com>=
 wrote:
>
> On Wed, Oct 10, 2012 at 8:18 PM, Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>=20
> >  arch/powerpc/include/asm/epapr_hcalls.h      |  511 ------------------=
--------
> >  arch/powerpc/include/uapi/asm/Kbuild         |    1 +
> >  arch/powerpc/include/uapi/asm/epapr_hcalls.h |  511 ++++++++++++++++++=
++++++++
>=20
> What is include/uapi?  epapr_hcalls.h is not a user-space header file.
>  I don't remember seeing the original patch which moved it, so I don't
> know where this comes from.

Commit 549d62d889b4 ("KVM: PPC: use definitions in epapr header
for hcalls") from the kvm-ppc tree added an include of asm/epapr_hcall.h
to the user visible part of asm/kvm_para.h so asm/epapr_hcall.h became a
user visible header file.

The UAPI changes are moving the user visible parts of export header files
into a separate include directory called uapi.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__11_Oct_2012_13_47_54_+1100_D4i8oI1jWMbaZHyJ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJQdjNaAAoJEECxmPOUX5FEFdgP/i76k2wMBk/pXJdDyK/dgfrb
GO5fsKE6Gt3/fvLC2pG1qplyexbqj1kGfhSSVFVVV3L062tPRFfYgjNp0+Bxl2Pa
Ds3R20SBG2KJIXwdki41s5nRonXFfPKGxVUX22/NSygpJU84Fdt2+yBg5hVcB39s
yEfToFoTR9fFogi0qANCL/nEn4OsvfXYpqyWPlkw7gnCeBNkhS+fBUVAZD1RMLSq
1YUV3jZnrYR8OxSdT/Q3ha1K2HtsVY4+e01AugpXPfnszGmIlQrhWyHIveVV+f6D
wA2mCwVMYgZkH6N/yA1yTj7eoZ9CZJ2EiOzahjFaXG2v2KJ2cdV+EfRDAGmM8FuA
dVV64X30hV0HtXLVmScRnTSb04PudD3dovqiRnzipJ0a4qXq+SaQy/r8JlP+K0vj
O0ghWHK0O2w7E6Ya0Ec63gJCeVdip1yWvfmfshJ5cV3ggoUaqyl8oTAYVuHkx0Bv
+rf7sW9XSWi+MoTaukNq1YZMKf8YzzGfmdXmQPLwsvuHiugYUqkDSlpDLcxCCKxc
8+mjIOeklU3MWKHENMVKLcunjG/WrDlZCn1aAyqXkO+skPh+KFm3BBIceqaQWgKU
hs2do0K/op/Zd3Lh5/6wsZP9KucfivY4Kaja6M8Rf3+BeyNPOYLrDe2KRQ34H2+q
mmxzfRNQVsqly7MBJfrG
=dAcz
-----END PGP SIGNATURE-----

--Signature=_Thu__11_Oct_2012_13_47_54_+1100_D4i8oI1jWMbaZHyJ--
