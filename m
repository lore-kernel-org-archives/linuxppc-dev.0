Message-ID: <20040314050122.45623.qmail@web15205.mail.bjs.yahoo.com>
Date: Sun, 14 Mar 2004 13:01:22 +0800 (CST)
From: =?gb2312?q?song=20sam?= <samsongshzu@yahoo.com.cn>
Subject: some LINUX boot-up message loss
To: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <40530EA4.1070305@iti.fi>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I have a puzzle on booting LINUX under u-boot on my
custom 8xx board.Some boot-up message didn't come up
as DEMO board did.What's the problem with between
linux kernel and u-boot?For the sake of unsuccessful
behaviors on serveral big applications(some small
programs worked fine with booted linux kernel),I
suspect these unexpected results have something to do
with the loss message.Any hints?

Demo Board boot-up message:

u-boot>run flash_nfs
## Booting image at ff880000 ...
   Image Name:   Linux-2.4.18_mvl30-rpxlite
   Image Type:   PowerPC Linux Kernel Image (gzip
compressed)
   Data Size:    733665 Bytes = 716.5 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Current stack ends at 0x03FBE928 => set upper limit
to 0x00800000
## cmdline at 0x007FFF00 ... 0x007FFFA2
bd address  = 0x03FBEFC4
memstart    = 0x00000000
memsize     = 0x04000000
flashstart  = 0xFF000000
flashsize   = 0x01000000
flashoffset = 0x0001B400
sramstart   = 0x00000000
sramsize    = 0x00000000
immr_base   = 0xFA200000
bootflags   = 0x00000001
intfreq     =     48 MHz
busfreq     =     24 MHz
ethaddr     = 00:10:EC:00:37:5B
IP addr     = 172.16.115.7
baudrate    =   9600 bps
No initrd
## Transferring control to Linux (at address 00000000)
...
[kernel booted fine and applications did well]

My Board boot-up message:

u-boot>run net_nfs
TFTP from server 172.16.115.6; our IP address is
172.16.115.12
Filename 'uImage'.
Load address: 0x200000
Loading:
#################################################################
done
Bytes transferred = 741868 (b51ec hex)
## Booting image at 00200000 ...
   Image Name:   Linux-2.4.18_mvl30-rpxlite
   Image Type:   PowerPC Linux Kernel Image (gzip
compressed)
   Data Size:    741804 Bytes = 724.4 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
...
[kernel booted fine but some big applications failed]

Thanks in advance!

Sam

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
