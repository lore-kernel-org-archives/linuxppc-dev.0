MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: 8260 configuration
Date: Wed, 2 Oct 2002 09:22:40 +0200
Message-ID: <1E354700654661418593A0D6B5A9D410A36223@mail.azisa.co.za>
From: "Flavio Pereira" <fpereira@azisa.com>
To: "Yu Bo-BOYU1" <Bo.Yu@motorola.com>
Cc: "linuxppc embedded" <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Bo

1. Yes the IMMR needs to be configured at least above 0xC0000000. The
kernel executes code at 0xC0000000, and an IMMR lower that this will
cause the kernel to crash as soon as it starts executing code. I
recommend that you stay with the default value 0xF0000000.

2. The start address is fixed to 0x0

3. ?

4. No, not that I know of.

5. Try getting ELDK from the Denx site. (www.denx.de)



-----Original Message-----
From: Yu Bo-BOYU1 [mailto:Bo.Yu@motorola.com]
Sent: Wednesday, October 02, 2002 3:08 AM
To: linuxppc embedded
Subject: 8260 configuration


I am new to embedded linux but I had good experience in vxWorks.
Right now I had a custom 8260 board with SMC1 connected to serial
port and FCC3 for fast ethernet. I would like to try running linux on
this
custom board. I downloaded the latest monta vista preview kit 2.1
as my base release.

I had boot code ( with vxWorks and it is based on EST8260 bsp) in my
custom
board
already. I decide to download the linux object via tftp. But I have the
following
questions:

1. Do I have to configure IMMR as 0xF0000_0000 or higher. The default
configuration
    in our boot is 0x0F00_0000 ? Is this a hard requirement or not ? If
so,
why can't linux
    init code do so by writing to IMMR+0x101a8 ?

2. How to specify the start address where linux runs when I build the
zImage
?

3. When I make xconfig, what configuration I must have in order to run ?
I
certainly
   do not need VGA/HARD DISK/PCI (this board does not have pci devices).

4. Is there any good website/paper/documentation about linux for 8260
platform.

5. Can anyone access ftp.leo.org to get ELDK ? I can ping it but I
cannot
ftp it today.

Thanks.

Bo


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
