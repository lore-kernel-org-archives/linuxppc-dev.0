Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CECCB679E1
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 Aug 2006 23:57:40 +1000 (EST)
In-Reply-To: <OFCF3F7A59.180DAB88-ON652571C0.004C2A03-652571C0.004C5E3A@lntinfotech.com>
References: <OFCF3F7A59.180DAB88-ON652571C0.004C2A03-652571C0.004C5E3A@lntinfotech.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=ISO-8859-1; delsp=yes; format=flowed
Message-Id: <BB1EE8F4-DED6-4421-BA6D-A0A129D806A2@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Trouble booting Kernel 2.6.12 on powerpc 8540
Date: Fri, 4 Aug 2006 08:57:30 -0500
To: Prashant Yendigeri <Prashant.Yendigeri@lntinfotech.com>
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


On Aug 4, 2006, at 8:54 AM, Prashant Yendigeri wrote:

>
> Hi,
>
> I am able to boot linux kernel 2.6.12 on ppc 8540, and also able to =20=

> login too. But then i am unable to see any output  when i say ls, =20
> mount,ifconfig etc. Only pwd and env seem to work
> Whereas if i boot with kernel 2.4.20 and with the same ramdisk =20
> which i used to boot 2.6.12, i am able to see eveything, ls, mount =20
> outputs etc.


Do you have console=3DttyS0 on the command line to the kernel?

- kumar

>
> I built the ramdisk image using busybox 1.2
>
> This is the boot messages of 2.6.12 :
> ## Booting image at 01000000 ...
>    Image Name:   Linux-2.6.12
>    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>    Data Size:    1177413 Bytes =3D  1.1 MB
>    Load Address: 00000000
>    Entry Point:  000000000
>    Verifying ksum ... OK
>    Uncompressing Kernel Image ... OK
> ## Loading RAMDisk Image at 01200000 ...
>    Image Name:   MPC85xx ramdisk
>    Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
>    Data Size:    5887861 Bytes =3D  5.6 MB
>    Load Address: 00000000
>    Entry Point:  00000000
>    Verifying Checksum ... OK
>    Loading Ramdisk to 0fa16000, end 0ffb3775 ... OK
> mpc8540ads_init(): exit
> id mach(): done
> MMU:enter
> MMU:hw init
> MMU:mapin
> MMU:setio
> MMU:exit
> setup_arch: enter
> setup_arch: bootmem
> mpc8540ads_setup_arch()
> arch: exit
> openpic: enter
>              r      ...?.?....=C9=A5?..)55?....?.?..???)5?
> ] class_hotplug - name =3D ttyw8
> [    2.126538] Generic RTC Driver v1.07
> [    2.127108] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, =20=

> IRQ sharind[    2.130813] ttyS0 at MMIO 0xe0004500 (irq =3D 26) is a =20=

> 16550A
> [    2.152265] ttyS1 at MMIO 0xe0004600 (irq =3D 26) is a 16550A
> [    2.158526] io scheduler noop registered
> [    2.162574] io scheduler anticipatory registered
> [    2.167318] io scheduler deadline registered
> [    2.171730] io scheduler cfq registered
> [    2.182339] RAMDISK driver initialized: 16 RAM disks of 32768K =20
> size 1024 ble[    2.193524] loop: loaded (max 8 devices)
> [    2.198105] Equalizer2002: Simon Janes (simon@ncm.com) and David =20=

> S. Miller )[    2.207423] tun: Universal TUN/TAP device driver, 1.6
> [    2.212597] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
> [    2.219737] mice: PS/2 mouse device common for all mice
> [    2.225711] i2c /dev entries driver
> [    2.230856] NET: Registered protocol family 2
> [    2.245261] IP: routing cache hash table of 2048 buckets, 16Kbytes
> [    2.252570] TCP established hash table entries: 16384 (order: 5, =20=

> 131072 byt)[    2.260355] TCP bind hash table entries: 16384 =20
> (order: 4, 65536 bytes)
> [    2.267366] TCP: Hash tables configured (established 16384 bind =20
> 16384)
> [    2.274459] NET: Registered protocol family 1
> [    2.278943] NET: Registered protocol family 17
> [    2.284791] RAMDISK: Compressed image found at block 0
> [    4.435668] VFS: Mounted root (ext2 filesystem).
> [    4.440693] Freeing unused kernel memory: 84k init
> [    4.445614] Reached here
> [    4.448201] Reached here 2
> [    4.451423] Reached here 3
> [    4.454196] going to Exec /sbin/init
> init started:  BusyBox v1.2.0 (2006.08.02-10:51+0000) multi-call =20
> binary
> Starting pid 682, console /dev/ttyS0: '/etc/init.d/rcS'
> Starting pid 690, console /dev/ttyS0: '/sbin/ge
> Welcome to Linux on MPC85xxSK board!
> MPC85xxSK login:
>
>
> -> After this i login as root and type ls but no output on the =20
> screen, pwd and env throw output.
> -> I also see that in 2.4 booting messages :"Freeing initrd =20
> memory........" is displayed" but not in 2.6.12, eventhough i have =20
> enabled CONFIG_BLK_DEV_INITRD
> -> Should i enter something for CONFIG_INITRAMFS_SOURCE as of now =20
> it is blank ?
>
> Thanks and Regards,
> Prashant
>
>
>
> ______________________________________________________________________
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
