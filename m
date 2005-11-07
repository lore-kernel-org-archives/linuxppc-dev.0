Return-Path: <mqy@263.net.cn>
From: "KylongMu" <mqy@263.net.cn>
To: "Wolfgang Denk" <wd@denx.de>
Date: Mon, 7 Nov 2005 14:43:13 +0800
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0000_01C5E3A9.9A923B20"
Message-Id: <20051107064328.E9A261127@smtp.263.net>
Cc: Linuxppc-embedded@ozlabs.org
Subject: 11-07-2005 2.6.14 can't finish build with yosemite-defconfig 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------=_NextPart_000_0000_01C5E3A9.9A923B20
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dear Denk
	After cg-update today's kernel repository, I test with these steps:
Make yosemite-defconfig
Make uImage

But the build stops with some errors, last cg-update (6 days ago) is ok.

Cordially,

Kylong Mu

------=_NextPart_000_0000_01C5E3A9.9A923B20
Content-Type: text/plain;
	name="11-07-2005-build-error-yosemite.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="11-07-2005-build-error-yosemite.txt"

  CHK     include/linux/version.h=0A=
  CHK     include/linux/compile.h=0A=
  CHK     usr/initramfs_list=0A=
make[1]: *** No rule to make target `arch/ppc/syslib/indirect_pci.o', =
needed by `arch/ppc/syslib/built-in.o'.  Stop.=0A=
make: *** [arch/ppc/syslib] Error 2=0A=

------=_NextPart_000_0000_01C5E3A9.9A923B20--
