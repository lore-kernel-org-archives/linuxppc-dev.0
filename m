Message-ID: <2C1BAF8F8E1DD611862B0002A5D4C3FC02B6D060@renexch3.rennes.thmulti.com>
From: Fillod Stephane <stephane.fillod@thomson.net>
To: "'Bob White'" <bwhite@perigee.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: RE: Dual-Port SRAM
Date: Tue, 4 May 2004 10:48:04 +0200 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Bob White wrote:
> What configuration is necessary to map this memory into the kernel?

You need ioremap() and a good book on Linux Kernel Driver development.
Excellent examples are in linux/drivers directory.

> Can you point me to some examples?  How does it then get accessed from
> a user program?

Bob, Wolfgang was talking about this reply ;-)


So, here is the FAQ:

Please have a look at Denx's FAQ for accessing memory bus:


http://www.denx.de/twiki/bin/view/PPCEmbedded/DeviceDrivers#Section_Accessin
gPeripheralsFromUserSpace

For more information, please follow this thread:
	http://lists.linuxppc.org/linuxppc-embedded/200403/msg00059.html


Next time, google and list archive are your friend ;-)


Regards,
Stephane

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
