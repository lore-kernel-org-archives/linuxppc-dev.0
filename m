Message-ID: <3DD1486F.50408@rmsweldingsystems.com>
Date: Tue, 12 Nov 2002 11:29:03 -0700
From: Mike Moleschi <moleschi@rmsweldingsystems.com>
Reply-To: moleschi@rmsweldingsystems.com
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Accessing nvram rom the linux users space
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am using a PPC board running a version of Hard Hat linux, and
currently using version of the 2.4.20 kernel.  On the board there
are several places for storage: 32MB of SRAM, 4MB of flash-EPROM,
32kB of NVRAM, and 16k-bit serial EEPROM. The SRAM, flash and NVRAM
are memory mapped.  The NVRAM is actually battery backed up RAM
that includes a RTC in the last 8 bytes of addressed memory. Right
now there is nothing stored in the NVRAM (PPC Boot is stored in
part of the flash, and the PPC environment variable are in the
serial EEPROM.)  NVRAM is mapped from 0xF0200000 to 0xF0207FFF.

I would like to be able to uses the NVRAM from the linux users
space.  Ideally it would just be an extention of my filesystem,
where I could place one or two small files on it.  This would
let me store information that needs to be kept through a loss of
power.

So basically I think what I am trying to figure out, is how do I
mount the NVRAM as a disk.




--


Mike Moleschi
moleschi@rmsweldingsystems.com
RMS Welding Systems
1409 - 4th Street, Nisku, Alberta CANADA	T9E 7M9
Tel: (780)955-3907	Fax: (780)955-3996


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
