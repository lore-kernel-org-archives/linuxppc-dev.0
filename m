Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.tip.net.au
 [IPv6:2402:b800:7003:1::20])
 by ozlabs.org (Postfix) with ESMTP id 8CA1E2C0088
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Oct 2012 12:05:12 +1100 (EST)
Date: Thu, 11 Oct 2012 12:05:02 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Alexander Graf <agraf@suse.de>
Subject: linux-next: manual merge of the kvm-ppc tree with the powerpc-merge
 tree
Message-Id: <20121011120502.0211f1267dedf3776e4cf85b@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Thu__11_Oct_2012_12_05_02_+1100_.g+TGX+A3MBhmGq+"
Cc: Liu Yu <yu.liu@freescale.com>, linux-kernel@vger.kernel.org,
 Stuart Yoder <stuart.yoder@freescale.com>, David Howells <dhowells@redhat.com>,
 linux-next@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Thu__11_Oct_2012_12_05_02_+1100_.g+TGX+A3MBhmGq+
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Alexander,

Today's linux-next merge of the kvm-ppc tree got a conflict in
arch/powerpc/include/asm/Kbuild between commit c3617f72036c ("UAPI:
(Scripted) Disintegrate arch/powerpc/include/asm") from the powerpc-merge
tree and commit 4c09029a5639 ("KVM: PPC: Add support for ePAPR idle hcall
in host kernel") from the kvm-ppc tree.

I just removed epapr_hcalls.h from the Kbuild file as I am not sure how
it should be broken up.  David, can you have a look at this, please?

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Thu__11_Oct_2012_12_05_02_+1100_.g+TGX+A3MBhmGq+
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJQdhs+AAoJEECxmPOUX5FE9CMP/RifbCd1MZc2msyU/IPpKEPL
SNhJg2edkuKAUVpbxDj1uwCqlj19M6hDNXH6I9cIb+P/obnIlHYdAxIc+W77MfDp
aLyxnDkSB9Zwp73C1u7IzsHUs4EQeGb0AdKp0QbNm1j59zbD6U1QmAjm3zGzUFbp
ZJD+WtHW6ZwvwuemKQSL2wUpwce/GFZLtlBcSNUOX4FtSdK6oB17FDpZjU9e7SVZ
rpskzwWYvGld43mc9VpFAi/wC+gy+2qrlLOTYesLJwE6EJ6a0TLG1rCBm9cofv/u
AQtGhR0WKpC84Q58ccXaFFRLVHS1HNorDr3wc0ttpHHBNATKW/aS7z5j4P9bIQE0
j8IuoVttqSdQ3FIOJmVgEbIYVT8pMT5+DsDocFamxAwhlfU5OulThPrEC/PfPFnr
xhoObhMkI0Y2LqM3zcRE3YP/zZyc/FEfkPKyO/ap6ePTrPee7mIjMYGjDFyJLl3P
sUp+xq6ZLdATGr3oQp9cyLRF6/gcmUu+SecKy3z6o+bGg1hYN4ndBV1ZD9Z9Jvk3
9P2yAqxA+A85emxAZRg+omi1ACOXW6cCmBPg7ut7zL3Lv8RisXb9emxBsNp2Ybb4
ypzOqxmjBxr7EFp3b7l6c7XdC5MPQpp3Smy9n0SUkn76N+xRh3nSouVYC+wNUgfa
RzR9WodpNV71nd3v5pPu
=nW0A
-----END PGP SIGNATURE-----

--Signature=_Thu__11_Oct_2012_12_05_02_+1100_.g+TGX+A3MBhmGq+--
