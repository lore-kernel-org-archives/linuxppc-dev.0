Return-Path: <vitorio@digitel.com.br>
Received: from hermes.digitel.com.br (hermes.digitel.com.br [200.198.105.36])
	by ozlabs.org (Postfix) with ESMTP id 92B2E67A67
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 19 Mar 2005 07:49:56 +1100 (EST)
Received: from [10.10.10.160] by hermes.digitel.com.br (GMS
	9.01.3158/NU1492.00.9f6ce814) with ESMTP id tnrwkbaa for
	linuxppc-embedded@ozlabs.org; Fri, 18 Mar 2005 17:39:24 -0200
From: =?ISO-8859-1?Q?Lu=EDs_Vit=F3rio?= Cargnini <vitorio@digitel.com.br>
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-E5Sp2aUiMUDlqFvMwgTK"
Date: Fri, 18 Mar 2005 17:38:02 -0300
Message-Id: <1111178282.3555.11.camel@vitorio>
Mime-Version: 1.0
Subject: problemsm  cross-compiling
Reply-To: vitorio@digitel.com.br
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--=-E5Sp2aUiMUDlqFvMwgTK
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi all,
i'm trying to cross-compilate linuxppc-2.4.30-pre1 but i have some
problems in the end during kernel linkage
the message is the follow:
make[1]: Leaving directory `/linuxppc2_merge/arch/ppc/8xx_io'
ppc_8xx-ld -T arch/ppc/vmlinux.lds -Ttext 0xc0000000 -Bstatic
arch/ppc/kernel/head_8xx.o init/main.o init/version.o init/do_mounts.o \
        --start-group \
        arch/ppc/kernel/kernel.o arch/ppc/platforms/platform.o
arch/ppc/mm/mm.o arch/ppc/lib/lib.o kernel/kernel.o mm/mm.o fs/fs.o
ipc/ipc.o arch/ppc/math-emu/math-emu.o \
         drivers/char/char.o drivers/block/block.o drivers/misc/misc.o
drivers/net/net.o drivers/net/wan/wan.o drivers/mtd/mtdlink.o
drivers/macintosh/macintosh.o drivers/video/video.o
drivers/media/media.o crypto/crypto.o arch/ppc/8xx_io/8xx_io.o \
        net/network.o \
        /linuxppc2_merge/lib/lib.a \
        --end-group \
        -o vmlinux
net/network.o(__ksymtab+0x490): undefined reference to `arp_create'
net/network.o(__ksymtab+0x498): undefined reference to `arp_xmit'
make: *** [vmlinux] Error 1

how could i solve this ???
someone had this problem ????=20
 someone could sent me the files to fix this ?
--=20
Lu=EDs Vit=F3rio Cargnini <vitorio@digitel.com.br>
Digitel S/A

--=-E5Sp2aUiMUDlqFvMwgTK
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCOzwqyHSZZ0hdDzQRAnMwAKDCn5Xx4iqdE9U0PIu0lKH/gmwkPQCeKVVf
cpXA/JsnI8uHu6MRgSouMnQ=
=xSDD
-----END PGP SIGNATURE-----

--=-E5Sp2aUiMUDlqFvMwgTK--
