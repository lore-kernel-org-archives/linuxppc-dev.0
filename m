Subject: Trying to Build ArmBoot for EPXA1
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Thu, 4 Dec 2003 08:21:06 -0500
Message-ID: <704F2B356FCC3E49A909C625BD9E5C40040261@ultsol01.tewks.ultsol.local>
From: "Fahd Abidi" <fabidi@ultsol.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I am trying to build armboot for the EPXA1, I know a ppc group might
not be the best place to post but I was hoping someone here could
give me pointers where to look or what to do. When I try and build
ArmBoot 1.0 for the EPXA1 using mvista tools for the 920t I load the
.hex file onto the board using the exc_flash_programmer but I get no
response form the serial port. I then repeated the process using the
arm9TDI tools from denx and got the same behavior. I was wondering if
anyone had successfully built and loaded armboot onto the EPXA1 and
what tools they used to do it.

Also Separately, I downloaded the Mvista Linux Preview Kit 3.0 for
the EPXA1 board. It comes with Armboot sources init, when I try and
compile this using the mvista tools I get the following message:

/opt/hardhat/previewkit/arm/920t_le/bin/arm_920t_le-ld: ERROR: board/epxa1db/excalibur.o uses hardware FP, whereas armboot uses software FP
File format not recognized: failed to merge target specific data of file board/epxa1db/excalibur.o
/opt/hardhat/previewkit/arm/920t_le/bin/arm_920t_le-ld: ERROR: /opt/quartus/libraries/software/boot/libboot_xa_ads.a(boot-arm-ADS.o) is compiled for EABI version 2, whereas armboot is compiled for version 0
File format not recognized: failed to merge target specific data of file /opt/quartus/libraries/software/boot/libboot_xa_ads.a(boot-arm-ADS.o)
make: *** [armboot] Error 1
[root@localhost armboot]#

It looks like there is a FP mismatch in armboot. Once again I am just
looking for pointers.

thanks allot!!

Fahd Abidi

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
