Return-Path: <sam.d.karp@gmail.com>
Received: from rn-out-0910.google.com (rn-out-0910.google.com [64.233.170.188])
	by ozlabs.org (Postfix) with ESMTP id 196E6DE5A0
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Apr 2008 03:47:03 +1000 (EST)
Received: by rn-out-0910.google.com with SMTP id e13so1354460rng.16
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Apr 2008 10:47:01 -0700 (PDT)
Message-ID: <800687fe0804231047k46d1310as9f37de3a5bbbf259@mail.gmail.com>
Date: Wed, 23 Apr 2008 12:47:00 -0500
From: "Sam Karp" <sam.d.karp@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Fwd: SecretLab 2.6.24 with USB
In-Reply-To: <800687fe0804231007l5fdf664fn1d94a1e40dd7fe74@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_13319_811811.1208972820181"
References: <800687fe0804141927y1f6ea75cv7ad0ba68b4fa637a@mail.gmail.com>
	<fa686aa40804211109g2f7f45d0gf836be46e2c1a40b@mail.gmail.com>
	<16825460.post@talk.nabble.com>
	<fa686aa40804221309g7d0749e8qc329ad72389f0138@mail.gmail.com>
	<480E4EBD.3010202@zin-tech.com>
	<fa686aa40804221355s11f8fd6em3f2075bbb2073c8@mail.gmail.com>
	<480F4E8E.4010506@zin-tech.com> <87iqy8haf8.fsf@macbook.be.48ers.dk>
	<Pine.LNX.4.62.0804231741110.20567@henka.dyndns.org>
	<800687fe0804231007l5fdf664fn1d94a1e40dd7fe74@mail.gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_13319_811811.1208972820181
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

---------- Forwarded message ----------
From: Sam Karp <sam.d.karp@gmail.com>
Date: Wed, 23 Apr 2008 11:07:50 -0600
Subject: Re: SecretLab 2.6.24 with USB
To: Henrik Larson <henka@henka.dyndns.org>

I've been working on a similar tasks and I've gotten to the point where I
the driver is registered but the dev/sd* never appears...

Here is my boot record

    0.000000] Xilinx ML403 Reference System (Virtex-4 FX)
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->    16384
[    0.000000]   Normal      16384 ->    16384
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[1] active PFN ranges
[    0.000000]     0:        0 ->    16384
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Tota=
l
pages: 16256
[    0.000000] Kernel command line: console=3DttyS0,9600 ip=3Don root=3D/de=
v/ram
rw
[    0.000000] Xilinx INTC #0 at 0xD1000FC0 mapped to 0xFDFFEFC0
[    0.000000] PID hash table entries: 256 (order: 8, 1024 bytes)
[    0.000291] Console: colour dummy device 80x25
[    0.000834] Dentry cache hash table entries: 8192 (order: 3, 32768 bytes=
)
[    0.002261] Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
[    0.024384] Memory: 57824k available (2140k kernel code, 676k data, 116k
init, 0k highmem)
[    0.109229] Mount-cache hash table entries: 512
[    0.115828] net_namespace: 64 bytes
[    0.127629] NET: Registered protocol family 16
[    0.161368] SCSI subsystem initialized
[    0.164286] usbcore: registered new interface driver usbfs
[    0.166272] usbcore: registered new interface driver hub
[    0.167635] usbcore: registered new device driver usb
[    0.191313] NET: Registered protocol family 2
[    0.225573] IP route cache hash table entries: 1024 (order: 0, 4096
bytes)
[    0.232430] TCP established hash table entries: 2048 (order: 2, 16384
bytes)
[    0.232957] TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
[    0.233313] TCP: Hash tables configured (established 2048 bind 2048)
[    0.233392] TCP reno registered
[    0.246425] checking if image is initramfs...it isn't (no cpio magic);
looks like an initrd
[    6.697539] Freeing initrd memory: 4139k freed
[    6.710934] NTFS driver 2.1.29 [Flags: R/W DEBUG].
[    6.712392] io scheduler noop registered
[    6.712477] io scheduler anticipatory registered (default)
[    6.712556] io scheduler deadline registered
[    6.712866] io scheduler cfq registered
[    6.785910] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ
sharing disabled
[    6.794247] serial8250.0: ttyS0 at MMIO 0xa0001003 (irq =3D 1) is a 1645=
0
[    6.794383] console [ttyS0] enabled
[    9.360220] RAMDISK driver initialized: 16 RAM disks of 65536K size 1024
blocksize
[    9.451567] usbcore: registered new interface driver ub
[    9.513799] tun: Universal TUN/TAP device driver, 1.6
[    9.574089] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[    9.652324] st: Version 20070203, fixed bufsize 32768, s/g segs 256
[    9.727853] Driver 'st' needs updating - please use bus_type methods
[    9.804619] osst :I: Tape driver with OnStream support version 0.99.4
[    9.804687] osst :I: $Id: osst.c,v 1.73 2005/01/01 21:13:34 wriede Exp $
[    9.962812] Driver 'osst' needs updating - please use bus_type methods
[   10.042450] Driver 'sd' needs updating - please use bus_type methods
[   10.119058] Driver 'sr' needs updating - please use bus_type methods
[   10.196759] SCSI Media Changer driver v0.25
[   10.248311] Driver 'ch' needs updating - please use bus_type methods
[   10.326499] c67x00 c67x00.0: Cypress C67X00 Host Controller
[   10.394304] c67x00 c67x00.0: new USB bus registered, assigned bus number
1
[   10.481219] usb usb1: configuration #1 chosen from 1 choice
[   10.549168] hub 1-0:1.0: USB hub found
[   10.593456] hub 1-0:1.0: 2 ports detected
[   10.747294] usb usb1: Product: Cypress C67X00 Host Controller
[   10.815603] usb usb1: Manufacturer: Linux 2.6.24.4 c67x00-hcd
[   10.884341] usb usb1: SerialNumber: c67x00_sie
[   10.937452] udc requested but CONFIG_USB_GADGET_C67X00 not enabled!
[   11.013687] usbcore: registered new interface driver usblp
[   11.078909] Initializing USB Mass Storage driver...
[   11.138123] usbcore: registered new interface driver usb-storage
[   11.209648] USB Mass Storage support registered.
[   11.265696] usbcore: registered new interface driver libusual
[   11.335071] usbcore: registered new interface driver cypress_cy7c63
[   11.410772] i8042.c: No controller found.
[   11.459066] mice: PS/2 mouse device common for all mice
[   11.523064] usbcore: registered new interface driver usbhid
[   11.589463] drivers/hid/usbhid/hid-core.c: v2.6:USB HID core driver
[   11.664712] TCP cubic registered
[   11.702904] NET: Registered protocol family 1
[   11.755062] NET: Registered protocol family 17
[   12.313654] IP-Config: No network devices available.
[   12.374243] RAMDISK: Compressed image found at block 0
[   19.569218] EXT2-fs warning: mounting unchecked fs, running e2fsck is
recommended
[   19.658681] VFS: Mounted root (ext2 filesystem).
[   19.714175] Freeing unused kernel memory: 116k init
INIT: version 2.78 booting
Activating swap...
mount: you must specify the filesystem type
Mounting local filesystems...
nothing was mounted
Starting portmap daemon\: portmap.
INIT: Entering runlevel: 3

and when I plug in my USB drive I get this...


# [   72.112234] usb 1-1: new full speed USB device using c67x00 and addres=
s
2
[   72.402860] usb 1-1: configuration #1 chosen from 1 choice
[   72.474140] scsi0 : SCSI emulation for USB Mass Storage devices
[   72.551588] usb 1-1: Product: DiskOnKey
[   72.596938] usb 1-1: Manufacturer: M-Systems
[   72.647914] usb 1-1: SerialNumber: 021120102300F3EA
[   77.554538] scsi 0:0:0:0: Direct-Access     M-Sys    DiskOnKey
2.51 PQ: 0 ANSI: 0 CCS
[   77.688344] sd 0:0:0:0: [sda] 15584 512-byte hardware sectors (8 MB)
[   77.770266] sd 0:0:0:0: [sda] Write Protect is off
[   77.827242] sd 0:0:0:0: [sda] Assuming drive cache: write through
[   77.919287] sd 0:0:0:0: [sda] 15584 512-byte hardware sectors (8 MB)
[   78.001280] sd 0:0:0:0: [sda] Write Protect is off
[   78.058131] sd 0:0:0:0: [sda] Assuming drive cache: write through
[   78.131034]  sda:<7>usb-storage: queuecommand called
[   78.201342]  sda1
[   78.230344] sd 0:0:0:0: [sda] Attached SCSI removable disk
[   78.298014] sd 0:0:0:0: Attached scsi generic sg0 type 0

ls /dev/sd*
ls: /dev/sd*: No such file or directory

***the dmesg output is this...
 dmesg
_bulk_transfer_buf: xfer 31 bytes
[   77.902642] usb-storage: Status code 0; transferred 31/31
[   77.902722] usb-storage: -- transfer complete
[   77.902788] usb-storage: Bulk command transfer result=3D0
[   77.902858] usb-storage: Attempting to get CSW...
[   77.902933] usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
[   77.904635] usb-storage: Status code 0; transferred 13/13
[   77.904716] usb-storage: -- transfer complete
[   77.904781] usb-storage: Bulk status result =3D 0
[   77.904861] usb-storage: Bulk Status S 0x53425355 T 0x7 R 0 Stat 0x0
[   77.904951] usb-storage: scsi cmd done, result=3D0x0
[   77.905044] usb-storage: *** thread sleeping.
[   77.905327] usb-storage: queuecommand called
[   77.905471] usb-storage: *** thread awakened.
[   77.905563] usb-storage: Command ALLOW_MEDIUM_REMOVAL (6 bytes)
[   77.905635] usb-storage:  1e 00 00 00 01 00
[   77.905777] usb-storage: Bulk Command S 0x43425355 T 0x8 L 0 F 0 Trg 0
LUN 0 CL 6
[   77.905875] usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
[   77.906641] usb-storage: Status code 0; transferred 31/31
[   77.906721] usb-storage: -- transfer complete
[   77.906787] usb-storage: Bulk command transfer result=3D0
[   77.906857] usb-storage: Attempting to get CSW...
[   77.906931] usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
[   77.908636] usb-storage: Status code 0; transferred 13/13
[   77.908716] usb-storage: -- transfer complete
[   77.908781] usb-storage: Bulk status result =3D 0
[   77.908861] usb-storage: Bulk Status S 0x53425355 T 0x8 R 0 Stat 0x0
[   77.908950] usb-storage: scsi cmd done, result=3D0x0
[   77.909042] usb-storage: *** thread sleeping.
[   77.909362] usb-storage: queuecommand called
[   77.909511] usb-storage: *** thread awakened.
[   77.909602] usb-storage: Command TEST_UNIT_READY (6 bytes)
[   77.909669] usb-storage:  00 00 00 00 00 00
[   77.909811] usb-storage: Bulk Command S 0x43425355 T 0x9 L 0 F 0 Trg 0
LUN 0 CL 6
[   77.909909] usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
[   77.910642] usb-storage: Status code 0; transferred 31/31
[   77.910722] usb-storage: -- transfer complete
[   77.910788] usb-storage: Bulk command transfer result=3D0
[   77.910857] usb-storage: Attempting to get CSW...
[   77.910932] usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
[   77.912635] usb-storage: Status code 0; transferred 13/13
[   77.912716] usb-storage: -- transfer complete
[   77.912781] usb-storage: Bulk status result =3D 0
[   77.912861] usb-storage: Bulk Status S 0x53425355 T 0x9 R 0 Stat 0x0
[   77.912950] usb-storage: scsi cmd done, result=3D0x0
[   77.913042] usb-storage: *** thread sleeping.
[   77.913355] usb-storage: queuecommand called
[   77.913502] usb-storage: *** thread awakened.
[   77.913593] usb-storage: Command READ_CAPACITY (10 bytes)
[   77.913661] usb-storage:  25 00 00 00 00 00 00 00 00 00
[   77.913843] usb-storage: Bulk Command S 0x43425355 T 0xa L 8 F 128 Trg 0
LUN 0 CL 10
[   77.913943] usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
[   77.914642] usb-storage: Status code 0; transferred 31/31
[   77.914722] usb-storage: -- transfer complete
[   77.914788] usb-storage: Bulk command transfer result=3D0
[   77.914875] usb-storage: usb_stor_bulk_transfer_sglist: xfer 8 bytes, 1
entries
[   77.916638] usb-storage: Status code 0; transferred 8/8
[   77.916719] usb-storage: -- transfer complete
[   77.916786] usb-storage: Bulk data transfer result 0x0
[   77.916854] usb-storage: Attempting to get CSW...
[   77.916929] usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
[   77.918633] usb-storage: Status code 0; transferred 13/13
[   77.918712] usb-storage: -- transfer complete
[   77.918777] usb-storage: Bulk status result =3D 0
[   77.918857] usb-storage: Bulk Status S 0x53425355 T 0xa R 0 Stat 0x0
[   77.918946] usb-storage: scsi cmd done, result=3D0x0
[   77.919037] usb-storage: *** thread sleeping.
[   77.919287] sd 0:0:0:0: [sda] 15584 512-byte hardware sectors (8 MB)
[   77.995005] usb-storage: queuecommand called
[   77.995155] usb-storage: *** thread awakened.
[   77.995246] usb-storage: Command MODE_SENSE (6 bytes)
[   77.995310] usb-storage:  1a 00 3f 00 c0 00
[   77.995456] usb-storage: Bulk Command S 0x43425355 T 0xb L 192 F 128 Trg
0 LUN 0 CL 6
[   77.995557] usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
[   77.996652] usb-storage: Status code 0; transferred 31/31
[   77.996734] usb-storage: -- transfer complete
[   77.996799] usb-storage: Bulk command transfer result=3D0
[   77.996887] usb-storage: usb_stor_bulk_transfer_sglist: xfer 192 bytes, =
1
entries
[   77.998650] usb-storage: Status code -121; transferred 8/192
[   77.998733] usb-storage: -- short read transfer
[   77.998803] usb-storage: Bulk data transfer result 0x1
[   77.998871] usb-storage: Attempting to get CSW...
[   77.998946] usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
[   78.000644] usb-storage: Status code 0; transferred 13/13
[   78.000723] usb-storage: -- transfer complete
[   78.000787] usb-storage: Bulk status result =3D 0
[   78.000867] usb-storage: Bulk Status S 0x53425355 T 0xb R 184 Stat 0x0
[   78.000958] usb-storage: scsi cmd done, result=3D0x0
[   78.001049] usb-storage: *** thread sleeping.
[   78.001280] sd 0:0:0:0: [sda] Write Protect is off
[   78.058047] sd 0:0:0:0: [sda] Mode Sense: 45 00 00 08
[   78.058131] sd 0:0:0:0: [sda] Assuming drive cache: write through
[   78.131034]  sda:<7>usb-storage: queuecommand called
[   78.190334] usb-storage: *** thread awakened.
[   78.190437] usb-storage: Command READ_10 (10 bytes)
[   78.190500] usb-storage:  28 00 00 00 00 00 00 00 08 00
[   78.190687] usb-storage: Bulk Command S 0x43425355 T 0xc L 4096 F 128 Tr=
g
0 LUN 0 CL 10
[   78.190789] usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
[   78.191664] usb-storage: Status code 0; transferred 31/31
[   78.191744] usb-storage: -- transfer complete
[   78.191810] usb-storage: Bulk command transfer result=3D0
[   78.191898] usb-storage: usb_stor_bulk_transfer_sglist: xfer 4096 bytes,
1 entries
[   78.199333] usb-storage: Status code 0; transferred 4096/4096
[   78.199419] usb-storage: -- transfer complete
[   78.199486] usb-storage: Bulk data transfer result 0x0
[   78.199555] usb-storage: Attempting to get CSW...
[   78.199630] usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
[   78.200658] usb-storage: Status code 0; transferred 13/13
[   78.200739] usb-storage: -- transfer complete
[   78.200804] usb-storage: Bulk status result =3D 0
[   78.200884] usb-storage: Bulk Status S 0x53425355 T 0xc R 0 Stat 0x0
[   78.200974] usb-storage: scsi cmd done, result=3D0x0
[   78.201068] usb-storage: *** thread sleeping.
[   78.201342]  sda1
[   78.224012] usb-storage: queuecommand called
[   78.224231] usb-storage: *** thread awakened.
[   78.224328] usb-storage: Command ALLOW_MEDIUM_REMOVAL (6 bytes)
[   78.224400] usb-storage:  1e 00 00 00 00 00
[   78.224544] usb-storage: Bulk Command S 0x43425355 T 0xd L 0 F 0 Trg 0
LUN 0 CL 6
[   78.224642] usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
[   78.225666] usb-storage: Status code 0; transferred 31/31
[   78.225746] usb-storage: -- transfer complete
[   78.225812] usb-storage: Bulk command transfer result=3D0
[   78.225882] usb-storage: Attempting to get CSW...
[   78.225956] usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
[   78.227656] usb-storage: Status code 0; transferred 13/13
[   78.227735] usb-storage: -- transfer complete
[   78.227800] usb-storage: Bulk status result =3D 0
[   78.227880] usb-storage: Bulk Status S 0x53425355 T 0xd R 0 Stat 0x0
[   78.227969] usb-storage: scsi cmd done, result=3D0x0
[   78.228172] usb-storage: *** thread sleeping.
[   78.230344] sd 0:0:0:0: [sda] Attached SCSI removable disk
[   78.298014] sd 0:0:0:0: Attached scsi generic sg0 type 0

I feel like I might be missing something in my config file but I'm not
positive?  Any ideas?

-Thanks
-Sam



On Wed, Apr 23, 2008 at 9:41 AM, Henrik Larson <henka@henka.dyndns.org>
wrote:

>
> Allt som har med skatter =E4r per definition inte logiskt!
>
>
>
>
> On Wed, 23 Apr 2008, Peter Korsgaard wrote:
>
>    "Aaron" =3D=3D Aaron Sells <aaron.sells@zin-tech.com> writes:
> > > > > > >
> > > > > >
> > Hi,
> >
> > Aaron> root@xilinx-ml403:/# dmesg | grep -i usb
> > Aaron> [    0.175963] usbcore: registered new interface driver usbfs
> > Aaron> [    0.178207] usbcore: registered new interface driver hub
> > Aaron> [    0.179810] usbcore: registered new device driver usb
> > Aaron> [    3.426016] usbcore: registered new interface driver ub
> > Aaron> [    4.156086] usbmon: debugfs is not available
> > Aaron> [    4.209160] Initializing USB Mass Storage driver...
> > Aaron> [    4.268302] usbcore: registered new interface driver
> > usb-storage
> > Aaron> [    4.336109] USB Mass Storage support registered.
> > Aaron> [    4.958294] usbcore: registered new interface driver usbhid
> > Aaron> [    5.020120] drivers/hid/usbhid/hid-core.c: v2.6:USB HID core
> > driver
> >
> > Yes, the USB core and drivers gets loaded, but because you haven't
> > provided a struct platform_device the c67x00 driver doesn't get
> > probed.
> >
> > Aaron> It still doesn't look like the ML403 Cypress host device is bein=
g
> > Aaron> recognized.  No messages appear upon insertion and removal of US=
B
> > Aaron> devices.
> >
> > Aaron> Regards,
> > Aaron> Aaron Sells
> > Aaron> diff linux-2.6-xlnx_arch-ppc-syslib-virtex_devices.c
> > secretlab_arch-ppc-syslib-virtex_devices.c
> > Aaron> 77,92d76
> > Aaron> <  * ML300/ML403 Video Device: shortcut macro for single instanc=
e
> >
> > Please use diff -u.
> >
> > I don't see anything with platform devices for the c67x00 driver. You
> > need something like:
> >
> > #include <linux/usb/c67x00.h>
> >
> > static struct resource c67x00_resources[] =3D {
> >        [0] =3D {
> >                .start  =3D 0x84000000,
> >                .end    =3D 0x8400000f,
> >                .flags  =3D IORESOURCE_MEM,
> >        },
> >        [1] =3D {
> >                .start  =3D 3,
> >                .end    =3D 3,
> >                .flags  =3D IORESOURCE_IRQ,
> >        },
> > };
> >
> > static struct c67x00_platform_data thinlite_c67x00_data =3D {
> >        .sie_config             =3D C67X00_SIE1_HOST |
> > C67X00_SIE2_PERIPHERAL_B,
> >        .hpi_regstep            =3D 0x02, /* A0 not connected on 16bit b=
us
> > */
> > };
> >
> > static struct platform_device thinlite_c67x00 =3D {
> >        .name                   =3D "c67x00",
> >        .id                     =3D 0,
> >        .num_resources          =3D ARRAY_SIZE(c67x00_resources),
> >        .resource               =3D c67x00_resources,
> >        .dev.platform_data      =3D &thinlite_c67x00_data,
> > };
> >
> > Which you then register with the platform bus with
> > platform_add_devices or similar. Either you do this by hand or you
> > create XPAR_* macros which take the needed info out of xparameter.h
> > (sorry, I don't have an xparameters.h with those defines at hand).
> >
> > Aaron> diff -Naur c67x00.old/c67x00-drv.c c67x00/c67x00-drv.c
> > Aaron> --- c67x00.old/c67x00-drv.c      2008-04-23 10:36:16.000000000
> > -0400
> > Aaron> +++ c67x00/c67x00-drv.c  2008-04-23 10:39:20.000000000 -0400
> > Aaron> @@ -57,8 +57,7 @@
> > Aaron>                  c67x00_hcd_probe(sie);
> > Aaron>                  break;
> >
> > Aaron> -        case C67X00_SIE_PERIPHERAL_A:
> > Aaron> -        case C67X00_SIE_PERIPHERAL_B:
> > Aaron> +        case C67X00_SIE_PERIPHERAL:
> >
> > This seems to be from an earlier version of my driver.
> >
> > --
> > Bye, Peter Korsgaard
> > _______________________________________________
> > Linuxppc-embedded mailing list
> > Linuxppc-embedded@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> >
> > _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>

------=_Part_13319_811811.1208972820181
Content-Type: text/plain; name=.config
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ffe5rpfb0
Content-Disposition: attachment; filename=.config

IwojIEF1dG9tYXRpY2FsbHkgZ2VuZXJhdGVkIG1ha2UgY29uZmlnOiBkb24ndCBlZGl0CiMgTGlu
dXgga2VybmVsIHZlcnNpb246IDIuNi4yNC40CiMgV2VkIEFwciAyMyAwNzo1NDo1NSAyMDA4CiMK
Q09ORklHX1dPUkRfU0laRT0zMgpDT05GSUdfTU1VPXkKQ09ORklHX0dFTkVSSUNfSEFSRElSUVM9
eQpDT05GSUdfUldTRU1fWENIR0FERF9BTEdPUklUSE09eQpDT05GSUdfQVJDSF9IQVNfSUxPRzJf
VTMyPXkKIyBDT05GSUdfQVJDSF9IQVNfSUxPRzJfVTY0IGlzIG5vdCBzZXQKQ09ORklHX0dFTkVS
SUNfSFdFSUdIVD15CkNPTkZJR19HRU5FUklDX0NBTElCUkFURV9ERUxBWT15CkNPTkZJR19QUEM9
eQpDT05GSUdfUFBDMzI9eQpDT05GSUdfR0VORVJJQ19OVlJBTT15CkNPTkZJR19HRU5FUklDX0ZJ
TkRfTkVYVF9CSVQ9eQpDT05GSUdfU0NIRURfTk9fTk9fT01JVF9GUkFNRV9QT0lOVEVSPXkKQ09O
RklHX0FSQ0hfTUFZX0hBVkVfUENfRkRDPXkKQ09ORklHX0dFTkVSSUNfQlVHPXkKQ09ORklHX0RF
RkNPTkZJR19MSVNUPSIvbGliL21vZHVsZXMvJFVOQU1FX1JFTEVBU0UvLmNvbmZpZyIKCiMKIyBH
ZW5lcmFsIHNldHVwCiMKQ09ORklHX0VYUEVSSU1FTlRBTD15CkNPTkZJR19CUk9LRU5fT05fU01Q
PXkKQ09ORklHX0lOSVRfRU5WX0FSR19MSU1JVD0zMgpDT05GSUdfTE9DQUxWRVJTSU9OPSIiCkNP
TkZJR19MT0NBTFZFUlNJT05fQVVUTz15CiMgQ09ORklHX1NXQVAgaXMgbm90IHNldApDT05GSUdf
U1lTVklQQz15CkNPTkZJR19TWVNWSVBDX1NZU0NUTD15CiMgQ09ORklHX1BPU0lYX01RVUVVRSBp
cyBub3Qgc2V0CkNPTkZJR19CU0RfUFJPQ0VTU19BQ0NUPXkKQ09ORklHX0JTRF9QUk9DRVNTX0FD
Q1RfVjM9eQojIENPTkZJR19UQVNLU1RBVFMgaXMgbm90IHNldAojIENPTkZJR19VU0VSX05TIGlz
IG5vdCBzZXQKIyBDT05GSUdfUElEX05TIGlzIG5vdCBzZXQKIyBDT05GSUdfQVVESVQgaXMgbm90
IHNldAojIENPTkZJR19JS0NPTkZJRyBpcyBub3Qgc2V0CkNPTkZJR19MT0dfQlVGX1NISUZUPTE0
CiMgQ09ORklHX0NHUk9VUFMgaXMgbm90IHNldApDT05GSUdfRkFJUl9HUk9VUF9TQ0hFRD15CkNP
TkZJR19GQUlSX1VTRVJfU0NIRUQ9eQojIENPTkZJR19GQUlSX0NHUk9VUF9TQ0hFRCBpcyBub3Qg
c2V0CkNPTkZJR19TWVNGU19ERVBSRUNBVEVEPXkKIyBDT05GSUdfUkVMQVkgaXMgbm90IHNldApD
T05GSUdfQkxLX0RFVl9JTklUUkQ9eQpDT05GSUdfSU5JVFJBTUZTX1NPVVJDRT0iIgpDT05GSUdf
Q0NfT1BUSU1JWkVfRk9SX1NJWkU9eQpDT05GSUdfU1lTQ1RMPXkKIyBDT05GSUdfRU1CRURERUQg
aXMgbm90IHNldApDT05GSUdfU1lTQ1RMX1NZU0NBTEw9eQpDT05GSUdfS0FMTFNZTVM9eQojIENP
TkZJR19LQUxMU1lNU19BTEwgaXMgbm90IHNldAojIENPTkZJR19LQUxMU1lNU19FWFRSQV9QQVNT
IGlzIG5vdCBzZXQKQ09ORklHX0hPVFBMVUc9eQpDT05GSUdfUFJJTlRLPXkKQ09ORklHX0JVRz15
CkNPTkZJR19FTEZfQ09SRT15CkNPTkZJR19CQVNFX0ZVTEw9eQpDT05GSUdfRlVURVg9eQpDT05G
SUdfQU5PTl9JTk9ERVM9eQpDT05GSUdfRVBPTEw9eQpDT05GSUdfU0lHTkFMRkQ9eQpDT05GSUdf
RVZFTlRGRD15CkNPTkZJR19TSE1FTT15CkNPTkZJR19WTV9FVkVOVF9DT1VOVEVSUz15CkNPTkZJ
R19TTEFCPXkKIyBDT05GSUdfU0xVQiBpcyBub3Qgc2V0CiMgQ09ORklHX1NMT0IgaXMgbm90IHNl
dApDT05GSUdfU0xBQklORk89eQpDT05GSUdfUlRfTVVURVhFUz15CiMgQ09ORklHX1RJTllfU0hN
RU0gaXMgbm90IHNldApDT05GSUdfQkFTRV9TTUFMTD0wCiMgQ09ORklHX01PRFVMRVMgaXMgbm90
IHNldApDT05GSUdfQkxPQ0s9eQpDT05GSUdfTEJEPXkKIyBDT05GSUdfQkxLX0RFVl9JT19UUkFD
RSBpcyBub3Qgc2V0CiMgQ09ORklHX0xTRiBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfQlNH
IGlzIG5vdCBzZXQKCiMKIyBJTyBTY2hlZHVsZXJzCiMKQ09ORklHX0lPU0NIRURfTk9PUD15CkNP
TkZJR19JT1NDSEVEX0FTPXkKQ09ORklHX0lPU0NIRURfREVBRExJTkU9eQpDT05GSUdfSU9TQ0hF
RF9DRlE9eQpDT05GSUdfREVGQVVMVF9BUz15CiMgQ09ORklHX0RFRkFVTFRfREVBRExJTkUgaXMg
bm90IHNldAojIENPTkZJR19ERUZBVUxUX0NGUSBpcyBub3Qgc2V0CiMgQ09ORklHX0RFRkFVTFRf
Tk9PUCBpcyBub3Qgc2V0CkNPTkZJR19ERUZBVUxUX0lPU0NIRUQ9ImFudGljaXBhdG9yeSIKCiMK
IyBQcm9jZXNzb3IKIwojIENPTkZJR182eHggaXMgbm90IHNldApDT05GSUdfNDB4PXkKIyBDT05G
SUdfNDR4IGlzIG5vdCBzZXQKIyBDT05GSUdfOHh4IGlzIG5vdCBzZXQKIyBDT05GSUdfRTIwMCBp
cyBub3Qgc2V0CiMgQ09ORklHX0U1MDAgaXMgbm90IHNldApDT05GSUdfUFBDX0RDUl9OQVRJVkU9
eQpDT05GSUdfUFBDX0RDUj15CkNPTkZJR19NQVRIX0VNVUxBVElPTj15CiMgQ09ORklHX0tFWEVD
IGlzIG5vdCBzZXQKIyBDT05GSUdfQ1BVX0ZSRVEgaXMgbm90IHNldApDT05GSUdfNHh4PXkKIyBD
T05GSUdfV0FOVF9FQVJMWV9TRVJJQUwgaXMgbm90IHNldAoKIwojIElCTSA0eHggb3B0aW9ucwoj
CiMgQ09ORklHX0JVQklOR0EgaXMgbm90IHNldAojIENPTkZJR19DUENJNDA1IGlzIG5vdCBzZXQK
IyBDT05GSUdfRVA0MDUgaXMgbm90IHNldAojIENPTkZJR19SRURXT09EXzUgaXMgbm90IHNldAoj
IENPTkZJR19SRURXT09EXzYgaXMgbm90IHNldAojIENPTkZJR19TWUNBTU9SRSBpcyBub3Qgc2V0
CiMgQ09ORklHX1dBTE5VVCBpcyBub3Qgc2V0CiMgQ09ORklHX1hJTElOWF9NTDMwMCBpcyBub3Qg
c2V0CkNPTkZJR19YSUxJTlhfTUw0MDM9eQpDT05GSUdfSUJNNDA1X0VSUjc3PXkKQ09ORklHX0lC
TTQwNV9FUlI1MT15CkNPTkZJR19YSUxJTlhfVklSVEVYXzRfRlg9eQpDT05GSUdfWElMSU5YX1ZJ
UlRFWD15CkNPTkZJR19FTUJFRERFREJPT1Q9eQojIENPTkZJR19QUEM0eHhfRE1BIGlzIG5vdCBz
ZXQKQ09ORklHX1BQQ19HRU41NTA9eQpDT05GSUdfVUFSVDBfVFRZUzA9eQojIENPTkZJR19VQVJU
MF9UVFlTMSBpcyBub3Qgc2V0CkNPTkZJR19OT1RfQ09IRVJFTlRfQ0FDSEU9eQoKIwojIFBsYXRm
b3JtIG9wdGlvbnMKIwojIENPTkZJR19QQ19LRVlCT0FSRCBpcyBub3Qgc2V0CiMgQ09ORklHX0hJ
R0hNRU0gaXMgbm90IHNldApDT05GSUdfQVJDSF9QT1BVTEFURVNfTk9ERV9NQVA9eQojIENPTkZJ
R19IWl8xMDAgaXMgbm90IHNldApDT05GSUdfSFpfMjUwPXkKIyBDT05GSUdfSFpfMzAwIGlzIG5v
dCBzZXQKIyBDT05GSUdfSFpfMTAwMCBpcyBub3Qgc2V0CkNPTkZJR19IWj0yNTAKQ09ORklHX1BS
RUVNUFRfTk9ORT15CiMgQ09ORklHX1BSRUVNUFRfVk9MVU5UQVJZIGlzIG5vdCBzZXQKIyBDT05G
SUdfUFJFRU1QVCBpcyBub3Qgc2V0CkNPTkZJR19TRUxFQ1RfTUVNT1JZX01PREVMPXkKQ09ORklH
X0ZMQVRNRU1fTUFOVUFMPXkKIyBDT05GSUdfRElTQ09OVElHTUVNX01BTlVBTCBpcyBub3Qgc2V0
CiMgQ09ORklHX1NQQVJTRU1FTV9NQU5VQUwgaXMgbm90IHNldApDT05GSUdfRkxBVE1FTT15CkNP
TkZJR19GTEFUX05PREVfTUVNX01BUD15CiMgQ09ORklHX1NQQVJTRU1FTV9TVEFUSUMgaXMgbm90
IHNldAojIENPTkZJR19TUEFSU0VNRU1fVk1FTU1BUF9FTkFCTEUgaXMgbm90IHNldApDT05GSUdf
U1BMSVRfUFRMT0NLX0NQVVM9NAojIENPTkZJR19SRVNPVVJDRVNfNjRCSVQgaXMgbm90IHNldApD
T05GSUdfWk9ORV9ETUFfRkxBRz0xCkNPTkZJR19CT1VOQ0U9eQpDT05GSUdfVklSVF9UT19CVVM9
eQpDT05GSUdfQklORk1UX0VMRj15CiMgQ09ORklHX0JJTkZNVF9NSVNDIGlzIG5vdCBzZXQKQ09O
RklHX0NNRExJTkVfQk9PTD15CkNPTkZJR19DTURMSU5FPSJjb25zb2xlPXR0eVMwLDk2MDAgaXA9
b24gcm9vdD0vZGV2L3JhbSBydyIKQ09ORklHX1NFQ0NPTVA9eQpDT05GSUdfSVNBX0RNQV9BUEk9
eQoKIwojIEJ1cyBvcHRpb25zCiMKQ09ORklHX1pPTkVfRE1BPXkKIyBDT05GSUdfUFBDX0k4MjU5
IGlzIG5vdCBzZXQKIyBDT05GSUdfUENJIGlzIG5vdCBzZXQKIyBDT05GSUdfUENJX0RPTUFJTlMg
aXMgbm90IHNldAojIENPTkZJR19QQ0lfU1lTQ0FMTCBpcyBub3Qgc2V0CiMgQ09ORklHX0FSQ0hf
U1VQUE9SVFNfTVNJIGlzIG5vdCBzZXQKIyBDT05GSUdfUENDQVJEIGlzIG5vdCBzZXQKCiMKIyBB
ZHZhbmNlZCBzZXR1cAojCiMgQ09ORklHX0FEVkFOQ0VEX09QVElPTlMgaXMgbm90IHNldAoKIwoj
IERlZmF1bHQgc2V0dGluZ3MgZm9yIGFkdmFuY2VkIGNvbmZpZ3VyYXRpb24gb3B0aW9ucyBhcmUg
dXNlZAojCkNPTkZJR19ISUdITUVNX1NUQVJUPTB4ZmUwMDAwMDAKQ09ORklHX0xPV01FTV9TSVpF
PTB4MzAwMDAwMDAKQ09ORklHX0tFUk5FTF9TVEFSVD0weGMwMDAwMDAwCkNPTkZJR19UQVNLX1NJ
WkU9MHg4MDAwMDAwMApDT05GSUdfQ09OU0lTVEVOVF9TVEFSVD0weGZmMTAwMDAwCkNPTkZJR19D
T05TSVNURU5UX1NJWkU9MHgwMDIwMDAwMApDT05GSUdfQk9PVF9MT0FEPTB4MDA0MDAwMDAKCiMK
IyBOZXR3b3JraW5nCiMKQ09ORklHX05FVD15CgojCiMgTmV0d29ya2luZyBvcHRpb25zCiMKQ09O
RklHX1BBQ0tFVD15CkNPTkZJR19QQUNLRVRfTU1BUD15CkNPTkZJR19VTklYPXkKQ09ORklHX1hG
Uk09eQojIENPTkZJR19YRlJNX1VTRVIgaXMgbm90IHNldAojIENPTkZJR19YRlJNX1NVQl9QT0xJ
Q1kgaXMgbm90IHNldAojIENPTkZJR19YRlJNX01JR1JBVEUgaXMgbm90IHNldAojIENPTkZJR19O
RVRfS0VZIGlzIG5vdCBzZXQKQ09ORklHX0lORVQ9eQojIENPTkZJR19JUF9NVUxUSUNBU1QgaXMg
bm90IHNldAojIENPTkZJR19JUF9BRFZBTkNFRF9ST1VURVIgaXMgbm90IHNldApDT05GSUdfSVBf
RklCX0hBU0g9eQpDT05GSUdfSVBfUE5QPXkKQ09ORklHX0lQX1BOUF9ESENQPXkKIyBDT05GSUdf
SVBfUE5QX0JPT1RQIGlzIG5vdCBzZXQKIyBDT05GSUdfSVBfUE5QX1JBUlAgaXMgbm90IHNldAoj
IENPTkZJR19ORVRfSVBJUCBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9JUEdSRSBpcyBub3Qgc2V0
CiMgQ09ORklHX0FSUEQgaXMgbm90IHNldAojIENPTkZJR19TWU5fQ09PS0lFUyBpcyBub3Qgc2V0
CiMgQ09ORklHX0lORVRfQUggaXMgbm90IHNldAojIENPTkZJR19JTkVUX0VTUCBpcyBub3Qgc2V0
CiMgQ09ORklHX0lORVRfSVBDT01QIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5FVF9YRlJNX1RVTk5F
TCBpcyBub3Qgc2V0CiMgQ09ORklHX0lORVRfVFVOTkVMIGlzIG5vdCBzZXQKQ09ORklHX0lORVRf
WEZSTV9NT0RFX1RSQU5TUE9SVD15CkNPTkZJR19JTkVUX1hGUk1fTU9ERV9UVU5ORUw9eQpDT05G
SUdfSU5FVF9YRlJNX01PREVfQkVFVD15CiMgQ09ORklHX0lORVRfTFJPIGlzIG5vdCBzZXQKQ09O
RklHX0lORVRfRElBRz15CkNPTkZJR19JTkVUX1RDUF9ESUFHPXkKIyBDT05GSUdfVENQX0NPTkdf
QURWQU5DRUQgaXMgbm90IHNldApDT05GSUdfVENQX0NPTkdfQ1VCSUM9eQpDT05GSUdfREVGQVVM
VF9UQ1BfQ09ORz0iY3ViaWMiCiMgQ09ORklHX1RDUF9NRDVTSUcgaXMgbm90IHNldAojIENPTkZJ
R19JUFY2IGlzIG5vdCBzZXQKIyBDT05GSUdfSU5FVDZfWEZSTV9UVU5ORUwgaXMgbm90IHNldAoj
IENPTkZJR19JTkVUNl9UVU5ORUwgaXMgbm90IHNldAojIENPTkZJR19ORVRXT1JLX1NFQ01BUksg
aXMgbm90IHNldAojIENPTkZJR19ORVRGSUxURVIgaXMgbm90IHNldAojIENPTkZJR19JUF9EQ0NQ
IGlzIG5vdCBzZXQKIyBDT05GSUdfSVBfU0NUUCBpcyBub3Qgc2V0CiMgQ09ORklHX1RJUEMgaXMg
bm90IHNldAojIENPTkZJR19BVE0gaXMgbm90IHNldAojIENPTkZJR19CUklER0UgaXMgbm90IHNl
dAojIENPTkZJR19WTEFOXzgwMjFRIGlzIG5vdCBzZXQKIyBDT05GSUdfREVDTkVUIGlzIG5vdCBz
ZXQKIyBDT05GSUdfTExDMiBpcyBub3Qgc2V0CiMgQ09ORklHX0lQWCBpcyBub3Qgc2V0CiMgQ09O
RklHX0FUQUxLIGlzIG5vdCBzZXQKIyBDT05GSUdfWDI1IGlzIG5vdCBzZXQKIyBDT05GSUdfTEFQ
QiBpcyBub3Qgc2V0CiMgQ09ORklHX0VDT05FVCBpcyBub3Qgc2V0CiMgQ09ORklHX1dBTl9ST1VU
RVIgaXMgbm90IHNldAojIENPTkZJR19ORVRfU0NIRUQgaXMgbm90IHNldAoKIwojIE5ldHdvcmsg
dGVzdGluZwojCiMgQ09ORklHX05FVF9QS1RHRU4gaXMgbm90IHNldAojIENPTkZJR19IQU1SQURJ
TyBpcyBub3Qgc2V0CiMgQ09ORklHX0lSREEgaXMgbm90IHNldAojIENPTkZJR19CVCBpcyBub3Qg
c2V0CiMgQ09ORklHX0FGX1JYUlBDIGlzIG5vdCBzZXQKCiMKIyBXaXJlbGVzcwojCiMgQ09ORklH
X0NGRzgwMjExIGlzIG5vdCBzZXQKIyBDT05GSUdfV0lSRUxFU1NfRVhUIGlzIG5vdCBzZXQKIyBD
T05GSUdfTUFDODAyMTEgaXMgbm90IHNldAojIENPTkZJR19JRUVFODAyMTEgaXMgbm90IHNldAoj
IENPTkZJR19SRktJTEwgaXMgbm90IHNldAojIENPTkZJR19ORVRfOVAgaXMgbm90IHNldAoKIwoj
IERldmljZSBEcml2ZXJzCiMKCiMKIyBHZW5lcmljIERyaXZlciBPcHRpb25zCiMKQ09ORklHX1VF
VkVOVF9IRUxQRVJfUEFUSD0iL3NiaW4vaG90cGx1ZyIKQ09ORklHX1NUQU5EQUxPTkU9eQpDT05G
SUdfUFJFVkVOVF9GSVJNV0FSRV9CVUlMRD15CiMgQ09ORklHX0ZXX0xPQURFUiBpcyBub3Qgc2V0
CiMgQ09ORklHX0RFQlVHX0RSSVZFUiBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQlVHX0RFVlJFUyBp
cyBub3Qgc2V0CiMgQ09ORklHX1NZU19IWVBFUlZJU09SIGlzIG5vdCBzZXQKIyBDT05GSUdfQ09O
TkVDVE9SIGlzIG5vdCBzZXQKIyBDT05GSUdfTVREIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFSUE9S
VCBpcyBub3Qgc2V0CkNPTkZJR19CTEtfREVWPXkKIyBDT05GSUdfQkxLX0RFVl9GRCBpcyBub3Qg
c2V0CiMgQ09ORklHX0JMS19ERVZfQ09XX0NPTU1PTiBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19E
RVZfTE9PUCBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfTkJEIGlzIG5vdCBzZXQKQ09ORklH
X0JMS19ERVZfVUI9eQpDT05GSUdfQkxLX0RFVl9SQU09eQpDT05GSUdfQkxLX0RFVl9SQU1fQ09V
TlQ9MTYKQ09ORklHX0JMS19ERVZfUkFNX1NJWkU9NjU1MzYKQ09ORklHX0JMS19ERVZfUkFNX0JM
T0NLU0laRT0xMDI0CiMgQ09ORklHX0NEUk9NX1BLVENEVkQgaXMgbm90IHNldAojIENPTkZJR19B
VEFfT1ZFUl9FVEggaXMgbm90IHNldAojIENPTkZJR19YSUxJTlhfU1lTQUNFIGlzIG5vdCBzZXQK
Q09ORklHX01JU0NfREVWSUNFUz15CiMgQ09ORklHX0VFUFJPTV85M0NYNiBpcyBub3Qgc2V0CiMg
Q09ORklHX0lERSBpcyBub3Qgc2V0CgojCiMgU0NTSSBkZXZpY2Ugc3VwcG9ydAojCkNPTkZJR19S
QUlEX0FUVFJTPXkKQ09ORklHX1NDU0k9eQpDT05GSUdfU0NTSV9ETUE9eQpDT05GSUdfU0NTSV9U
R1Q9eQojIENPTkZJR19TQ1NJX05FVExJTksgaXMgbm90IHNldApDT05GSUdfU0NTSV9QUk9DX0ZT
PXkKCiMKIyBTQ1NJIHN1cHBvcnQgdHlwZSAoZGlzaywgdGFwZSwgQ0QtUk9NKQojCkNPTkZJR19C
TEtfREVWX1NEPXkKQ09ORklHX0NIUl9ERVZfU1Q9eQpDT05GSUdfQ0hSX0RFVl9PU1NUPXkKQ09O
RklHX0JMS19ERVZfU1I9eQpDT05GSUdfQkxLX0RFVl9TUl9WRU5ET1I9eQpDT05GSUdfQ0hSX0RF
Vl9TRz15CkNPTkZJR19DSFJfREVWX1NDSD15CgojCiMgU29tZSBTQ1NJIGRldmljZXMgKGUuZy4g
Q0QganVrZWJveCkgc3VwcG9ydCBtdWx0aXBsZSBMVU5zCiMKQ09ORklHX1NDU0lfTVVMVElfTFVO
PXkKQ09ORklHX1NDU0lfQ09OU1RBTlRTPXkKQ09ORklHX1NDU0lfTE9HR0lORz15CkNPTkZJR19T
Q1NJX1NDQU5fQVNZTkM9eQoKIwojIFNDU0kgVHJhbnNwb3J0cwojCiMgQ09ORklHX1NDU0lfU1BJ
X0FUVFJTIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9GQ19BVFRSUyBpcyBub3Qgc2V0CiMgQ09O
RklHX1NDU0lfSVNDU0lfQVRUUlMgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX1NBU19MSUJTQVMg
aXMgbm90IHNldAojIENPTkZJR19TQ1NJX1NSUF9BVFRSUyBpcyBub3Qgc2V0CkNPTkZJR19TQ1NJ
X0xPV0xFVkVMPXkKIyBDT05GSUdfSVNDU0lfVENQIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9E
RUJVRyBpcyBub3Qgc2V0CiMgQ09ORklHX0FUQSBpcyBub3Qgc2V0CiMgQ09ORklHX01EIGlzIG5v
dCBzZXQKIyBDT05GSUdfTUFDSU5UT1NIX0RSSVZFUlMgaXMgbm90IHNldApDT05GSUdfTkVUREVW
SUNFUz15CiMgQ09ORklHX05FVERFVklDRVNfTVVMVElRVUVVRSBpcyBub3Qgc2V0CiMgQ09ORklH
X0RVTU1ZIGlzIG5vdCBzZXQKIyBDT05GSUdfQk9ORElORyBpcyBub3Qgc2V0CiMgQ09ORklHX01B
Q1ZMQU4gaXMgbm90IHNldAojIENPTkZJR19FUVVBTElaRVIgaXMgbm90IHNldApDT05GSUdfVFVO
PXkKIyBDT05GSUdfVkVUSCBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9FVEhFUk5FVCBpcyBub3Qg
c2V0CkNPTkZJR19ORVRERVZfMTAwMD15CkNPTkZJR19ORVRERVZfMTAwMDA9eQoKIwojIFdpcmVs
ZXNzIExBTgojCiMgQ09ORklHX1dMQU5fUFJFODAyMTEgaXMgbm90IHNldAojIENPTkZJR19XTEFO
XzgwMjExIGlzIG5vdCBzZXQKCiMKIyBVU0IgTmV0d29yayBBZGFwdGVycwojCiMgQ09ORklHX1VT
Ql9DQVRDIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0tBV0VUSCBpcyBub3Qgc2V0CiMgQ09ORklH
X1VTQl9QRUdBU1VTIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1JUTDgxNTAgaXMgbm90IHNldAoj
IENPTkZJR19VU0JfVVNCTkVUIGlzIG5vdCBzZXQKIyBDT05GSUdfV0FOIGlzIG5vdCBzZXQKIyBD
T05GSUdfUFBQIGlzIG5vdCBzZXQKIyBDT05GSUdfU0xJUCBpcyBub3Qgc2V0CiMgQ09ORklHX1NI
QVBFUiBpcyBub3Qgc2V0CiMgQ09ORklHX05FVENPTlNPTEUgaXMgbm90IHNldAojIENPTkZJR19O
RVRQT0xMIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1BPTExfQ09OVFJPTExFUiBpcyBub3Qgc2V0
CiMgQ09ORklHX0lTRE4gaXMgbm90IHNldAojIENPTkZJR19QSE9ORSBpcyBub3Qgc2V0CgojCiMg
SW5wdXQgZGV2aWNlIHN1cHBvcnQKIwpDT05GSUdfSU5QVVQ9eQojIENPTkZJR19JTlBVVF9GRl9N
RU1MRVNTIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5QVVRfUE9MTERFViBpcyBub3Qgc2V0CgojCiMg
VXNlcmxhbmQgaW50ZXJmYWNlcwojCkNPTkZJR19JTlBVVF9NT1VTRURFVj15CiMgQ09ORklHX0lO
UFVUX01PVVNFREVWX1BTQVVYIGlzIG5vdCBzZXQKQ09ORklHX0lOUFVUX01PVVNFREVWX1NDUkVF
Tl9YPTEwMjQKQ09ORklHX0lOUFVUX01PVVNFREVWX1NDUkVFTl9ZPTc2OAojIENPTkZJR19JTlBV
VF9KT1lERVYgaXMgbm90IHNldApDT05GSUdfSU5QVVRfRVZERVY9eQojIENPTkZJR19JTlBVVF9F
VkJVRyBpcyBub3Qgc2V0CgojCiMgSW5wdXQgRGV2aWNlIERyaXZlcnMKIwpDT05GSUdfSU5QVVRf
S0VZQk9BUkQ9eQpDT05GSUdfS0VZQk9BUkRfQVRLQkQ9eQojIENPTkZJR19LRVlCT0FSRF9TVU5L
QkQgaXMgbm90IHNldAojIENPTkZJR19LRVlCT0FSRF9MS0tCRCBpcyBub3Qgc2V0CiMgQ09ORklH
X0tFWUJPQVJEX1hUS0JEIGlzIG5vdCBzZXQKIyBDT05GSUdfS0VZQk9BUkRfTkVXVE9OIGlzIG5v
dCBzZXQKIyBDT05GSUdfS0VZQk9BUkRfU1RPV0FXQVkgaXMgbm90IHNldAojIENPTkZJR19JTlBV
VF9NT1VTRSBpcyBub3Qgc2V0CiMgQ09ORklHX0lOUFVUX0pPWVNUSUNLIGlzIG5vdCBzZXQKIyBD
T05GSUdfSU5QVVRfVEFCTEVUIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5QVVRfVE9VQ0hTQ1JFRU4g
aXMgbm90IHNldAojIENPTkZJR19JTlBVVF9NSVNDIGlzIG5vdCBzZXQKCiMKIyBIYXJkd2FyZSBJ
L08gcG9ydHMKIwpDT05GSUdfU0VSSU89eQpDT05GSUdfU0VSSU9fSTgwNDI9eQpDT05GSUdfU0VS
SU9fU0VSUE9SVD15CkNPTkZJR19TRVJJT19MSUJQUzI9eQojIENPTkZJR19TRVJJT19SQVcgaXMg
bm90IHNldAojIENPTkZJR19HQU1FUE9SVCBpcyBub3Qgc2V0CgojCiMgQ2hhcmFjdGVyIGRldmlj
ZXMKIwpDT05GSUdfVlQ9eQpDT05GSUdfVlRfQ09OU09MRT15CkNPTkZJR19IV19DT05TT0xFPXkK
IyBDT05GSUdfVlRfSFdfQ09OU09MRV9CSU5ESU5HIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VSSUFM
X05PTlNUQU5EQVJEIGlzIG5vdCBzZXQKCiMKIyBTZXJpYWwgZHJpdmVycwojCkNPTkZJR19TRVJJ
QUxfODI1MD15CkNPTkZJR19TRVJJQUxfODI1MF9DT05TT0xFPXkKQ09ORklHX1NFUklBTF84MjUw
X05SX1VBUlRTPTQKQ09ORklHX1NFUklBTF84MjUwX1JVTlRJTUVfVUFSVFM9NAojIENPTkZJR19T
RVJJQUxfODI1MF9FWFRFTkRFRCBpcyBub3Qgc2V0CgojCiMgTm9uLTgyNTAgc2VyaWFsIHBvcnQg
c3VwcG9ydAojCiMgQ09ORklHX1NFUklBTF9VQVJUTElURSBpcyBub3Qgc2V0CkNPTkZJR19TRVJJ
QUxfQ09SRT15CkNPTkZJR19TRVJJQUxfQ09SRV9DT05TT0xFPXkKQ09ORklHX1VOSVg5OF9QVFlT
PXkKIyBDT05GSUdfTEVHQUNZX1BUWVMgaXMgbm90IHNldAojIENPTkZJR19JUE1JX0hBTkRMRVIg
aXMgbm90IHNldApDT05GSUdfSFdfUkFORE9NPXkKIyBDT05GSUdfTlZSQU0gaXMgbm90IHNldAoj
IENPTkZJR19HRU5fUlRDIGlzIG5vdCBzZXQKIyBDT05GSUdfUjM5NjQgaXMgbm90IHNldAojIENP
TkZJR19SQVdfRFJJVkVSIGlzIG5vdCBzZXQKIyBDT05GSUdfVENHX1RQTSBpcyBub3Qgc2V0CiMg
Q09ORklHX0kyQyBpcyBub3Qgc2V0CgojCiMgU1BJIHN1cHBvcnQKIwojIENPTkZJR19TUEkgaXMg
bm90IHNldAojIENPTkZJR19TUElfTUFTVEVSIGlzIG5vdCBzZXQKIyBDT05GSUdfVzEgaXMgbm90
IHNldAojIENPTkZJR19QT1dFUl9TVVBQTFkgaXMgbm90IHNldAojIENPTkZJR19IV01PTiBpcyBu
b3Qgc2V0CiMgQ09ORklHX1dBVENIRE9HIGlzIG5vdCBzZXQKCiMKIyBTb25pY3MgU2lsaWNvbiBC
YWNrcGxhbmUKIwpDT05GSUdfU1NCX1BPU1NJQkxFPXkKIyBDT05GSUdfU1NCIGlzIG5vdCBzZXQK
CiMKIyBNdWx0aWZ1bmN0aW9uIGRldmljZSBkcml2ZXJzCiMKIyBDT05GSUdfTUZEX1NNNTAxIGlz
IG5vdCBzZXQKCiMKIyBNdWx0aW1lZGlhIGRldmljZXMKIwojIENPTkZJR19WSURFT19ERVYgaXMg
bm90IHNldAojIENPTkZJR19EVkJfQ09SRSBpcyBub3Qgc2V0CkNPTkZJR19EQUI9eQojIENPTkZJ
R19VU0JfREFCVVNCIGlzIG5vdCBzZXQKCiMKIyBHcmFwaGljcyBzdXBwb3J0CiMKIyBDT05GSUdf
VkdBU1RBVEUgaXMgbm90IHNldAojIENPTkZJR19WSURFT19PVVRQVVRfQ09OVFJPTCBpcyBub3Qg
c2V0CiMgQ09ORklHX0ZCIGlzIG5vdCBzZXQKIyBDT05GSUdfQkFDS0xJR0hUX0xDRF9TVVBQT1JU
IGlzIG5vdCBzZXQKCiMKIyBEaXNwbGF5IGRldmljZSBzdXBwb3J0CiMKIyBDT05GSUdfRElTUExB
WV9TVVBQT1JUIGlzIG5vdCBzZXQKCiMKIyBDb25zb2xlIGRpc3BsYXkgZHJpdmVyIHN1cHBvcnQK
IwpDT05GSUdfRFVNTVlfQ09OU09MRT15CgojCiMgU291bmQKIwojIENPTkZJR19TT1VORCBpcyBu
b3Qgc2V0CkNPTkZJR19ISURfU1VQUE9SVD15CkNPTkZJR19ISUQ9eQpDT05GSUdfSElEX0RFQlVH
PXkKIyBDT05GSUdfSElEUkFXIGlzIG5vdCBzZXQKCiMKIyBVU0IgSW5wdXQgRGV2aWNlcwojCkNP
TkZJR19VU0JfSElEPXkKIyBDT05GSUdfVVNCX0hJRElOUFVUX1BPV0VSQk9PSyBpcyBub3Qgc2V0
CiMgQ09ORklHX0hJRF9GRiBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9ISURERVYgaXMgbm90IHNl
dApDT05GSUdfVVNCX1NVUFBPUlQ9eQpDT05GSUdfVVNCX0FSQ0hfSEFTX0hDRD15CiMgQ09ORklH
X1VTQl9BUkNIX0hBU19PSENJIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0FSQ0hfSEFTX0VIQ0kg
aXMgbm90IHNldApDT05GSUdfVVNCPXkKQ09ORklHX1VTQl9ERUJVRz15CgojCiMgTWlzY2VsbGFu
ZW91cyBVU0Igb3B0aW9ucwojCkNPTkZJR19VU0JfREVWSUNFRlM9eQpDT05GSUdfVVNCX0RFVklD
RV9DTEFTUz15CkNPTkZJR19VU0JfRFlOQU1JQ19NSU5PUlM9eQojIENPTkZJR19VU0JfT1RHIGlz
IG5vdCBzZXQKCiMKIyBVU0IgSG9zdCBDb250cm9sbGVyIERyaXZlcnMKIwojIENPTkZJR19VU0Jf
SVNQMTE2WF9IQ0QgaXMgbm90IHNldAojIENPTkZJR19VU0JfU0w4MTFfSENEIGlzIG5vdCBzZXQK
IyBDT05GSUdfVVNCX1I4QTY2NTk3X0hDRCBpcyBub3Qgc2V0CkNPTkZJR19VU0JfQzY3WDAwX0RS
Vj15CkNPTkZJR19VU0JfQzY3WDAwX0hDRD15CgojCiMgVVNCIERldmljZSBDbGFzcyBkcml2ZXJz
CiMKIyBDT05GSUdfVVNCX0FDTSBpcyBub3Qgc2V0CkNPTkZJR19VU0JfUFJJTlRFUj15CgojCiMg
Tk9URTogVVNCX1NUT1JBR0UgZW5hYmxlcyBTQ1NJLCBhbmQgJ1NDU0kgZGlzayBzdXBwb3J0Jwoj
CgojCiMgbWF5IGFsc28gYmUgbmVlZGVkOyBzZWUgVVNCX1NUT1JBR0UgSGVscCBmb3IgbW9yZSBp
bmZvcm1hdGlvbgojCkNPTkZJR19VU0JfU1RPUkFHRT15CkNPTkZJR19VU0JfU1RPUkFHRV9ERUJV
Rz15CiMgQ09ORklHX1VTQl9TVE9SQUdFX0RBVEFGQUIgaXMgbm90IHNldAojIENPTkZJR19VU0Jf
U1RPUkFHRV9GUkVFQ09NIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NUT1JBR0VfSVNEMjAwIGlz
IG5vdCBzZXQKIyBDT05GSUdfVVNCX1NUT1JBR0VfRFBDTSBpcyBub3Qgc2V0CiMgQ09ORklHX1VT
Ql9TVE9SQUdFX1VTQkFUIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NUT1JBR0VfU0REUjA5IGlz
IG5vdCBzZXQKIyBDT05GSUdfVVNCX1NUT1JBR0VfU0REUjU1IGlzIG5vdCBzZXQKIyBDT05GSUdf
VVNCX1NUT1JBR0VfSlVNUFNIT1QgaXMgbm90IHNldAojIENPTkZJR19VU0JfU1RPUkFHRV9BTEFV
REEgaXMgbm90IHNldAojIENPTkZJR19VU0JfU1RPUkFHRV9PTkVUT1VDSCBpcyBub3Qgc2V0CiMg
Q09ORklHX1VTQl9TVE9SQUdFX0tBUk1BIGlzIG5vdCBzZXQKQ09ORklHX1VTQl9MSUJVU1VBTD15
CgojCiMgVVNCIEltYWdpbmcgZGV2aWNlcwojCiMgQ09ORklHX1VTQl9NREM4MDAgaXMgbm90IHNl
dAojIENPTkZJR19VU0JfTUlDUk9URUsgaXMgbm90IHNldAojIENPTkZJR19VU0JfTU9OIGlzIG5v
dCBzZXQKCiMKIyBVU0IgcG9ydCBkcml2ZXJzCiMKCiMKIyBVU0IgU2VyaWFsIENvbnZlcnRlciBz
dXBwb3J0CiMKIyBDT05GSUdfVVNCX1NFUklBTCBpcyBub3Qgc2V0CgojCiMgVVNCIE1pc2NlbGxh
bmVvdXMgZHJpdmVycwojCiMgQ09ORklHX1VTQl9FTUk2MiBpcyBub3Qgc2V0CiMgQ09ORklHX1VT
Ql9FTUkyNiBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9BRFVUVVggaXMgbm90IHNldAojIENPTkZJ
R19VU0JfQVVFUlNXQUxEIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1JJTzUwMCBpcyBub3Qgc2V0
CiMgQ09ORklHX1VTQl9MRUdPVE9XRVIgaXMgbm90IHNldAojIENPTkZJR19VU0JfTENEIGlzIG5v
dCBzZXQKIyBDT05GSUdfVVNCX0JFUlJZX0NIQVJHRSBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9M
RUQgaXMgbm90IHNldApDT05GSUdfVVNCX0NZUFJFU1NfQ1k3QzYzPXkKIyBDT05GSUdfVVNCX0NZ
VEhFUk0gaXMgbm90IHNldAojIENPTkZJR19VU0JfUEhJREdFVCBpcyBub3Qgc2V0CiMgQ09ORklH
X1VTQl9JRE1PVVNFIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0ZURElfRUxBTiBpcyBub3Qgc2V0
CiMgQ09ORklHX1VTQl9BUFBMRURJU1BMQVkgaXMgbm90IHNldAojIENPTkZJR19VU0JfTEQgaXMg
bm90IHNldAojIENPTkZJR19VU0JfVFJBTkNFVklCUkFUT1IgaXMgbm90IHNldAojIENPTkZJR19V
U0JfSU9XQVJSSU9SIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1RFU1QgaXMgbm90IHNldAoKIwoj
IFVTQiBEU0wgbW9kZW0gc3VwcG9ydAojCgojCiMgVVNCIEdhZGdldCBTdXBwb3J0CiMKIyBDT05G
SUdfVVNCX0dBREdFVCBpcyBub3Qgc2V0CiMgQ09ORklHX01NQyBpcyBub3Qgc2V0CiMgQ09ORklH
X05FV19MRURTIGlzIG5vdCBzZXQKIyBDT05GSUdfRURBQyBpcyBub3Qgc2V0CiMgQ09ORklHX1JU
Q19DTEFTUyBpcyBub3Qgc2V0CgojCiMgVXNlcnNwYWNlIEkvTwojCiMgQ09ORklHX1VJTyBpcyBu
b3Qgc2V0CgojCiMgRmlsZSBzeXN0ZW1zCiMKQ09ORklHX0VYVDJfRlM9eQpDT05GSUdfRVhUMl9G
U19YQVRUUj15CkNPTkZJR19FWFQyX0ZTX1BPU0lYX0FDTD15CkNPTkZJR19FWFQyX0ZTX1NFQ1VS
SVRZPXkKQ09ORklHX0VYVDJfRlNfWElQPXkKQ09ORklHX0ZTX1hJUD15CiMgQ09ORklHX0VYVDNf
RlMgaXMgbm90IHNldAojIENPTkZJR19FWFQ0REVWX0ZTIGlzIG5vdCBzZXQKQ09ORklHX0ZTX01C
Q0FDSEU9eQojIENPTkZJR19SRUlTRVJGU19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0pGU19GUyBp
cyBub3Qgc2V0CkNPTkZJR19GU19QT1NJWF9BQ0w9eQojIENPTkZJR19YRlNfRlMgaXMgbm90IHNl
dAojIENPTkZJR19HRlMyX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfT0NGUzJfRlMgaXMgbm90IHNl
dAojIENPTkZJR19NSU5JWF9GUyBpcyBub3Qgc2V0CiMgQ09ORklHX1JPTUZTX0ZTIGlzIG5vdCBz
ZXQKQ09ORklHX0lOT1RJRlk9eQpDT05GSUdfSU5PVElGWV9VU0VSPXkKIyBDT05GSUdfUVVPVEEg
aXMgbm90IHNldApDT05GSUdfRE5PVElGWT15CkNPTkZJR19BVVRPRlNfRlM9eQpDT05GSUdfQVVU
T0ZTNF9GUz15CiMgQ09ORklHX0ZVU0VfRlMgaXMgbm90IHNldAoKIwojIENELVJPTS9EVkQgRmls
ZXN5c3RlbXMKIwojIENPTkZJR19JU085NjYwX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfVURGX0ZT
IGlzIG5vdCBzZXQKCiMKIyBET1MvRkFUL05UIEZpbGVzeXN0ZW1zCiMKQ09ORklHX0ZBVF9GUz15
CkNPTkZJR19NU0RPU19GUz15CkNPTkZJR19WRkFUX0ZTPXkKQ09ORklHX0ZBVF9ERUZBVUxUX0NP
REVQQUdFPTQzNwpDT05GSUdfRkFUX0RFRkFVTFRfSU9DSEFSU0VUPSJpc284ODU5LTEiCkNPTkZJ
R19OVEZTX0ZTPXkKQ09ORklHX05URlNfREVCVUc9eQpDT05GSUdfTlRGU19SVz15CgojCiMgUHNl
dWRvIGZpbGVzeXN0ZW1zCiMKQ09ORklHX1BST0NfRlM9eQpDT05GSUdfUFJPQ19LQ09SRT15CkNP
TkZJR19QUk9DX1NZU0NUTD15CkNPTkZJR19TWVNGUz15CkNPTkZJR19UTVBGUz15CiMgQ09ORklH
X1RNUEZTX1BPU0lYX0FDTCBpcyBub3Qgc2V0CiMgQ09ORklHX0hVR0VUTEJfUEFHRSBpcyBub3Qg
c2V0CiMgQ09ORklHX0NPTkZJR0ZTX0ZTIGlzIG5vdCBzZXQKCiMKIyBNaXNjZWxsYW5lb3VzIGZp
bGVzeXN0ZW1zCiMKIyBDT05GSUdfQURGU19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0FGRlNfRlMg
aXMgbm90IHNldAojIENPTkZJR19IRlNfRlMgaXMgbm90IHNldAojIENPTkZJR19IRlNQTFVTX0ZT
IGlzIG5vdCBzZXQKIyBDT05GSUdfQkVGU19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0JGU19GUyBp
cyBub3Qgc2V0CiMgQ09ORklHX0VGU19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0NSQU1GUyBpcyBu
b3Qgc2V0CiMgQ09ORklHX1ZYRlNfRlMgaXMgbm90IHNldAojIENPTkZJR19IUEZTX0ZTIGlzIG5v
dCBzZXQKIyBDT05GSUdfUU5YNEZTX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfU1lTVl9GUyBpcyBu
b3Qgc2V0CiMgQ09ORklHX1VGU19GUyBpcyBub3Qgc2V0CkNPTkZJR19ORVRXT1JLX0ZJTEVTWVNU
RU1TPXkKIyBDT05GSUdfTkZTX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfTkZTRCBpcyBub3Qgc2V0
CiMgQ09ORklHX1NNQl9GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0NJRlMgaXMgbm90IHNldAojIENP
TkZJR19OQ1BfRlMgaXMgbm90IHNldAojIENPTkZJR19DT0RBX0ZTIGlzIG5vdCBzZXQKIyBDT05G
SUdfQUZTX0ZTIGlzIG5vdCBzZXQKCiMKIyBQYXJ0aXRpb24gVHlwZXMKIwojIENPTkZJR19QQVJU
SVRJT05fQURWQU5DRUQgaXMgbm90IHNldApDT05GSUdfTVNET1NfUEFSVElUSU9OPXkKQ09ORklH
X05MUz15CkNPTkZJR19OTFNfREVGQVVMVD0iaXNvODg1OS0xIgpDT05GSUdfTkxTX0NPREVQQUdF
XzQzNz15CiMgQ09ORklHX05MU19DT0RFUEFHRV83MzcgaXMgbm90IHNldAojIENPTkZJR19OTFNf
Q09ERVBBR0VfNzc1IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0NPREVQQUdFXzg1MCBpcyBub3Qg
c2V0CiMgQ09ORklHX05MU19DT0RFUEFHRV84NTIgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09E
RVBBR0VfODU1IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0NPREVQQUdFXzg1NyBpcyBub3Qgc2V0
CiMgQ09ORklHX05MU19DT0RFUEFHRV84NjAgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBB
R0VfODYxIGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0NPREVQQUdFXzg2MiBpcyBub3Qgc2V0CiMg
Q09ORklHX05MU19DT0RFUEFHRV84NjMgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0Vf
ODY0IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0NPREVQQUdFXzg2NSBpcyBub3Qgc2V0CiMgQ09O
RklHX05MU19DT0RFUEFHRV84NjYgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfODY5
IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0NPREVQQUdFXzkzNiBpcyBub3Qgc2V0CiMgQ09ORklH
X05MU19DT0RFUEFHRV85NTAgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfOTMyIGlz
IG5vdCBzZXQKIyBDT05GSUdfTkxTX0NPREVQQUdFXzk0OSBpcyBub3Qgc2V0CiMgQ09ORklHX05M
U19DT0RFUEFHRV84NzQgaXMgbm90IHNldAojIENPTkZJR19OTFNfSVNPODg1OV84IGlzIG5vdCBz
ZXQKIyBDT05GSUdfTkxTX0NPREVQQUdFXzEyNTAgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09E
RVBBR0VfMTI1MSBpcyBub3Qgc2V0CkNPTkZJR19OTFNfQVNDSUk9eQpDT05GSUdfTkxTX0lTTzg4
NTlfMT15CiMgQ09ORklHX05MU19JU084ODU5XzIgaXMgbm90IHNldAojIENPTkZJR19OTFNfSVNP
ODg1OV8zIGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0lTTzg4NTlfNCBpcyBub3Qgc2V0CiMgQ09O
RklHX05MU19JU084ODU5XzUgaXMgbm90IHNldAojIENPTkZJR19OTFNfSVNPODg1OV82IGlzIG5v
dCBzZXQKIyBDT05GSUdfTkxTX0lTTzg4NTlfNyBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19JU084
ODU5XzkgaXMgbm90IHNldAojIENPTkZJR19OTFNfSVNPODg1OV8xMyBpcyBub3Qgc2V0CiMgQ09O
RklHX05MU19JU084ODU5XzE0IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0lTTzg4NTlfMTUgaXMg
bm90IHNldAojIENPTkZJR19OTFNfS09JOF9SIGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0tPSThf
VSBpcyBub3Qgc2V0CkNPTkZJR19OTFNfVVRGOD15CiMgQ09ORklHX0RMTSBpcyBub3Qgc2V0Cgoj
CiMgSUJNIDQweCBvcHRpb25zCiMKCiMKIyBMaWJyYXJ5IHJvdXRpbmVzCiMKQ09ORklHX0JJVFJF
VkVSU0U9eQojIENPTkZJR19DUkNfQ0NJVFQgaXMgbm90IHNldAojIENPTkZJR19DUkMxNiBpcyBu
b3Qgc2V0CiMgQ09ORklHX0NSQ19JVFVfVCBpcyBub3Qgc2V0CkNPTkZJR19DUkMzMj15CiMgQ09O
RklHX0NSQzcgaXMgbm90IHNldAojIENPTkZJR19MSUJDUkMzMkMgaXMgbm90IHNldApDT05GSUdf
UExJU1Q9eQpDT05GSUdfSEFTX0lPTUVNPXkKQ09ORklHX0hBU19JT1BPUlQ9eQpDT05GSUdfSEFT
X0RNQT15CkNPTkZJR19JTlNUUlVNRU5UQVRJT049eQojIENPTkZJR19QUk9GSUxJTkcgaXMgbm90
IHNldAojIENPTkZJR19NQVJLRVJTIGlzIG5vdCBzZXQKCiMKIyBLZXJuZWwgaGFja2luZwojCkNP
TkZJR19QUklOVEtfVElNRT15CkNPTkZJR19FTkFCTEVfV0FSTl9ERVBSRUNBVEVEPXkKQ09ORklH
X0VOQUJMRV9NVVNUX0NIRUNLPXkKQ09ORklHX01BR0lDX1NZU1JRPXkKIyBDT05GSUdfVU5VU0VE
X1NZTUJPTFMgaXMgbm90IHNldAojIENPTkZJR19ERUJVR19GUyBpcyBub3Qgc2V0CiMgQ09ORklH
X0hFQURFUlNfQ0hFQ0sgaXMgbm90IHNldApDT05GSUdfREVCVUdfS0VSTkVMPXkKIyBDT05GSUdf
REVCVUdfU0hJUlEgaXMgbm90IHNldApDT05GSUdfREVURUNUX1NPRlRMT0NLVVA9eQpDT05GSUdf
U0NIRURfREVCVUc9eQojIENPTkZJR19TQ0hFRFNUQVRTIGlzIG5vdCBzZXQKIyBDT05GSUdfVElN
RVJfU1RBVFMgaXMgbm90IHNldAojIENPTkZJR19ERUJVR19TTEFCIGlzIG5vdCBzZXQKIyBDT05G
SUdfREVCVUdfUlRfTVVURVhFUyBpcyBub3Qgc2V0CiMgQ09ORklHX1JUX01VVEVYX1RFU1RFUiBp
cyBub3Qgc2V0CiMgQ09ORklHX0RFQlVHX1NQSU5MT0NLIGlzIG5vdCBzZXQKQ09ORklHX0RFQlVH
X01VVEVYRVM9eQojIENPTkZJR19ERUJVR19TUElOTE9DS19TTEVFUCBpcyBub3Qgc2V0CiMgQ09O
RklHX0RFQlVHX0xPQ0tJTkdfQVBJX1NFTEZURVNUUyBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQlVH
X0tPQkpFQ1QgaXMgbm90IHNldApDT05GSUdfREVCVUdfQlVHVkVSQk9TRT15CkNPTkZJR19ERUJV
R19JTkZPPXkKIyBDT05GSUdfREVCVUdfVk0gaXMgbm90IHNldAojIENPTkZJR19ERUJVR19MSVNU
IGlzIG5vdCBzZXQKIyBDT05GSUdfREVCVUdfU0cgaXMgbm90IHNldApDT05GSUdfRk9SQ0VEX0lO
TElOSU5HPXkKIyBDT05GSUdfQk9PVF9QUklOVEtfREVMQVkgaXMgbm90IHNldAojIENPTkZJR19G
QVVMVF9JTkpFQ1RJT04gaXMgbm90IHNldAojIENPTkZJR19TQU1QTEVTIGlzIG5vdCBzZXQKIyBD
T05GSUdfS0dEQiBpcyBub3Qgc2V0CiMgQ09ORklHX1hNT04gaXMgbm90IHNldAojIENPTkZJR19C
RElfU1dJVENIIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VSSUFMX1RFWFRfREVCVUcgaXMgbm90IHNl
dAoKIwojIFNlY3VyaXR5IG9wdGlvbnMKIwojIENPTkZJR19LRVlTIGlzIG5vdCBzZXQKIyBDT05G
SUdfU0VDVVJJVFkgaXMgbm90IHNldAojIENPTkZJR19TRUNVUklUWV9GSUxFX0NBUEFCSUxJVElF
UyBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUTyBpcyBub3Qgc2V0Cg==
------=_Part_13319_811811.1208972820181--
