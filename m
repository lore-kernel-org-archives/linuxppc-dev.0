Return-Path: <rodolfo@lesc.ufc.br>
Received: from lesc0.lesc.ufc.br (unknown [200.17.37.126])
	by ozlabs.org (Postfix) with ESMTP id D5B9CDDF1C
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 16 Feb 2008 03:19:23 +1100 (EST)
MIME-Version: 1.0
Date: Fri, 15 Feb 2008 13:51:34 -0200
From: rodolfo <rodolfo@lesc.ufc.br>
To: linuxppc-embedded@ozlabs.org, rodolfogalvao87@gmail.com
Subject: XUP Virtex II p with Linux 2.4 - Question
Message-ID: <1575591b2b88bb7caca70587ec899dea@lesc.ufc.br>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi everybody!

I subscribe on this list today because i have some problems with linux
kernel 2.4 compilation. I'm using EDK/ISE 9.1i, crosstool-0.38 . I follow
this sites:

- http://www.cs.washington.edu/research/lis/empart/xup_ppc_linux.shtml
- http://splish.ee.byu.edu/projects/LinuxFPGA/
- http://www.crhc.uiuc.edu/IMPACT/gsrc/hardwarelab/docs/kernel-HOWTO.html

I have a lot of error like this: "can not found ...", "undeclared first in
this function...". But i could solve them! Now the problem is:

../common/ns16550.c: In function `serial_init':
../common/ns16550.c:63: error: `XPAR_UARTNS550_0_CLOCK_FREQ_HZ' undeclared
(first use in this function)
../common/ns16550.c:63: error: (Each undeclared identifier is reported only
once
../common/ns16550.c:63: error: for each function it appears in.)
make[2]: ** [../common/ns16550.o] Erro 1
make[2]: Saindo do diretório
`/home/rodolfo/Desktop/Projeto_Linux_Embedded/bk-client2.0/linux/arch/ppc/boot/simple'
make[1]: ** [zImage.initrd] Erro 2
make[1]: Saindo do diretório
`/home/rodolfo/Desktop/Projeto_Linux_Embedded/bk-client2.0/linux/arch/ppc/boot'
make: ** [zImage.initrd] Erro 2

Anybody can help me? i'm new in this world (fpga - linux)!

Thanks

Rodolfo Galvao 
Fortaleza/CE - BRASIL
