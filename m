MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: PCI/DMA on 8266 under 2.6.3
Date: Fri, 5 Mar 2004 20:27:38 -0600
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B06DA86@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi

Has anybody gotten PCI to work correctly under linux 2.6.3 (or any 2.6)
on motorola 8266?

I have managed to get the driver from 2.4.24 to work under 2.6.3, but I
keep getting sporadic bit/byte errors on files written to disk over PCI
with DMA enabled. (SiI680 IDE controller)
The Ide driver and PCI works correct under 2.4.24

Rune Torgersen
System Developer
Innovative Systems LLC
1000 Innovative Drive
Mitchell, SD 57301
Ph: 605-995-6120
www.innovsys.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
