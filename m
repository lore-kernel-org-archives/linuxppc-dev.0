Return-Path: <clemens.koller@anagramm.de>
Received: from moutvdomng.kundenserver.de (moutvdom.kundenserver.de
	[212.227.126.249]) by ozlabs.org (Postfix) with ESMTP id 5D2FF68802
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 17 Dec 2005 02:47:06 +1100 (EST)
Received: from [212.227.126.221] (helo=mrvdomng.kundenserver.de)
	by moutvdomng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1EnHnU-0000RM-00
	for linuxppc-embedded@ozlabs.org; Fri, 16 Dec 2005 16:47:04 +0100
Received: from [84.154.117.202] (helo=[192.168.1.10])
	by mrvdomng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1EnHnT-0008Jc-00
	for linuxppc-embedded@ozlabs.org; Fri, 16 Dec 2005 16:47:03 +0100
Message-ID: <43A2E175.9050004@anagramm.de>
Date: Fri, 16 Dec 2005 16:47:01 +0100
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: kernel 2.6.15-rc5-latest doesn't work anymore on mpc8540ads
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

I am just about to update my kernel from 2.6.13-rc7 which is working
fine to linus' 2.6.15-rc5-latest git on my mpc8540ads flavored board.
However, the kernel hangs pretty early after

openpic: exit

any ideas or a hint what's wrong there... before I start to
debug deeper into the code?

Thanks,

Clemens

-----8<-----
U-Boot 1.1.3 (Jun 23 2005 - 10:40:01)

CPU:   8540, Version: 2.0, (0x80300020)
Core:  E500, Version: 2.0, (0x80200020)
Clocks Configuration:
       CPU: 825 MHz, CCB: 330 MHz,
       DDR: 165 MHz, LBC:  82 MHz
L1:    D-cache 32 kB enabled
       I-cache 32 kB enabled
Board: MicroSys PM854
    PCI1: 32 bit, 66 MHz (compiled)
I2C:   ready
DRAM:  Initializing
    DDR: 256 MB
FLASH: 32 MB
L2:    256 kB enabled
In:    serial
Out:   serial
Err:   serial
Net:   ENET0: PHY is Marvell 88E1111S (1410cc2)
ENET1: PHY is Marvell 88E1111S (1410cc2)
ENET2: PHY is LXT971 (1378e2)
ENET0, ENET1, ENET2
Hit any key to stop autoboot:  0
## Booting image at fe300000 ...
   Image Name:   Linux-2.6.15-rc5-g7116317d
   Created:      2005-12-16  15:30:40 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1394968 Bytes =  1.3 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
mpc8540ads_init(): exit
id mach(): done
MMU:enter
MMU:hw init
MMU:mapin
MMU:setio
MMU:exit
setup_arch: enter
setup_arch: bootmem
mpc8540ads_setup_arch()
arch: exit
openpic: enter
openpic: timer
openpic: external
openpic: spurious
openpic: exit

-----8<----

-- 
Clemens Koller
_______________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Str. 45/1
81379 Muenchen
Germany

http://www.anagramm.de
Phone: +49-89-741518-50
Fax: +49-89-741518-19
