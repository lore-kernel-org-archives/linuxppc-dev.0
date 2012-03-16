Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.tip.net.au
 [IPv6:2402:b800:7003:1::20])
 by ozlabs.org (Postfix) with ESMTP id 3AD08B6EF4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Mar 2012 14:57:12 +1100 (EST)
Date: Fri, 16 Mar 2012 14:56:58 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jiri Kosina <jkosina@suse.cz>
Subject: linux-next: manual merge of the trivial tree with the powerpc tree
Message-Id: <20120316145658.3fb06c5213dbca29d6898c4b@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Fri__16_Mar_2012_14_56_58_+1100_sAZwT9CG=3DUQa0t"
Cc: linux-kernel@vger.kernel.org, Masanari Iida <standby24x7@gmail.com>,
 linux-next@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Fri__16_Mar_2012_14_56_58_+1100_sAZwT9CG=3DUQa0t
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jiri,

Today's linux-next merge of the trivial tree got a conflict in
drivers/char/viotape.c between commit ba7a4822b48f ("powerpc: Remove some
of the legacy iSeries specific device drivers") from the powerpc tree and
commit a7ccf3775219 ("char: Fix typo in viotape.c") from the trivial tree.

The former commit removed the file, so I did that.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Fri__16_Mar_2012_14_56_58_+1100_sAZwT9CG=3DUQa0t
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJPYroKAAoJEECxmPOUX5FEfWkP+QFOKeYx+wB+r0l46uJSglSL
SjsDyYh/LiPOP7/fZ0TVHp+5hA76ZIZQv1nYKpjyJf3He7nH/Nm6ho9gd0y87KGm
Y+x6rDS35JULF2tMlwSgmR5P0JEhXyDKGlC8fM9MZa9TQjsev2gCOd9CUhGr1PWS
/rx0p3ig1+mD3rPJKvpk0pQP2KJx7zN8BWCIlKm9jukaR7PcLL1ImTfAP5UxjtDZ
6Rl9WZEf3hHjsDJXbfGvnrLsav+gImC3e1zVJrmg0t83E1u0mWMuZnONGPflqMKF
VxWqDULsGmzeaoEQ032sncjCzmNnDRaBBSmvKeziTMpTLBIfVYEKO6cNaNGPPdGr
mJ5gVrXJnzpN2/jOHzLMfjd96gUeZraM7JEwotDFvxvg+9ZQaoQcvcbvqrK3h0fE
oYC04b+Zrr5jWgXmQ/rAOPvcGM/Fm7tZSHxJUtmg3FPmELOcLGk63D6XTuioNFwG
PfrFv7LWn2tvRdMTrRvoz+XOiFruYJGNmtGls5u9/inKsVXvxtO0Pg817Hf0e1Ug
/iy7LfWUTfDagBHJsFOhIPOUZHbMIlmXJrBG5Zv4q7svZkygsdWU1qsRvsdVIPuF
ZVw/LrHJPQhRhrcENDviMXnDpzS7tdUeylCzn3Lo3LwRk6cccQXGC3Ybu/WC2cbZ
bxArC0m4hCZ/1LIhuKBJ
=8cHa
-----END PGP SIGNATURE-----

--Signature=_Fri__16_Mar_2012_14_56_58_+1100_sAZwT9CG=3DUQa0t--
