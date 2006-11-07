Return-Path: <federicosibilio@tiscali.it>
Received: from mrqout2.tiscali.it (mrqout2a.tiscali.it [195.130.225.14])
	by ozlabs.org (Postfix) with ESMTP id BC55967CAE
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Nov 2006 00:53:51 +1100 (EST)
Received: from ps8 (10.39.75.78) by mail-8.mail.tiscali.sys (7.3.110.2)
	id 45420C2F0001C7CD for linuxppc-embedded@ozlabs.org;
	Tue, 7 Nov 2006 14:38:28 +0100
Message-ID: <32912319.1162906708248.JavaMail.root@ps8>
Date: Tue, 7 Nov 2006 14:38:28 +0100 (CET)
From: "federicosibilio@tiscali.it" <federicosibilio@tiscali.it>
To: linuxppc-embedded@ozlabs.org
Subject: Installing u-boot on sbc8260 via ethernet using minicom
MIME-Version: 1.0
Content-Type: text/plain;charset="UTF-8"
Reply-To: "federicosibilio@tiscali.it" <federicosibilio@tiscali.it>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

i've tryed to install u-boot using minicom, but i'm not able to=20
configure in shell boot params,=20
using this...

boot device          : motfcc
unit number          : 0
processor number     : 0
host name            : motfcc0
inet on ethernet (e) : 192.168.0.4
inet on backplane (b): 192.168.0.4
host inet (h)        : 192.168.0.3
gateway inet (g)     : 192.168.0.3
flags (f)            : 0x80
target name (tn)     : sbc8260

when i reboot target it appears in minicom the message below:

AT S7=3D45 S0=3D0 L1 V1 X4 &c1 E1 Q0
0x1f058b0 (tBoot): miiPhyInit check cable connection
Attached TCP/IP interface to motfcc0.
Warning: no netmask specified.
Attaching network interface lo0... done.
Loading... Erroneous header read

Error loading file: errno =3D 0x610001.
Can't load boot file!!
=C3=BC

my questions are?
what file must i put into target?(u-boot.bin?)
in which way can i upload it?(using tftp with 192.168.0.4 and using=20
put command, it gives timeout for transmission, but ping to=20
192.168.0.3=20
works normally until in minicom appears error message)

Please help me to configure and install u-boot
thanks very much!!!


Naviga e telefona senza limiti con Tiscali    =20
Scopri le promozioni Tiscali adsl: navighi e telefoni senza canone Telecom

http://abbonati.tiscali.it/adsl/
