Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <0B0A39652BB0D411BCCF00508B9512EC08AEB3FC@tx14exm05.ftw.mot.com>
From: Yu Bo-BOYU1 <Bo.Yu@motorola.com>
To: linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: 8260 configuration
Date: Tue, 1 Oct 2002 20:07:39 -0500 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am new to embedded linux but I had good experience in vxWorks.
Right now I had a custom 8260 board with SMC1 connected to serial
port and FCC3 for fast ethernet. I would like to try running linux on this
custom board. I downloaded the latest monta vista preview kit 2.1
as my base release.

I had boot code ( with vxWorks and it is based on EST8260 bsp) in my custom
board
already. I decide to download the linux object via tftp. But I have the
following
questions:

1. Do I have to configure IMMR as 0xF0000_0000 or higher. The default
configuration
    in our boot is 0x0F00_0000 ? Is this a hard requirement or not ? If so,
why can't linux
    init code do so by writing to IMMR+0x101a8 ?

2. How to specify the start address where linux runs when I build the zImage
?

3. When I make xconfig, what configuration I must have in order to run ? I
certainly
   do not need VGA/HARD DISK/PCI (this board does not have pci devices).

4. Is there any good website/paper/documentation about linux for 8260
platform.

5. Can anyone access ftp.leo.org to get ELDK ? I can ping it but I cannot
ftp it today.

Thanks.

Bo

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
