Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40w9my6ysqzDqGD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 May 2018 21:02:58 +1000 (AEST)
Date: Tue, 29 May 2018 21:02:57 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, PowerPC <linuxppc-dev@lists.ozlabs.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, Mathieu Malaterre
 <malat@debian.org>
Subject: linux-next: boot messages from today's linux-next
Message-ID: <20180529210257.26da8de7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/qW63_4G3s+Rn81/meypW38y"; protocol="application/pgp-signature"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Sig_/qW63_4G3s+Rn81/meypW38y
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

My qemu boots of today's powerpc linux-next kernel produced the following
boot message differences:

-Max number of cores passed to firmware: 2048 (NR_CPUS =3D 2048)
+Max number of cores passed to firmware: u (NR_CPUS =3D 2048)

Seemingly caused by commit

  eae5f709a4d7 ("powerpc: Add __printf verification to prom_printf")

--=20
Cheers,
Stephen Rothwell

--Sig_/qW63_4G3s+Rn81/meypW38y
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsNM2EACgkQAVBC80lX
0GyCXwgApP8ZwkJRONX4Vk1eCSzCXxDkYm5ZEP7inV2Ur/wshd8dm/C/1GLVGmkM
1ilp4TFgULSCLEqJL7OxEU9ivjZBj+78zvzJaXBSt4Vr78eyrYxvpH7FQggpBn5H
en1Oyc2yeBur74e+aPw2wKtSWYwPU5gj8lP6+OwQwkYjKk8VBQbYXiYbjMvrTzlG
rtdMqGTkX9FY4f29bqayLHsnj61nwkZlSrQ6KwoVRv9aiol6uMttTLpSLp4xmTxF
/rP5S3+Ps2S7rzbu+m9BYdMMOI9KfCTUMo6OiDdbSLcPEEyiNjwCsGyD1+fzv2Uv
dV8kNTNlzJahxQFqzEFpqlx9a7lFjA==
=LcnE
-----END PGP SIGNATURE-----

--Sig_/qW63_4G3s+Rn81/meypW38y--
