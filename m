Message-ID: <C18BA5DDB58DD511BD0700C0DF0DD45029418E@NTSERVER4>
From: linuxppc <linuxppc@4bridgeworks.com>
To: Linux PPC Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Converting 2.6 drivers to 2.4
Date: Tue, 29 Jun 2004 09:30:19 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I need a driver for the ibm emac cicada 8201 chip for the 2.4 kernel, I have
found a 2.6 kernel driver by Matt Porter, however this has a #include
<linux/dma-mapping.h>, which is not in the 2.4 kernel. Is there anywhere I
can find out what the equivelant header file is in the 2.4 kernel?


Cheers

Daren

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
