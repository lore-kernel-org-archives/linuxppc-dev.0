Return-Path: <clemens.koller@anagramm.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.176]) by ozlabs.org (Postfix) with ESMTP id 19F622BF0E
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 14 Jan 2005 21:48:44 +1100 (EST)
Received: from [212.227.126.161] (helo=mrelayng.kundenserver.de)
	by moutng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1CpP0L-0003N1-00
	for linuxppc-embedded@ozlabs.org; Fri, 14 Jan 2005 11:48:34 +0100
Received: from [217.80.228.140] (helo=[192.168.1.10])
	by mrelayng.kundenserver.de with asmtp (Exim 3.35 #1)
	id 1CpP0L-0005cJ-00
	for linuxppc-embedded@ozlabs.org; Fri, 14 Jan 2005 11:48:33 +0100
Message-ID: <41E7A410.6060008@anagramm.de>
Date: Fri, 14 Jan 2005 11:50:56 +0100
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: Kernel 2.6.x to MPC8540/Microsys Board
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

I am about to do my first steps to boot a 2.6 Kernel on the
PM854 Board from Microsys (MPC8540) to see how well it works.
I use U-Boot 1.1.2 and the 2.4.26 Kernel from Microsys compiles and
runs fine on the Board as intended.

Now I 've tried the official 2.6.10 Kernel and (cross-)compiled it
within ELDK 3.1 (btw: is there any difference in between ppc_6xx- and 
ppc_82xx- ?) which works fine, too.
I just started with the mpc8540ads platform with early printk and 
otherwise everything disabled (I want a small kernel) and manually
built the vmlinux.UBoot using mkimage. I just want to see if
something comes up to the console (serial port). Well, currently,
it stops at:

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
ocp: exit
mpc8540ads_setup_arch()
arch: exit
openpic: enter
openpic: timer
openpic: external
openpic: spurious
openpic: exit

Okay. I am not really worried about that... at least I got a sign of 
life and debugging output :-)

My questions are now:
Which is the best Kernel source tree to start porting 2.6.x to the pm854 
platform? I would prefer to stuck with the official sources. Is that a 
good idea?

Is it a good idea to just 'copy' the pm854 platform specific files (PCI 
  initialization and some MTD driver options) to the 2.6.10 tree and see
how it works?

As there anybody who has already a working 2.6.10-something for MPC8540 
(well, non mpc8540ads).

Best greets,

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
