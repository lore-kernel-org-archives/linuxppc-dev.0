Return-Path: <bkartal@aselsan.com.tr>
Received: from turunc.aselsan.com.tr (mail.aselsan.com.tr [212.50.56.228])
	by ozlabs.org (Postfix) with ESMTP id AF3D267A06
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  1 Mar 2006 23:55:00 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-9"
Subject: MVME5100  Exception: Program (Illegal Instruction)
Date: Wed, 1 Mar 2006 14:54:51 +0200
Message-ID: <C379193B17749F4BA82ABF87E7DCB6A62CF0D6@papatyaint.aselsan.com.tr>
From: "Bora KARTAL" <bkartal@aselsan.com.tr>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I am trying to run linuxppc 2.4.20 with a nfs mounted root file system on=
=20a Motorolla MVME5100 board with a PowerPC 7410 processor. When I used =
the default kernel =FDmage sh=FDpped with MontaVista Linux development ki=
t, it boots up and works fine. But when I build up a custom kernel I am g=
etting the following exception during bootup.

=20

Residual-Data Located at: $1FE9077C

Exception: Program (Illegal Instruction)

SRR0 =3D00005000 SRR1 =3D00083040 Vector-Offset =3D00700

IP =3D00005000 MSR =3D00003040 CR =3D00000000 FPSCR =3D00000000

R0 =3D00000000 R1 =3D1FE00000 R2 =3D00000000 R3 =3D1FE9077C

R4 =3D00005000 R5 =3D00000000 R6 =3D00000000 R7 =3D00000000

R8 =3D00000000 R9 =3D00000000 R10 =3D00000000 R11 =3D00000000

R12 =3D00000000 R13 =3D00000000 R14 =3D00000000 R15 =3D00000000

R16 =3D00000000 R17 =3D00000000 R18 =3D00000000 R19 =3D00000000

R20 =3D00000000 R21 =3D00000000 R22 =3D00000000 R23 =3D00000000

R24 =3D00000000 R25 =3D00000000 R26 =3D00000000 R27 =3D00000000

R28 =3D00000000 R29 =3D00000000 R30 =3D00000000 R31 =3D00000000

SPR0 =3D00000000 SPR1 =3D00000000 SPR8 =3D00000000 SPR9 =3D00000000

00005000 7F454C46 WORD $7F454C46

Anybody can help?

Thanks,

Bora

######################################################################
Dikkat:

Bu elektronik posta mesaji kisisel ve ozeldir. Eger size=20
gonderilmediyse lutfen gondericiyi bilgilendirip mesaji siliniz.=20
Firmamiza gelen ve giden mesajlar virus taramasindan gecirilmekte,=20
guvenlik nedeni ile kontrol edilerek saklanmaktadir. Mesajdaki=20
gorusler ve bakis acisi gondericiye ait olup Aselsan A.S. resmi=20
gorusu olmak zorunda degildir.

######################################################################
Attention:=20

This e-mail message is privileged and confidential. If you are=20
not the intended recipient please delete the message and notify=20
the sender. E-mails to and from the company are monitored for=20
operational reasons and in accordance with lawful business practices.=20
Any views or opinions presented are solely those of the author and=20
do not necessarily represent the views of the company.

######################################################################
