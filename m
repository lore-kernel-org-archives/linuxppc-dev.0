Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.tip.net.au
 [IPv6:2402:b800:7003:1::20])
 by ozlabs.org (Postfix) with ESMTP id 351632C01C7
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Jul 2012 16:12:11 +1000 (EST)
Date: Mon, 2 Jul 2012 16:12:00 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Al Viro <viro@ZenIV.linux.org.uk>
Subject: linux-next: manual merge of the signal tree with Linus' tree
Message-Id: <20120702161200.10c26ba2b57f9c7e493e85cc@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Mon__2_Jul_2012_16_12_00_+1000_nkTJFC5yUq+xu0Tv"
Cc: linux-kernel@vger.kernel.org, Tiejun Chen <tiejun.chen@windriver.com>,
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

--Signature=_Mon__2_Jul_2012_16_12_00_+1000_nkTJFC5yUq+xu0Tv
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Al,

Today's linux-next merge of the signal tree got a conflict in
arch/powerpc/kernel/entry_64.S between commit c58ce2b1e3c7 ("ppc64: fix
missing to check all bits of _TIF_USER_WORK_MASK in preempt") from Linus'
tree and commit d07644a97726 ("powerpc: missing NOTIFY_RESUME check on
64bit if CONFIG_PREEMPT is set") from the signal tree.

I *think* that the former is a superset of the latter, so I just used the
former.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Mon__2_Jul_2012_16_12_00_+1000_nkTJFC5yUq+xu0Tv
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJP8TuwAAoJEECxmPOUX5FE4rkP/jfe3fZRzlUs14v2FKKBtsuA
LTDEQ4D6K+2nCPfoa/icHmA1GoQZGCUqKVhLcxNI5eGQKQPOiVo1AgkC8oKFx8HD
Sm8qAX6VEEuVQLl2iSU/I7aFy6GCesQHctKl2ENXIOABuWmpLlmJoihXXV55YV7q
FgAfkZoiJks7OwgF0jq5M7U8eOJsYNsz3cHtR72NsvYZiK8vPDpoS7tFvQVN+cbS
xsMlekkf5kuVdBVcyLGFmySClqp9wuavwpY+oJXY79Kt/24EKDy4WKiz58CD9F8e
QtqfXAutKsFYC4CrGy/aQKu4/v1C7lV+I3sN89cEXrdekxn0niRH4ErwSc93q7rG
UxmeD+PexFMmaty6UZONp16hZULK0XA1H4eZLVV7YN2K7k6eegQbvERZUOgvONb0
d45o3+8RegkSpmhHRbtxTBhw4b/l3s/zVaZ/kAHzIampMJzVcBOBjCtNvOmIYAh1
hfuEvPXYNfy4Ceb13QJm3hp7vKR2ADpl0rsrhFW30Q9kdMojlItylQ1mXSMG3Bqt
G3z+sGDGR0VkA1FVMgmesMeLX2ZybRqUaSO52FKm0nuytwk1pYCFnlIpOD2mHssn
bIEU36rsY/fIDrrK0+8nf/8ibxnGb7AJNMf+9VCDVK+/6EqAHpiCdDH06y6UH+se
09bj+vrkc1Q7zbnqk5FN
=WJ4C
-----END PGP SIGNATURE-----

--Signature=_Mon__2_Jul_2012_16_12_00_+1000_nkTJFC5yUq+xu0Tv--
