Return-Path: <mamsadegh@hotmail.com>
Received: from bay0-omc1-s23.bay0.hotmail.com (bay0-omc1-s23.bay0.hotmail.com
	[65.54.246.95]) by ozlabs.org (Postfix) with ESMTP id 0FA77DDED4
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 23 Jun 2007 22:19:13 +1000 (EST)
Message-ID: <BAY115-W1188529D49F71948165AF6B2160@phx.gbl>
From: Mohammad Sadegh Sadri <mamsadegh@hotmail.com>
To: Andrei Konovalov <akonovalov@ru.mvista.com>, Linux PPC Linux PPC
	<linuxppc-embedded@ozlabs.org>, Grant Likely <grant.likely@secretlab.ca>
Subject: ML403 gigabit ethernet bandwidth - 2.6 kernel 
Date: Sat, 23 Jun 2007 12:19:12 +0000
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Dear all,

Recently we did a set of tests on performance of virtex 4FX hard TEMAC modu=
le using ML403

we studied all of the posts here carefully: these are the system characteri=
stics;

Board : ML403=20
EDK    : EDK9.1SP2
Hard TEMAC version and PLTEMAC version are both 3.0.a
PPC clock frequency :  300MHz
Kernel : 2.6.21-rc7 , downloaded from grant's git tree some thing near one =
week ago
DMA type: 3 (sg dma)
DRE : enabled for TX and RX, (2)
CSUM offload is enabled for both of TX and RX
tx and rx fifo sizes : 131072 bits

the board comes up over NFS root file system completely and without any pro=
blems.=20

PC system used for these tests is : CPU P4 Dual Core, 3.4GHz , 2Gigabytes m=
emory, Dual gigabit ethernet port, running linux 2.6.21.3=20
We have tested the PC system band width and it can easily reach 966mbits/s =
when connected to the same PC. ( using the same cross cable used for ml403 =
test)

Netperf is compiled with TCP SEND FILE enabled, ( -DHAVE_SENDFILE)

(from board to PC)
netperf -t TCP_SENDFILE -H 10.10.10.250 -F /boot/zImage.elf -- -m 16384 -s =
87380 -S 87380 =20

the measured bandwidth for this test was just 40.66Mbits. =20
It is also true for netperf from PC to board.

we do not have any more idea about what we should do to improve the bandwid=
th.=20
any help or ideas is appreciated...

_________________________________________________________________
Connect to the next generation of MSN Messenger=A0
http://imagine-msn.com/messenger/launch80/default.aspx?locale=3Den-us&sourc=
e=3Dwlmailtagline=
