Message-ID: <39CEAB4D.C07E39A7@Colorado.EDU>
Date: Sun, 24 Sep 2000 17:32:22 -0600
From: Alex Vallens <Vallens@Colorado.EDU>
MIME-Version: 1.0
To: linuxppc mail list <linuxppc-dev@lists.linuxppc.org>
Subject: installing on a new PowerBook
Content-Type: text/plain; charset=us-ascii; x-mac-type="54455854"; x-mac-creator="4D4F5353"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I just got one of the brand new Pismo PowerBooks (supposedly identical
to the previous generation, but with larger HDs, 20 GB in my case). I
haven't been able to boot it at all. Everytime I boot, I get the
following kernel output regarding my drive:

hda: IBM-DJSA-220, ATA DISK drive
ide0 at 0x8x01f000-0x8e01f007, 0x8e01f160 on irq 19
hda: Enabling Ultra DMA 4
hda: IBM-DJSA-220, 19077MB w/1874kB Cache, CHS=38760/16/63, (U)DMA
Partition check:
    hda:<7>ohci-control thread code for 0xc06370e0 code at 0xc0167d18
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
 hda1hda: lost interrupt
 hda2 hda3hda: lost interrupt
 hda4 hda5hda: lost interrupt
 hda6 hda7hda: lost interrupt
 hda8 hda9hda: lost interrupt
 hda10 hda11
RAMDISK: Compressed image found at block 0
EXZT-fs warning: maximal count reached, runing e2fsck is recommended
VFS: Mounted root (ext2 filesystem)

hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
<repeats indefinitely>


It finds the bus and the drive, but hangs trying to mount. So, I tried
to reinitialize the device map using pdisk. Unfortunately, pdisk run
under the MacOS is unable to recognize the device (I type "e
/dev/ata2.0" at the command prompt, but it says "pdisk: can't open file
'/dev/ata2.0'"). From the get info in MacOS, I know that the hard drive
is id 0 on bus 2 of the ata, so that command should be correct. pdisk,
however, only recognizes '/dev/ata0.0', which is the internal DVD-ROM
drive.

How can I get Linux to recognize the drive? Will downloading the newest
dev. kernel from Paul M's site help, or am I stuck? Why doesn't pdisk
recongnize my drive?

Alex


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
