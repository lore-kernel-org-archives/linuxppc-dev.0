Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.173])
	by ozlabs.org (Postfix) with ESMTP id 3EC1BDDEC3
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 18 Jan 2007 02:03:45 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so1961577ugf
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 17 Jan 2007 07:03:43 -0800 (PST)
Message-ID: <528646bc0701170703y496a952evedaf1e5215bcfc42@mail.gmail.com>
Date: Wed, 17 Jan 2007 08:03:42 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Aung Soe" <aung.aungkyawsoe@gmail.com>
Subject: Re: Linuxppc-embedded Digest, Vol 29, Issue 20
In-Reply-To: <d668b9080701170622q62f925c8pc65c8c91110732b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <mailman.773.1169042581.9285.linuxppc-embedded@ozlabs.org>
	<d668b9080701170622q62f925c8pc65c8c91110732b@mail.gmail.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 1/17/07, Aung Soe <aung.aungkyawsoe@gmail.com> wrote:
> There is a good book called Linux Device Driver's from Oreilly
>
> where it has a chapter/session explains how to probe PCI IRQs.
>
> Ebook is free to be downloaded.
>
> On 1/17/07, linuxppc-embedded-request@ozlabs.org

... 48 pages of text deleted ...

I have no idea which message you are responding to.  Please trim your
replys down to what you're replying to; *especially* when you're
replying to the daily digest.

g.


> <linuxppc-embedded-request@ozlabs.org> wrote:
> > Send Linuxppc-embedded mailing list submissions to
> >       linuxppc-embedded@ozlabs.org
> >
> > To subscribe or unsubscribe via the World Wide Web, visit
> >       https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> > or, via email, send a message with subject or body 'help' to
> >       linuxppc-embedded-request@ozlabs.org
> >
> > You can reach the person managing the list at
> >       linuxppc-embedded-owner@ozlabs.org
> >
> > When replying, please edit your Subject line so it is more specific
> > than "Re: Contents of Linuxppc-embedded digest..."
> >
> >
> > Today's Topics:
> >
> >    1. Re: PCI IRQ -MPC8540 (Kumar Gala)
> >    2. Re: PCI IRQ -MPC8540 (Kumar Gala)
> >    3. Problem getting machine check reset on 8245 (Jimmy Blair)
> >    4. ram-disk root file system (Dan Wilson)
> >    5. Who's the maintainer for the freescale MPC8349ITX board?
> >       (Bruce_Leonard@selinc.com)
> >    6. Re: ram-disk root file system (David H. Lynch Jr.)
> >    7. Temac and Sysace for ML403 (alayrac)
> >
> >
> > ----------------------------------------------------------------------
> >
> > Message: 1
> > Date: Tue, 16 Jan 2007 19:29:01 -0600
> > From: Kumar Gala <galak@kernel.crashing.org>
> > Subject: Re: PCI IRQ -MPC8540
> > To: agnel juni <junijoseph@yahoo.co.in>
> > Cc: linuxppc-embedded@ozlabs.org
> > Message-ID: <FC01A61F-56F4-4185-A199-1D3F05FAC470@kernel.crashing.org>
> > Content-Type: text/plain; charset=WINDOWS-1252; delsp=yes;
> >       format=flowed
> >
> >
> > On Jan 16, 2007, at 5:20 PM, agnel juni wrote:
> >
> > > Hello all:
> > >
> > > I would like to understand if there is a way to program the PCI
> > > interrupt pin register of MPC8540. I did look for this in the
> > > datasheet, but couldn't find any positive answer.
> > >
> > > Currently, I am working in a set-up where MPC8540 is an agent,
> > > plugged into the PC host.
> > > I couldn't get an IRQ for the card when plugged in some PCI slots,
> > > whereas in one of the slots I do see a non-zero value.
> > >
> > > It would be great if you could help me understand the issue.
> > >
> > > I am sorry if the question is inapporpriate in the group. I am
> > > desperate to solve the issue.
> > >
> > > Thanks for any help.
> >
> > You need to find out how the PCI edge interrupts are wired on you
> > board than we can talk about how to generate an interrupt based on
> > that.  I'd guess IRQ_OUT is wired to INTA, but it would be good to
> > verify that.
> >
> > - k
> >
> > > J.Joseph
> > >
> > > ----- Original Message ----
> > > From: Kumar Gala <galak@kernel.crashing.org>
> > > To: Wang Matthew-R59995 <Qi.W@freescale.com>
> > > Cc: linuxppc-embedded@ozlabs.org
> > > Sent: Wednesday, 18 October, 2006 6:54:24 PM
> > > Subject: Re: Linuxppc-embedded Digest, Vol 26, Issue 36
> > >
> > >
> > > On Oct 18, 2006, at 8:10 PM, Wang Matthew-R59995 wrote:
> > >
> > > > Hi Kumar,
> > > >
> > > > Actually I do many trials about it. Vxwerks Bootrom is smaller than
> > > > U-Boot. The key difference between Bootrom and U-boot is that some
> > > > source code of Bootrom is invisible to the users.
> > > >
> > > > Actually the rfi instruction which I point out is the first rfi
> > > > instruction of Linux PowerPC bringup.
> > > >
> > > > Before that, it's TLB entry invalidation and temp TLB entry mapping.
> > > >
> > > > I check MMU setting carefully before coming Linux Kernel.
> > > >
> > > > I just want to know if other guys met similar scenario like me. I
> > > > don't
> > > > need the precise answer, just overall suggestion about it because I
> > > > understand that not everyone has the same bootloader of mine, that
> > > > bootloader is actually a customized bootloader.
> > >
> > > I understand that, thus I was asking what exact problem you were
> > > seeing to try and help.
> > >
> > > > Anyway thank you.
> > > >
> > > > R9 point to LR register, mask the high 20 bit of r9 and send to r7,
> > > > and
> > > > then add 24, which means stride 6 instructions for rfi instruction
> > > > execution.
> > > >
> > > > Of course, rfi can switch the TLB entry, both the previous TLB
> > > > entry and
> > > > the temp TLB entry point to the same physical address.
> > > >
> > > > I've checked it.
> > >
> > > I know what the code does, I wrote it :)
> > >
> > > - kumar
> > >
> > >
> > >
> > > _______________________________________________
> > > Linuxppc-embedded mailing list
> > > Linuxppc-embedded@ozlabs.org
> > > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> > >
> > >
> > > Here?s a new way to find what you're looking for - Yahoo! Answers
> >
> >
> >
> > ------------------------------
> >
> > Message: 2
> > Date: Tue, 16 Jan 2007 19:56:20 -0600
> > From: Kumar Gala <galak@kernel.crashing.org>
> > Subject: Re: PCI IRQ -MPC8540
> > To: agnel juni <junijoseph@yahoo.co.in>
> > Cc: "linuxppc-embedded@ozlabs.org \(\(\(\(E-Mail\)\)\)\)"
> >       <linuxppc-embedded@ozlabs.org>
> > Message-ID: <5C902FB2-CF5C-466A-B7AF-8D0B4BFA1A25@kernel.crashing.org>
> > Content-Type: text/plain; charset=WINDOWS-1252; delsp=yes;
> >       format=flowed
> >
> > What kinda of interrupt do you want on IRQ_OUT/INTA?
> >
> > - k
> >
> > On Jan 16, 2007, at 7:54 PM, agnel juni wrote:
> >
> > > Yes IRQ_OUT is wired to INTA.
> > >
> > > Could you please advise on how to generate interrupt for this.
> > >
> > > Thanks
> > > J-
> > >
> > > ----- Original Message ----
> > > From: Kumar Gala <galak@kernel.crashing.org>
> > > To: agnel juni <junijoseph@yahoo.co.in>
> > > Cc: linuxppc-embedded@ozlabs.org
> > > Sent: Tuesday, 16 January, 2007 5:29:01 PM
> > > Subject: Re: PCI IRQ -MPC8540
> > >
> > >
> > > On Jan 16, 2007, at 5:20 PM, agnel juni wrote:
> > >
> > > > Hello all:
> > > >
> > > > I would like to understand if there is a way to program the PCI
> > > > interrupt pin register of MPC8540. I did look for this in the
> > > > datasheet, but couldn't find any positive answer.
> > > >
> > > > Currently, I am working in a set-up where MPC8540 is an agent,
> > > > plugged into the PC host.
> > > > I couldn't get an IRQ for the card when plugged in some PCI slots,
> > > > whereas in one of the slots I do see a non-zero value.
> > > >
> > > > It would be great if you could help me understand the issue.
> > > >
> > > > I am sorry if the question is inapporpriate in the group. I am
> > > > desperate to solve the issue.
> > > >
> > > > Thanks for any help.
> > >
> > > You need to find out how the PCI edge interrupts are wired on you
> > > board than we can talk about how to generate an interrupt based on
> > > that.  I'd guess IRQ_OUT is wired to INTA, but it would be good to
> > > verify that.
> > >
> > > - k
> > >
> > > > J.Joseph
> > > >
> > > > ----- Original Message ----
> > > > From: Kumar Gala <galak@kernel.crashing.org>
> > > > To: Wang Matthew-R59995 <Qi.W@freescale.com>
> > > > Cc: linuxppc-embedded@ozlabs.org
> > > > Sent: Wednesday, 18 October, 2006 6:54:24 PM
> > > > Subject: Re: Linuxppc-embedded Digest, Vol 26, Issue 36
> > > >
> > > >
> > > > On Oct 18, 2006, at 8:10 PM, Wang Matthew-R59995 wrote:
> > > >
> > > > > Hi Kumar,
> > > > >
> > > > > Actually I do many trials about it. Vxwerks Bootrom is smaller
> > > than
> > > > > U-Boot. The key difference between Bootrom and U-boot is that some
> > > > > source code of Bootrom is invisible to the users.
> > > > >
> > > > > Actually the rfi instruction which I point out is the first rfi
> > > > > instruction of Linux PowerPC bringup.
> > > > >
> > > > > Before that, it's TLB entry invalidation and temp TLB entry
> > > mapping.
> > > > >
> > > > > I check MMU setting carefully before coming Linux Kernel.
> > > > >
> > > > > I just want to know if other guys met similar scenario like me. I
> > > > > don't
> > > > > need the precise answer, just overall suggestion about it
> > > because I
> > > > > understand that not everyone has the same bootloader of mine, that
> > > > > bootloader is actually a customized bootloader.
> > > >
> > > > I understand that, thus I was asking what exact problem you were
> > > > seeing to try and help.
> > > >
> > > > > Anyway thank you.
> > > > >
> > > > > R9 point to LR register, mask the high 20 bit of r9 and send to
> > > r7,
> > > > > and
> > > > > then add 24, which means stride 6 instructions for rfi instruction
> > > > > execution.
> > > > >
> > > > > Of course, rfi can switch the TLB entry, both the previous TLB
> > > > > entry and
> > > > > the temp TLB entry point to the same physical address.
> > > > >
> > > > > I've checked it.
> > > >
> > > > I know what the code does, I wrote it :)
> > > >
> > > > - kumar
> > > >
> > > >
> > > >
> > > > _______________________________________________
> > > > Linuxppc-embedded mailing list
> > > > Linuxppc-embedded@ozlabs.org
> > > > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> > > >
> > > >
> > > > Here?s a new way to find what you're looking for - Yahoo! Answers
> > >
> > >
> > >
> > > Here?s a new way to find what you're looking for - Yahoo! Answers
> >
> >
> >
> > ------------------------------
> >
> > Message: 3
> > Date: Tue, 16 Jan 2007 17:53:47 -0800
> > From: Jimmy Blair <blueskyjb@verizon.net>
> > Subject: Problem getting machine check reset on 8245
> > To: linuxppc-embedded@ozlabs.org
> > Message-ID: <45AD81AB.4010709@verizon.net>
> > Content-Type: text/plain; charset=ISO-8859-1; format=flowed
> >
> > I implemented do_reset in Linux 2.6 using the
> > reset method of U-Boot -- turn off the MMU and write
> > to an invalid address.  Sometimes I the desired reboot.
> > If I change the code a bit (e.g. put a 'nop' just ahead
> > of turning off the MMU), I'll get an "Invalid floating
> > point instruction" exception.  How is that possible??
> > I didn't thing printk shouldn't would work if the MMU is turned off.
> > Has anybody seen anything like this?? Thanks!
> >
> >
> > ------------------------------
> >
> > Message: 4
> > Date: Tue, 16 Jan 2007 21:02:05 -0800
> > From: "Dan Wilson" <dwilson@dslextreme.com>
> > Subject: ram-disk root file system
> > To: linuxppc-embedded@ozlabs.org
> > Message-ID: <200701162102050578.1213ACC0@smtp.dslextreme.com>
> > Content-Type: text/plain; charset="ISO-8859-1"
> >
> > We are attempting to use an initrd ram-disk as the permanent root file
> > system for a MPC8541-based system.
> >
> > We are using ELDK 4 to cross-compile, and are running linux 2.6.15 kernel,
> > with u-boot 1.1.6 as our bootloader.
> >
> > I built an initrd file system, compressed it, then ran mkimage against it,
> > and it seems to be successfully loaded by u-boot, and linux sees the initrd
> > file and claims to have mounted it.  However, it then reports that it is
> > unable to find any files on the mounted root file system, as shown in the
> > log below.  I added some additional diagnostics to show what the error codes
> > were, and what was happening, but do not understand what I might have done
> > wrong.  If I boot linux from an NFS system or from compact flash, I am able
> > to mount the image and see all the files, so I believe the initrd file
> > system was created correctly.
> >
> > Here's the trace.  Any help or pointers that anyone can give will be greatly
> > appreciated!
> >
> > Thanks,
> > Dan.
> >
> > Speed: 100, half duplex
> > Using TSEC0 device
> > TFTP from server 10.0.80.16; our IP address is 10.0.55.91
> > Filename 'dw_eldk'.
> > Load address: 0x4000000
> > Loading: #################################################################
> >           #################################################################
> >           #################################################################
> >           ###############################
> > done
> > Bytes transferred = 1154111 (119c3f hex)
> > Speed: 100, half duplex
> > Using TSEC0 device
> > TFTP from server 10.0.80.16; our IP address is 10.0.55.91
> > Filename 'fm2224ep_initrd.uboot'.
> > Load address: 0x4200000
> > Loading: #################################################################
> >           #################################################################
> >           #################################################################
> >           #################################################################
> >           #################################################################
> >           #################################################################
> >           #################################################################
> >           #################################################################
> >           #################################################################
> >           #################################################################
> >           #################################################################
> >           #################################################################
> >           #################################################################
> >           #################################################################
> >           #################################################################
> >           #################################################################
> >           #################################################################
> >           ####################################
> > done
> > Bytes transferred = 5840574 (591ebe hex)
> > ## Booting image at 04000000 ...
> >     Image Name:   Linux-2.6.15
> >     Image Type:   PowerPC Linux Kernel Image (gzip compressed)
> >     Data Size:    1154047 Bytes =  1.1 MB
> >     Load Address: 00000000
> >     Entry Point:  00000000
> >     Verifying Checksum ... OK
> >     Uncompressing Kernel Image ... OK
> > ## Loading RAMDisk Image at 04200000 ...
> >     Image Name:   FM2224EP Ramdisk Image
> >     Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
> >     Data Size:    5840510 Bytes =  5.6 MB
> >     Load Address: 00000000
> >     Entry Point:  00000000
> >     Verifying Checksum ... OK
> >     Loading Ramdisk to 1f92c000, end 1febde7e ... OK
> > Memory CAM mapping: CAM0=256Mb, CAM1=256Mb, CAM2=0Mb residual: 0Mb
> > Linux version 2.6.15 (dwilson@washington) (gcc version 4.0.0 (DENX ELDK
> > 4.0 4.0.0)) #6 Tue Jan 16 15:00:18 PST 2007
> > fm2224ep_setup_arch
> > CDS Version = f0 in PCI slot 1
> > Built 1 zonelists
> > Kernel command line: root=/dev/ram
> > ip=10.0.55.91:10.0.80.21:10.0.0.254:255.255.0.0:FM2224EP_67:eth0
> > console=ttyS0,9600
> > nfsroot=10.0.80.21:/vol/local/common/kirkwood/hosts/eldk-test,v3,tcp rw
> > init=/bin/ash
> > OpenPIC Version 1.2 (1 CPUs and 60 IRQ sources) at fcfb8000
> > PID hash table entries: 4096 (order: 12, 65536 bytes)
> > Warning: real time clock seems stuck!
> > Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
> > Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
> > Memory: 510976k available (1880k kernel code, 512k data, 136k init, 0k
> > highmem)
> > Mount-cache hash table entries: 512
> > populate_roots calling unpack_to_roots: start = c0257000, end=c0257085,
> > len=85
> > checking if image is initramfs...<3>image check, start=df92c000,
> > end=dfebde7e, err=c01dae84
> > it isn't (no cpio magic); looks like an initrd
> > wasn't initramfs (no cpio magic), opening /initrd.image, fd=0
> > Freeing initrd memory: 5703k freed
> > NET: Registered protocol family 16
> > PCI: Probing PCI hardware
> > Generic PHY: Registered new driver
> > JFFS2 version 2.2. (NAND) (C) 2001-2003 Red Hat, Inc.
> > io scheduler noop registered
> > io scheduler anticipatory registered
> > io scheduler deadline registered
> > io scheduler cfq registered
> > Generic RTC Driver v1.07
> > Serial: 8250/16550 driver $Revision: #1 $ 4 ports, IRQ sharing disabled
> > serial8250.0: ttyS0 at MMIO 0xe0004500 (irq = 90) is a 16550A
> > serial8250.0: ttyS1 at MMIO 0xe0004600 (irq = 90) is a 16550A
> > RAMDISK driver initialized: 16 RAM disks of 32768K size 1024 blocksize
> > loop: loaded (max 8 devices)
> > Gianfar MII Bus: probed
> > eth0: Gianfar Ethernet Controller Version 1.2, 00:15:ed:00:09:41
> > eth0: Running with NAPI enabled
> > eth0: 256/256 RX/TX BD ring size
> > eth1: Gianfar Ethernet Controller Version 1.2, 07:de:29:00:07:de
> > eth1: Running with NAPI enabled
> > eth1: 256/256 RX/TX BD ring size
> > Marvell 88E1101: Registered new driver
> > Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> > ide: Assuming 50MHz system bus speed for PIO modes; override with idebus=xx
> > IDE phys mem : f0000000...f001ffff (size 0001ffff)
> > IDE virt base: 0xe1080000
> > CSR virt base: 0xe1100000
> > vector: 0x80c40072
> > port: 0xe1080002 => 0x00
> > port: 0xe1080007 => 0x00
> > port: 0xe108000b => 0x00
> > port: 0xe108000f => 0x00
> > port: 0xe1080013 => 0x00
> > port: 0xe1080017 => 0x00
> > port: 0xe108001b => 0xE0
> > port: 0xe108001f => 0x50
> > port: 0xe109001b => 0x50
> > port: 0xe1080000 => 0xF0
> > hda: SanDisk SDCFB-1024, CFA DISK drive
> > ide0 at 0xe1080002-0xe1080009,0xe109001b on irq 114
> > hda: max request size: 128KiB
> > hda: 2001888 sectors (1024 MB) w/1KiB Cache, CHS=1986/16/63
> > hda: cache flushes not supported
> >   hda: unknown partition table
> > i2c /dev entries driver
> > NET: Registered protocol family 2
> > IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
> > TCP established hash table entries: 131072 (order: 7, 524288 bytes)
> > TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
> > TCP: Hash tables configured (established 131072 bind 65536)
> > TCP reno registered
> > TCP bic registered
> > NET: Registered protocol family 1
> > NET: Registered protocol family 17
> > IP-Config: Complete:
> >        device=eth0, addr=10.0.55.91, mask=255.255.0.0, gw=10.0.0.254,
> >       host=FM2224EP_67, domain=, nis-domain=(none),
> >       bootserver=10.0.80.21, rootserver=10.0.80.21, rootpath=
> > init: ramdisk_execute_command = /init
> > loading ramdisk image initrd.image
> > RAMDISK: Compressed image found at block 0
> > EXT2-fs warning: checktime reached, running e2fsck is recommended
> > VFS: Mounted root (ext2 filesystem).
> > Freeing unused kernel memory: 136k init
> > run_init_process trying to exec /bin/ash
> > back from execve, errno=2
> > Failed to execute /bin/ash.  Attempting defaults...
> > run_init_process trying to exec /sbin/init
> > back from execve, errno=14
> > run_init_process trying to exec /etc/init
> > back from execve, errno=14
> > run_init_process trying to exec /bin/init
> > back from execve, errno=14
> > run_init_process trying to exec /bin/sh
> > back from execve, errno=14
> > Kernel panic - not syncing: No init found.  Try passing init= option to
> > kernel.
> >   <0>Rebooting in 180 seconds..<6>phy0:0: Link is Up - 100/Half
> >
> >
> >
> >
> >
> > ------------------------------
> >
> > Message: 5
> > Date: Tue, 16 Jan 2007 22:27:36 -0800
> > From: Bruce_Leonard@selinc.com
> > Subject: Who's the maintainer for the freescale MPC8349ITX board?
> > To: linuxppc-embedded@ozlabs.org
> > Message-ID:
> >       <OFF988DBDB.9E50EDE1-ON88257266.0023381C-88257266.00237CB3@selinc.com>
> > Content-Type: text/plain; charset="US-ASCII"
> >
> > I'm sorry if this is a stupid question, but I can't figure it out from
> > anything in the source.  I don't want to clutter up the mailing list with
> > newbie questions so I'd like to get in touch with the person who did the
> > linux/u-boot port for the MPC8349ITX board and take the discussion off
> > line.
> >
> > Thanks for the help.
> >
> > Bruce Leonard
> > Schweitzer Engineering Labs
> > Pullman, WA USA
> >
> >
> > ------------------------------
> >
> > Message: 6
> > Date: Wed, 17 Jan 2007 02:54:02 -0500
> > From: "David H. Lynch Jr." <dhlii@dlasys.net>
> > Subject: Re: ram-disk root file system
> > To: Dan Wilson <dwilson@dslextreme.com>
> > Cc: linuxppc-embedded@ozlabs.org
> > Message-ID: <45ADD61A.7020005@dlasys.net>
> > Content-Type: text/plain; charset=ISO-8859-1
> >
> > Dan Wilson wrote:
> > > We are attempting to use an initrd ram-disk as the permanent root file
> > system for a MPC8541-based system.
> > >
> > > We are using ELDK 4 to cross-compile, and are running linux 2.6.15 kernel,
> > with u-boot 1.1.6 as our bootloader.
> > >
> > > I built an initrd file system, compressed it, then ran mkimage against it,
> > and it seems to be successfully loaded by u-boot, and linux sees the initrd
> > file and claims to have mounted it.  However, it then reports that it is
> > unable to find any files on the mounted root file system, as shown in the
> > log below.  I added some additional diagnostics to show what the error codes
> > were, and what was happening, but do not understand what I might have done
> > wrong.  If I boot linux from an NFS system or from compact flash, I am able
> > to mount the image and see all the files, so I believe the initrd file
> > system was created correctly.
> >     I had similar problems with a permanent initramfs filesystem. It is
> > possible your problem has nothing to do with your filesystem.
> >
> >     First, I presume the debugging you added was in init/main.c.
> >           Before you attempt to exec init, you can add code to open
> > anyfile that you want on the ramdisk. opening a file requires less
> > things to be right than exec'ing and that may isolate your problem
> > further. I beleive you can enable system call tracing and find out more
> > about where things are going off the rails.
> >           You can also write a trivial hello world - one that does not
> > use any libraries and very little code, and see if you can exec that.
> >
> >     When you boot Linux NFS - are you using the same linux kernel ?
> >
> >
> >
> >
> > --
> > Dave Lynch                                                DLA Systems
> > Software Development:                                          Embedded Linux
> > 717.627.3770         dhlii@dlasys.net           http://www.dlasys.net
> > fax: 1.253.369.9244                              Cell: 1.717.587.7774
> > Over 25 years' experience in platforms, languages, and technologies too
> > numerous to list.
> >
> > "Any intelligent fool can make things bigger and more complex... It takes a
> > touch of genius - and a lot of courage to move in the opposite direction."
> > Albert Einstein
> >
> >
> >
> > ------------------------------
> >
> > Message: 7
> > Date: Wed, 17 Jan 2007 15:02:51 +0100
> > From: "alayrac" <christophe.alayrac@cresitt.com>
> > Subject: Temac and Sysace for ML403
> > To: <linuxppc-embedded@ozlabs.org>
> > Message-ID: <000001c73a40$2df61b50$c900a8c0@CRESITTLAB>
> > Content-Type: text/plain;     charset="us-ascii"
> >
> > Ameet,
> >
> > I've a few problems to run Linux 2.6.17.1 on ML403 board following your
> > tutoarial instrcutions.
> >
> > I've downloaded Linux 2.6.17.1 Kernel source from kernel.org, apply
> > MVITSA TEMAC patches from PAULUS and then apply the sysace_after_temac
> > patch.
> > The Kernel compile properly if I do not include TEMAC and SYSACE. This
> > kernel boot properly and ends with a kernel panic due to root file
> > system not detected.
> >
> > Then If I try to include only SYSACE and EXT3 file support the kernel
> > did not compile (XST_ASSERT functions not found.... in
> > xilinx_sysace/adapter.c file)
> > To compile without source code modification I need to include TEMAC in
> > the kernel configuration.
> >
> > This Kernel boot properly, detect sysaxe (xsa: xsa1 xsa2) with a compact
> > flash with two partitions but hangs just after
> >
> > [    3.631175]  xsa: xsa1 xsa2
> > [    3.682436] tun: Universal TUN/TAP device driver, 1.6
> > [    3.743219] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
> > [    3.820309] Data machine check in kernel mode.
> >
> > If I try to add more kernel configurations based on BYU instructions
> > (refered on your tutorial) then I only succeed to obtain a :
> >
> > Oops : Kernel access bad area sig : 11
> >
> > Error message
> >
> >
> > The hardware is a design from scratch using EDK 8.2 SP2.
> > TEMAC version is plb_temac v3.00a, hard-temac v3.00b
> >
> > I suspect the hardware but I'm not sure about that. Hardware compilation
> > took a while on my computer so I would appreciate if you could tell me
> > the temac version you have used to port Linux 2.6.17.1 with TEMAC and
> > SYSACE.
> >
> > Furthermore if you have a .config file available for Kernel
> > configuration it would help me, beacause I'm not familiar with kernel
> > configuration.
> >
> > Regards
> >
> >
> > CRESITT INDUSTRIE
> > 12 Rue de Blois, BP6744
> > 45067 ORLEANS Cedex 2
> > Tel : 02.38.49.45.59
> > Fax :02.38.49.45.55
> > Email : christophe.alayrac@cresitt.com
> > Web : http://www.cresitt.com
> >
> >
> >
> >
> >
> > ------------------------------
> >
> > _______________________________________________
> > Linuxppc-embedded mailing list
> > Linuxppc-embedded@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> >
> > End of Linuxppc-embedded Digest, Vol 29, Issue 20
> > *************************************************
> >
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>


-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
