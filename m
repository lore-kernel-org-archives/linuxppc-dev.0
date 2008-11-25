Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id F16B5DDDFB
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Nov 2008 11:50:42 +1100 (EST)
Date: Tue, 25 Nov 2008 11:50:21 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: linux-next: manual merge of the 4xx tree
Message-Id: <20081125115021.b4782240.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__25_Nov_2008_11_50_21_+1100_gP8y59MK.Ue6zqJw"
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, linux-next@vger.kernel.org,
	paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__25_Nov_2008_11_50_21_+1100_gP8y59MK.Ue6zqJw
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Josh,

Today's linux-next merge of the 4xx tree got a conflict in
arch/powerpc/configs/ppc44x_defconfig between commit
c8d698849e135780738c2cb08f07f06eda982a8c ("powerpc/virtex: Update
defconfigs") from the powerpc-merge tree and commit
867b71f3da64eb917c23cfd8babcd1c4fc0ba7fd ("powerpc/44x: update
ppc44x_defconfig") from the 4xx tree.

I fixed it up (by setting CONFIG_GPIO_XILINX to y as is done in the
former).  I can carry this fix until either your tree is merged by Paul or
you do a merge against the powerpc-merge tree (or Linus' tree after he
takes Paul's tree).
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__25_Nov_2008_11_50_21_+1100_gP8y59MK.Ue6zqJw
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEUEARECAAYFAkkrS80ACgkQjjKRsyhoI8xZAQCfUaczEMe9CsACiTk9O78eLNK5
9YAAmOrAewDvGizcUaZnnYBK8TNLqlA=
=lsEy
-----END PGP SIGNATURE-----

--Signature=_Tue__25_Nov_2008_11_50_21_+1100_gP8y59MK.Ue6zqJw--
