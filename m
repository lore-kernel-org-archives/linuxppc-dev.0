Message-ID: <2C1BAF8F8E1DD611862B0002A5D4C3FC02B6CFC6@renexch3.rennes.thmulti.com>
From: Fillod Stephane <stephane.fillod@thomson.net>
To: "'Steven Scholz'" <steven.scholz@imc-berlin.de>,
	LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: uncached user space mapping with mmap() ???
Date: Thu, 4 Mar 2004 15:15:27 +0100 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Steven,

> I am trying to access a hardware timer implemented in an FPGA from
> user space. I implemented a simple mmap() functionality (taken from
> Runbini's Linux Device Driver)

Please refer to "11.13. Accessing peripherals from user space"
in the excellent FAQ from DENX's TWiki at :

http://www.denx.de/twiki/bin/view/PPCEmbedded/DeviceDrivers#Section_Accessin
gPeripheralsFromUserSpace


There's no need to implement kernel side stuff. /dev/mem is enough.


Regards,

--
Stéphane

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
