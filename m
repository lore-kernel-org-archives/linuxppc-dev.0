Return-Path: <rober@opnet.com.tw>
Received: from opnet2.opnet.com.tw (unknown [210.243.240.244])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D4FF567E55
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  9 Aug 2005 16:25:26 +1000 (EST)
Received: from [10.0.14.26] (h248-210-243-240.opnet.com.tw [210.243.240.248]
	(may be forged))
	by opnet2.opnet.com.tw (8.13.3/8.13.1) with ESMTP id j79EMJKY083089
	for <linuxppc-embedded@ozlabs.org>; Tue, 9 Aug 2005 14:22:20 GMT
	(envelope-from rober@opnet.com.tw)
From: =?UTF-8?Q?=E5=BE=90=E5=8B=9D=E5=A8=81=E7=9A=84EMAIL?=
	<rober@opnet.com.tw>
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain
Date: Tue, 09 Aug 2005 14:25:15 +0800
Message-Id: <1123568715.4219.7.camel@banana>
Mime-Version: 1.0
Subject: about building RTAI 24.1.12 at Linux 2.4.25
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi All,

    I got some error while make RTAI, anybody know how to fix it please
tell me,thanks.


1.I used ELDK version is 

ELDK version 3.1
ppc_8xx: Build 2004-11-10

2.My Linux is 2.4.25 -D2005-06-24 has been patch with
patch-denx-linuxppc_2_4_devel-2005_06_23_1722

3.My hardware is MPC852T 32M SDRAM 8M Flash

4.I step by step build my RTAI by reading README.install, but stil
fail. 

[root@banana rtai-24.1.12]# make
mkdir -p modules
make -C  rtaidir CFLAGS="-I /root/rtai-24.1.12/include -I . -D__KERNEL__
-I/opt/eldk/usr/src/linuxppc_2_4_devel/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer
-I/opt/eldk/usr/src/linuxppc_2_4_devel/arch/ppc -fsigned-char
-msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring
-DMODULE -DMODULE" MAKING_MODULES=1 modules
make[1]: Entering directory `/root/rtai-24.1.12/rtaidir'
/opt/eldk/usr/bin/ppc_8xx-gcc -I /root/rtai-24.1.12/include -I .
-D__KERNEL__ -I/opt/eldk/usr/src/linuxppc_2_4_devel/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-fomit-frame-pointer -I/opt/eldk/usr/src/linuxppc_2_4_devel/arch/ppc
-fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized
-mmultiple -mstring -DMODULE -DMODULE -I.  -DEXPORT_SYMTAB -c
rtai-arch.c
/root/rtai-24.1.12/include/asm/rtai_srq.h: In function `rtai_srq':
/root/rtai-24.1.12/include/asm/rtai_srq.h:32: error: asm-specifier for
variable `__sc_3' conflicts with asm clobber list
/root/rtai-24.1.12/include/asm/rtai_srq.h:32: error: asm-specifier for
variable `__sc_4' conflicts with asm clobber list
/root/rtai-24.1.12/include/asm/rtai_srq.h:32: error: asm-specifier for
variable `__sc_0' conflicts with asm clobber list
/root/rtai-24.1.12/include/asm/rtai_srq.h:31: confused by earlier
errors, bailing out
make[1]: *** [rtai-arch.o] Error 1
make[1]: Leaving directory `/root/rtai-24.1.12/rtaidir'
make: *** [_mod_rtaidir] Error 2


Best Regards
Rober Hsu
