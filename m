From: "Geiser, Ian" <geiseri@msoe.edu>
To: Alex Vallens <Vallens@Colorado.EDU>
Cc: linuxppc mail list <linuxppc-dev@lists.linuxppc.org>
Date: Sun, 24 Sep 2000 21:55:06 -0500 (CDT)
Subject: Re: installing on a new PowerBook
In-Reply-To: <39CEAB4D.C07E39A7@Colorado.EDU>
Message-ID: <Pine.LNX.4.10.10009242152320.3052-100000@sleepchamber.geekcentral.msoe.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 24 Sep 2000, Alex Vallens wrote:
Dut to the fact that the new Pismo came out after LinuxPPC 2000
there were some updates.

There were in fact some significant changes, so check out
http://www.linuxppc.com/support/updates/product/?catagory=2000&subject=firewire_G3_portable

also instead of there Boot image use mine at:
ftp://ftp.linuxppc.org/users/geiseri/LinuxPPC_Boot.smi.hqx

-ian reinhart geiser
>
> I just got one of the brand new Pismo PowerBooks (supposedly identical
> to the previous generation, but with larger HDs, 20 GB in my case). I
> haven't been able to boot it at all. Everytime I boot, I get the
> following kernel output regarding my drive:
>
> hda: IBM-DJSA-220, ATA DISK drive
> ide0 at 0x8x01f000-0x8e01f007, 0x8e01f160 on irq 19
> hda: Enabling Ultra DMA 4
> hda: IBM-DJSA-220, 19077MB w/1874kB Cache, CHS=38760/16/63, (U)DMA
> Partition check:
>     hda:<7>ohci-control thread code for 0xc06370e0 code at 0xc0167d18
> hda: lost interrupt
> hda: lost interrupt
> hda: lost interrupt
> hda: lost interrupt
>  hda1hda: lost interrupt
>  hda2 hda3hda: lost interrupt
>  hda4 hda5hda: lost interrupt
>  hda6 hda7hda: lost interrupt
>  hda8 hda9hda: lost interrupt
>  hda10 hda11
> RAMDISK: Compressed image found at block 0
> EXZT-fs warning: maximal count reached, runing e2fsck is recommended
> VFS: Mounted root (ext2 filesystem)
>
> hda: lost interrupt
> hda: lost interrupt
> hda: lost interrupt
> hda: lost interrupt
> hda: lost interrupt
> hda: lost interrupt
> hda: lost interrupt
> hda: lost interrupt
> <repeats indefinitely>
>
>
> It finds the bus and the drive, but hangs trying to mount. So, I tried
> to reinitialize the device map using pdisk. Unfortunately, pdisk run
> under the MacOS is unable to recognize the device (I type "e
> /dev/ata2.0" at the command prompt, but it says "pdisk: can't open file
> '/dev/ata2.0'"). From the get info in MacOS, I know that the hard drive
> is id 0 on bus 2 of the ata, so that command should be correct. pdisk,
> however, only recognizes '/dev/ata0.0', which is the internal DVD-ROM
> drive.
>
> How can I get Linux to recognize the drive? Will downloading the newest
> dev. kernel from Paul M's site help, or am I stuck? Why doesn't pdisk
> recongnize my drive?
>
> Alex
>
>
>

.---------------------------------------------------.
| Ian Reinhart Geiser - Computer Engineering Student|
| HOME: <geiseri@msoe.edu>                          |
| WORK: <geiseri@linuxppc.com>                      |
| WEB:  http://www.msoe.edu/~geiseri                |
`---------------------------------------------------'

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
