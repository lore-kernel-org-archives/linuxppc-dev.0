Return-Path: <sydneymartin@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.205])
	by ozlabs.org (Postfix) with ESMTP id F0C792BDB5
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Jan 2005 12:01:16 +1100 (EST)
Received: by wproxy.gmail.com with SMTP id 69so663448wra
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Dec 2004 17:01:15 -0800 (PST)
Message-ID: <855e88d004123116541edc4d61@mail.gmail.com>
Date: Fri, 31 Dec 2004 19:54:34 -0500
From: Mike Martin <sydneymartin@gmail.com>
To: Sven Luther <sven.luther@wanadoo.fr>
In-Reply-To: <20041231095310.GA16214@pegasos>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----=_Part_720_2236249.1104540874883"
References: <855e88d00412291051792d3daa@mail.gmail.com>
	<20041231095310.GA16214@pegasos>
Cc: linuxppc-dev@ozlabs.org, debian-powerpc@lists.debian.org,
	debian-kernel@lists.debian.org
Subject: Re: 43p-140 install issues
Reply-To: mikemartin@linux.ca
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_720_2236249.1104540874883
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

(re-sending for the benefit of those on the lists .. sorry Sven)

Would there be any image I can use to install this machine currently?
Here's my situation, If I can get the machine to boot and install by
next week (back to work) my boss will let me keep working on it -
otherwise he'll declare it useless and it'll go back in the closet. If
I can get anything on it I'm ok - It doesn't need to be 2.6.

Attached is /var/log/syslog and /var/log/messages.


Mike Martin



On Fri, 31 Dec 2004 10:53:10 +0100, Sven Luther <sven.luther@wanadoo.fr> wrote:
> On Wed, Dec 29, 2004 at 01:51:51PM -0500, Mike Martin wrote:
> > I have a 43p-140, It will netboot, start the installer and let be run
> > through the motions. It doesn't seem to be able to recognize the cdrom
> > or be able to set up the network. This puts a stop on the installation
> > pretty quickly. I can't seem to figure it out on my own. Can anyone
> > help?
> >
> > Attached is a console capture from my latest boot using the Dec. 28th
> > image from:
> > http://people.debian.org/~luther/debian-installer/daily-powerpc-built/daily/powerpc/netboot/
> >
> > Other images are similar.
> 
> Could you try to get the /var/log/syslog and /var/log/messages out of that box
> ?
> 
> > When the installer gets to configuring the network with DHCP, it
> > fails. "tcpdump" on the server interface shows no traffic after the
> > tftp image is transfered.
> 
> Mmm, could this be similar to :
> 
>   http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=283329
> 
> I am trying the install on a motorola powerstack (utah board), which has a
> decchip (de4x5) ethernet, and things are worse, the machine freezes when
> trying to ifup the interface :
> 
>   http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=287933
> 
> I get some strange feeling that something is seriously wrong with the 2.6
> kernels on prep hardware. Let me CC this to linuxppc-dev mailing lists too.
> 
> I will not have time to look into this problem before next year though :), and
> probably not before a week or so at that.
> 
> Friendly,
> 
> Sven Luther
> 
>

------=_Part_720_2236249.1104540874883
Content-Type: text/plain; name="43plogs.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="43plogs.txt"


~ # cat /var/log/syslog
Dec 31 16:11:07 syslogd started: BusyBox v1.00-pre10 (Debian 20040623-1)
Dec 31 16:11:07 kernel: klogd started: BusyBox v1.00-pre10 (Debian 20040623=
-1)
Dec 31 16:11:07 kernel: Total memory =3D 256MB; using 512kB for hash table =
(at c0300000)
Dec 31 16:11:07 kernel: Linux version 2.6.8-powerpc (sven@pegasos2) (versio=
n gcc 3.3.5 (Debian 1:3.3.5-2)) #1 Thu Dec 9 10:27:54 CET 2004
Dec 31 16:11:07 kernel: PReP architecture
Dec 31 16:11:07 kernel: IBM planar ID: 000000d5
Dec 31 16:11:07 kernel: MPIC at 0xfddc0000 (0x3ddc0000), length 0x00040000 =
mapped to 0xeffc0000
Dec 31 16:11:07 kernel: On node 0 totalpages: 65536
Dec 31 16:11:07 kernel:   DMA zone: 65536 pages, LIFO batch:16
Dec 31 16:11:07 kernel:   Normal zone: 0 pages, LIFO batch:1
Dec 31 16:11:07 kernel:   HighMem zone: 0 pages, LIFO batch:1
Dec 31 16:11:07 kernel: Built 1 zonelists
Dec 31 16:11:07 kernel: Kernel command line: console=3DttyS0,9600 root=3D/d=
ev/ram
Dec 31 16:11:07 kernel: OpenPIC Version 1.0 (4 CPUs and 16 IRQ sources) at =
effc0000
Dec 31 16:11:07 kernel: PID hash table entries: 2048 (order 11: 16384 bytes=
)
Dec 31 16:11:07 kernel: time_init: decrementer frequency =3D 16.617869 MHz
Dec 31 16:11:07 kernel: Console: colour dummy device 80x25
Dec 31 16:11:07 kernel: Dentry cache hash table entries: 65536 (order: 6, 2=
62144 bytes)
Dec 31 16:11:07 kernel: Inode-cache hash table entries: 32768 (order: 5, 13=
1072 bytes)
Dec 31 16:11:07 kernel: Memory: 251712k available (1732k kernel code, 1060k=
 data, 164k init, 0k highmem)
Dec 31 16:11:07 kernel: Calibrating delay loop... 330.75 BogoMIPS
Dec 31 16:11:07 kernel: Mount-cache hash table entries: 512 (order: 0, 4096=
 bytes)
Dec 31 16:11:07 kernel: checking if image is initramfs...it isn't (no cpio =
magic); looks like an initrd
Dec 31 16:11:07 kernel: Freeing initrd memory: 4098k freed
Dec 31 16:11:07 kernel: NET: Registered protocol family 16
Dec 31 16:11:07 kernel: PCI: Probing PCI hardware
Dec 31 16:11:07 kernel: Setting PCI interrupts for a "IBM 43P-140 (Tiger1)"
Dec 31 16:11:07 kernel: PCI: Cannot allocate resource region 0 of PCI bridg=
e 1
Dec 31 16:11:07 kernel: PCI: bridge 1 resource 0 moved to 7ff000..7fffff
Dec 31 16:11:07 kernel: PCI: Cannot allocate resource region 0 of device 00=
00:00:0b.0
Dec 31 16:11:07 kernel: PCI: Cannot allocate resource region 0 of device 00=
00:00:0c.0
Dec 31 16:11:07 kernel: PCI: Cannot allocate resource region 0 of device 00=
00:00:10.0
Dec 31 16:11:07 kernel: PCI: Cannot allocate resource region 0 of device 00=
00:00:12.0
Dec 31 16:11:07 kernel: PCI: Cannot allocate resource region 0 of device 00=
00:01:03.0
Dec 31 16:11:07 kernel: Registering openpic with sysfs...
Dec 31 16:11:07 kernel: Thermal assist unit not available
Dec 31 16:11:07 kernel: audit: initializing netlink socket (disabled)
Dec 31 16:11:07 kernel: audit(1104509463.578:0): initialized
Dec 31 16:11:07 kernel: devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.=
au)
Dec 31 16:11:07 kernel: devfs: boot_options: 0x0
Dec 31 16:11:07 kernel: Initializing Cryptographic API
Dec 31 16:11:07 kernel: Generic RTC Driver v1.07
Dec 31 16:11:07 kernel: Macintosh non-volatile memory driver v1.1
Dec 31 16:11:07 kernel: Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports=
, IRQ sharing disabled
Dec 31 16:11:07 kernel: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
Dec 31 16:11:07 kernel: ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A
Dec 31 16:11:07 kernel: pmac_zilog: 0.6 (Benjamin Herrenschmidt <benh@kerne=
l.crashing.org>)
Dec 31 16:11:07 kernel: RAMDISK driver initialized: 16 RAM disks of 8192K s=
ize 1024 blocksize
Dec 31 16:11:07 kernel: divert: not allocating divert_blk for non-ethernet =
device lo
Dec 31 16:11:07 kernel: input: Macintosh mouse button emulation
Dec 31 16:11:07 kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00a=
lpha2
Dec 31 16:11:07 kernel: ide: Assuming 33MHz system bus speed for PIO modes;=
 override with idebus=3Dxx
Dec 31 16:11:07 kernel: mice: PS/2 mouse device common for all mice
Dec 31 16:11:07 kernel: NET: Registered protocol family 2
Dec 31 16:11:07 kernel: IP: routing cache hash table of 2048 buckets, 16Kby=
tes
Dec 31 16:11:07 kernel: TCP: Hash tables configured (established 16384 bind=
 32768)
Dec 31 16:11:07 kernel: RAMDISK: Compressed image found at block 0
Dec 31 16:11:07 kernel: VFS: Mounted root (cramfs filesystem) readonly.
Dec 31 16:11:07 kernel: Freeing unused kernel memory: 164k init 60k pmac 4k=
 chrp 8k openfirmware
Dec 31 16:11:07 kernel: NET: Registered protocol family 1
Dec 31 16:11:10 kernel: usbcore: registered new driver usbfs
Dec 31 16:11:10 kernel: usbcore: registered new driver hub
Dec 31 16:11:10 kernel: usbcore: registered new driver hiddev
Dec 31 16:11:10 kernel: usbcore: registered new driver usbhid
Dec 31 16:11:10 kernel: drivers/usb/input/hid-core.c: v2.0:USB HID core dri=
ver
Dec 31 16:11:10 kernel: drivers/usb/serial/usb-serial.c: USB Serial support=
 registered for Generic
Dec 31 16:11:10 kernel: usbcore: registered new driver usbserial_generic
Dec 31 16:11:10 kernel: usbcore: registered new driver usbserial
Dec 31 16:11:10 kernel: drivers/usb/serial/usb-serial.c: USB Serial Driver =
core v2.0
Dec 31 16:11:13 preseed: successfully loaded preseed file from /preseed.cfg
Dec 31 16:11:13 kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Dec 31 16:11:13 kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Dec 31 16:11:14 kernel: atkbd.c: keyboard reset failed on isa0060/serio1
Dec 31 16:11:14 kernel: atkbd.c: keyboard reset failed on isa0060/serio0
Dec 31 16:11:14 init: ^MStarting pid 418, console /dev/tts/0: '/sbin/debian=
-installer'
Dec 31 16:11:14 init: ^MStarting pid 422, console /dev/vc/3: '/usr/bin/tail=
'
Dec 31 16:11:14 init: ^MStarting pid 424, console /dev/vc/4: '/usr/bin/tail=
'
Dec 31 16:11:17 main-menu[449]: DEBUG: resolver (libc6): package doesn't ex=
ist (ignored)=20
Dec 31 16:11:17 main-menu[449]: DEBUG: resolver (libdebian-installer4): sea=
rch, dependency from cdebconf-udeb=20
Dec 31 16:11:17 main-menu[449]: DEBUG: resolver (libdebian-installer4-udeb)=
: mark, dependency from cdebconf-udeb=20
Dec 31 16:11:17 main-menu[449]: DEBUG: resolver (libtextwrap1): package doe=
sn't exist (ignored)=20
Dec 31 16:11:17 main-menu[449]: DEBUG: resolver (cdebconf-udeb): mark, depe=
ndency from languagechooser=20
Dec 31 16:11:17 main-menu[449]: DEBUG: resolver (languagechooser): mark=20
Dec 31 16:11:17 main-menu[449]: DEBUG: resolver (iso-3166-udeb): mark, depe=
ndency from countrychooser=20
Dec 31 16:11:17 main-menu[449]: DEBUG: resolver (countrychooser): mark=20
Dec 31 16:11:17 main-menu[449]: DEBUG: resolver (libdebconfclient0): search=
, dependency from kbd-chooser=20
Dec 31 16:11:17 main-menu[449]: DEBUG: resolver (libdebconfclient0-udeb): m=
ark, dependency from kbd-chooser=20
Dec 31 16:11:17 main-menu[449]: DEBUG: resolver (console-keymaps): search, =
dependency from kbd-chooser=20
Dec 31 16:11:17 main-menu[449]: DEBUG: resolver (console-keymaps-usb): mark=
, dependency from kbd-chooser=20
Dec 31 16:11:17 main-menu[449]: DEBUG: resolver (archdetect): mark, depende=
ncy from kbd-chooser=20
Dec 31 16:11:17 main-menu[449]: DEBUG: resolver (kbd-chooser): mark=20
Dec 31 16:11:17 main-menu[449]: DEBUG: resolver (discover): search, depende=
ncy from hw-detect=20
Dec 31 16:11:17 main-menu[449]: DEBUG: resolver (libdiscover1): package doe=
sn't exist (ignored)=20
Dec 31 16:11:17 main-menu[449]: DEBUG: resolver (discover1-data-udeb): mark=
, dependency from discover1-udeb=20
Dec 31 16:11:17 main-menu[449]: DEBUG: resolver (discover1-udeb): mark, dep=
endency from hw-detect=20
Dec 31 16:11:17 main-menu[449]: DEBUG: resolver (rootskel): mark, dependenc=
y from hw-detect=20
Dec 31 16:11:17 main-menu[449]: DEBUG: resolver (hw-detect): mark, dependen=
cy from ethdetect=20
Dec 31 16:11:17 main-menu[449]: DEBUG: resolver (ethdetect): mark=20
Dec 31 16:11:17 main-menu[449]: DEBUG: resolver (libiw27): search, dependen=
cy from netcfg=20
Dec 31 16:11:17 main-menu[449]: DEBUG: resolver (libiw27-udeb): mark, depen=
dency from netcfg=20
Dec 31 16:11:17 main-menu[449]: DEBUG: resolver (dhcp-client-udeb): mark, d=
ependency from netcfg=20
Dec 31 16:11:17 main-menu[449]: DEBUG: resolver (ethernet-card-detection): =
search, dependency from netcfg=20
Dec 31 16:11:17 main-menu[449]: DEBUG: resolver (netcfg): mark=20
Dec 31 16:11:17 main-menu[449]: DEBUG: resolver (configured-network): searc=
h, dependency from network-preseed=20
Dec 31 16:11:17 main-menu[449]: DEBUG: resolver (di-utils): mark, dependenc=
y from network-preseed=20
Dec 31 16:11:17 main-menu[449]: DEBUG: resolver (network-preseed): mark=20
Dec 31 16:11:17 main-menu[449]: DEBUG: resolver (choose-mirror): mark=20
Dec 31 16:11:17 main-menu[449]: DEBUG: resolver (net-retriever): mark, depe=
ndency from download-installer=20
Dec 31 16:11:17 main-menu[449]: DEBUG: resolver (anna): mark, dependency fr=
om download-installer=20
Dec 31 16:11:17 main-menu[449]: DEBUG: resolver (download-installer): mark=
=20
Dec 31 16:11:17 main-menu[449]: DEBUG: resolver (di-utils-shell): mark=20
Dec 31 16:11:17 main-menu[449]: DEBUG: resolver (di-utils-reboot): mark=20
Dec 31 16:11:17 main-menu[449]: DEBUG: Menu item 'languagechooser' selected=
=20
Dec 31 16:11:17 main-menu[449]: DEBUG: configure languagechooser, status: 2=
 =20
Dec 31 16:11:17 main-menu[449]: DEBUG: configure cdebconf-udeb, status: 2 =
=20
Dec 31 16:11:17 main-menu[449]: DEBUG: configure libc6, status: 0 =20
Dec 31 16:11:17 main-menu[449]: DEBUG: configure libdebian-installer4, stat=
us: 0 =20
Dec 31 16:11:17 main-menu[449]: DEBUG: virtual package libdebian-installer4=
 =20
Dec 31 16:11:17 main-menu[449]: INFO: Falling back to the package descripti=
on for libdebian-installer4-udeb=20
Dec 31 16:11:17 main-menu[449]: INFO: Falling back to the package descripti=
on for libdebian-installer4-udeb=20
Dec 31 16:11:17 main-menu[449]: DEBUG: configure libdebian-installer4-udeb,=
 status: 2 =20
Dec 31 16:11:17 main-menu[449]: DEBUG: configure libc6, status: 0 =20
Dec 31 16:11:17 main-menu[449]: DEBUG: configure libtextwrap1, status: 0 =
=20
Dec 31 16:11:17 debconf: Setting debconf/language to C
Dec 31 16:11:28 debconf: Setting debconf/language to en_US:en_GB:en
Dec 31 16:11:28 languagechooser: info: Asking for language specific package=
s to be Installed.
Dec 31 16:11:28 languagechooser: info: debian-installer/locale   =3D 'en'
Dec 31 16:11:28 languagechooser: info: debian-installer/fallbacklocale   =
=3D 'en_US@euro'
Dec 31 16:11:28 languagechooser: info: languagechooser/locale   =3D 'en'
Dec 31 16:11:28 languagechooser: info: debian-installer/language =3D 'en_US=
:en_GB:en'
Dec 31 16:11:28 languagechooser: info: debian-installer/country  =3D 'US'
Dec 31 16:11:28 languagechooser: info: debian-installer/consoledisplay  =3D=
 'kbd=3Dlat0-sun16(iso15)'
Dec 31 16:11:28 main-menu[449]: INFO: Priority changed externally, setting =
main-menu default to 'high' (high)=20
Dec 31 16:11:29 main-menu[449]: DEBUG: resolver (libc6): package doesn't ex=
ist (ignored)=20
Dec 31 16:11:29 main-menu[449]: DEBUG: resolver (libdebian-installer4): sea=
rch, dependency from cdebconf-udeb=20
Dec 31 16:11:29 main-menu[449]: DEBUG: resolver (libdebian-installer4-udeb)=
: mark, dependency from cdebconf-udeb=20
Dec 31 16:11:29 main-menu[449]: DEBUG: resolver (libtextwrap1): package doe=
sn't exist (ignored)=20
Dec 31 16:11:29 main-menu[449]: DEBUG: resolver (cdebconf-udeb): mark, depe=
ndency from languagechooser=20
Dec 31 16:11:29 main-menu[449]: DEBUG: resolver (languagechooser): mark=20
Dec 31 16:11:29 main-menu[449]: DEBUG: resolver (iso-3166-udeb): mark, depe=
ndency from countrychooser=20
Dec 31 16:11:29 main-menu[449]: DEBUG: resolver (countrychooser): mark=20
Dec 31 16:11:29 main-menu[449]: DEBUG: resolver (libdebconfclient0): search=
, dependency from kbd-chooser=20
Dec 31 16:11:29 main-menu[449]: DEBUG: resolver (libdebconfclient0-udeb): m=
ark, dependency from kbd-chooser=20
Dec 31 16:11:29 main-menu[449]: DEBUG: resolver (console-keymaps): search, =
dependency from kbd-chooser=20
Dec 31 16:11:29 main-menu[449]: DEBUG: resolver (console-keymaps-usb): mark=
, dependency from kbd-chooser=20
Dec 31 16:11:29 main-menu[449]: DEBUG: resolver (archdetect): mark, depende=
ncy from kbd-chooser=20
Dec 31 16:11:29 main-menu[449]: DEBUG: resolver (kbd-chooser): mark=20
Dec 31 16:11:29 main-menu[449]: DEBUG: resolver (discover): search, depende=
ncy from hw-detect=20
Dec 31 16:11:29 main-menu[449]: DEBUG: resolver (libdiscover1): package doe=
sn't exist (ignored)=20
Dec 31 16:11:29 main-menu[449]: DEBUG: resolver (discover1-data-udeb): mark=
, dependency from discover1-udeb=20
Dec 31 16:11:29 main-menu[449]: DEBUG: resolver (discover1-udeb): mark, dep=
endency from hw-detect=20
Dec 31 16:11:29 main-menu[449]: DEBUG: resolver (rootskel): mark, dependenc=
y from hw-detect=20
Dec 31 16:11:29 main-menu[449]: DEBUG: resolver (hw-detect): mark, dependen=
cy from ethdetect=20
Dec 31 16:11:29 main-menu[449]: DEBUG: resolver (ethdetect): mark=20
Dec 31 16:11:29 main-menu[449]: DEBUG: resolver (libiw27): search, dependen=
cy from netcfg=20
Dec 31 16:11:29 main-menu[449]: DEBUG: resolver (libiw27-udeb): mark, depen=
dency from netcfg=20
Dec 31 16:11:29 main-menu[449]: DEBUG: resolver (dhcp-client-udeb): mark, d=
ependency from netcfg=20
Dec 31 16:11:29 main-menu[449]: DEBUG: resolver (ethernet-card-detection): =
search, dependency from netcfg=20
Dec 31 16:11:29 main-menu[449]: DEBUG: resolver (netcfg): mark=20
Dec 31 16:11:29 main-menu[449]: DEBUG: resolver (configured-network): searc=
h, dependency from network-preseed=20
Dec 31 16:11:29 main-menu[449]: DEBUG: resolver (di-utils): mark, dependenc=
y from network-preseed=20
Dec 31 16:11:29 main-menu[449]: DEBUG: resolver (network-preseed): mark=20
Dec 31 16:11:29 main-menu[449]: DEBUG: resolver (choose-mirror): mark=20
Dec 31 16:11:29 main-menu[449]: DEBUG: resolver (net-retriever): mark, depe=
ndency from download-installer=20
Dec 31 16:11:29 main-menu[449]: DEBUG: resolver (anna): mark, dependency fr=
om download-installer=20
Dec 31 16:11:29 main-menu[449]: DEBUG: resolver (download-installer): mark=
=20
Dec 31 16:11:29 main-menu[449]: DEBUG: resolver (di-utils-shell): mark=20
Dec 31 16:11:29 main-menu[449]: DEBUG: resolver (di-utils-reboot): mark=20
Dec 31 16:11:29 main-menu[449]: DEBUG: Menu item 'countrychooser' selected=
=20
Dec 31 16:11:29 main-menu[449]: DEBUG: configure countrychooser, status: 2 =
=20
Dec 31 16:11:29 main-menu[449]: DEBUG: configure iso-3166-udeb, status: 2 =
=20
Dec 31 16:11:29 countrychooser: info: LANGUAGECODE_LANGUAGECHOOSER =3D 'en'
Dec 31 16:11:29 countrychooser: info: COUNTRYCODE_LANGUAGECHOOSER =3D 'US'
Dec 31 16:11:29 countrychooser: info: LOCALE_LANGUAGECHOOSER =3D 'en'
Dec 31 16:11:29 countrychooser: info: FALLBACKLOCALE =3D 'en_US@euro'
Dec 31 16:11:38 countrychooser: info: Set debian-installer/country =3D 'CA'
Dec 31 16:11:38 countrychooser: info: LANGUAGE =3D 'en'
Dec 31 16:11:38 countrychooser: info: COUNTRYCODE =3D 'CA'
Dec 31 16:11:39 countrychooser: info: Set debian-installer/locale =3D 'en_C=
A'
Dec 31 16:11:39 countrychooser: info: Set debian-installer/language =3D 'en=
_CA:en_US:en_GB:en'
Dec 31 16:11:39 main-menu[449]: DEBUG: resolver (libc6): package doesn't ex=
ist (ignored)=20
Dec 31 16:11:39 main-menu[449]: DEBUG: resolver (libdebian-installer4): sea=
rch, dependency from cdebconf-udeb=20
Dec 31 16:11:39 main-menu[449]: DEBUG: resolver (libdebian-installer4-udeb)=
: mark, dependency from cdebconf-udeb=20
Dec 31 16:11:39 main-menu[449]: DEBUG: resolver (libtextwrap1): package doe=
sn't exist (ignored)=20
Dec 31 16:11:39 main-menu[449]: DEBUG: resolver (cdebconf-udeb): mark, depe=
ndency from languagechooser=20
Dec 31 16:11:39 main-menu[449]: DEBUG: resolver (languagechooser): mark=20
Dec 31 16:11:39 main-menu[449]: DEBUG: resolver (iso-3166-udeb): mark, depe=
ndency from countrychooser=20
Dec 31 16:11:39 main-menu[449]: DEBUG: resolver (countrychooser): mark=20
Dec 31 16:11:39 main-menu[449]: DEBUG: resolver (libdebconfclient0): search=
, dependency from kbd-chooser=20
Dec 31 16:11:39 main-menu[449]: DEBUG: resolver (libdebconfclient0-udeb): m=
ark, dependency from kbd-chooser=20
Dec 31 16:11:39 main-menu[449]: DEBUG: resolver (console-keymaps): search, =
dependency from kbd-chooser=20
Dec 31 16:11:39 main-menu[449]: DEBUG: resolver (console-keymaps-usb): mark=
, dependency from kbd-chooser=20
Dec 31 16:11:39 main-menu[449]: DEBUG: resolver (archdetect): mark, depende=
ncy from kbd-chooser=20
Dec 31 16:11:39 main-menu[449]: DEBUG: resolver (kbd-chooser): mark=20
Dec 31 16:11:39 main-menu[449]: DEBUG: resolver (discover): search, depende=
ncy from hw-detect=20
Dec 31 16:11:39 main-menu[449]: DEBUG: resolver (libdiscover1): package doe=
sn't exist (ignored)=20
Dec 31 16:11:39 main-menu[449]: DEBUG: resolver (discover1-data-udeb): mark=
, dependency from discover1-udeb=20
Dec 31 16:11:39 main-menu[449]: DEBUG: resolver (discover1-udeb): mark, dep=
endency from hw-detect=20
Dec 31 16:11:39 main-menu[449]: DEBUG: resolver (rootskel): mark, dependenc=
y from hw-detect=20
Dec 31 16:11:39 main-menu[449]: DEBUG: resolver (hw-detect): mark, dependen=
cy from ethdetect=20
Dec 31 16:11:39 main-menu[449]: DEBUG: resolver (ethdetect): mark=20
Dec 31 16:11:39 main-menu[449]: DEBUG: resolver (libiw27): search, dependen=
cy from netcfg=20
Dec 31 16:11:39 main-menu[449]: DEBUG: resolver (libiw27-udeb): mark, depen=
dency from netcfg=20
Dec 31 16:11:39 main-menu[449]: DEBUG: resolver (dhcp-client-udeb): mark, d=
ependency from netcfg=20
Dec 31 16:11:39 main-menu[449]: DEBUG: resolver (ethernet-card-detection): =
search, dependency from netcfg=20
Dec 31 16:11:39 main-menu[449]: DEBUG: resolver (netcfg): mark=20
Dec 31 16:11:39 main-menu[449]: DEBUG: resolver (configured-network): searc=
h, dependency from network-preseed=20
Dec 31 16:11:39 main-menu[449]: DEBUG: resolver (di-utils): mark, dependenc=
y from network-preseed=20
Dec 31 16:11:39 main-menu[449]: DEBUG: resolver (network-preseed): mark=20
Dec 31 16:11:39 main-menu[449]: DEBUG: resolver (choose-mirror): mark=20
Dec 31 16:11:39 main-menu[449]: DEBUG: resolver (net-retriever): mark, depe=
ndency from download-installer=20
Dec 31 16:11:39 main-menu[449]: DEBUG: resolver (anna): mark, dependency fr=
om download-installer=20
Dec 31 16:11:39 main-menu[449]: DEBUG: resolver (download-installer): mark=
=20
Dec 31 16:11:39 main-menu[449]: DEBUG: resolver (di-utils-shell): mark=20
Dec 31 16:11:39 main-menu[449]: DEBUG: resolver (di-utils-reboot): mark=20
Dec 31 16:11:39 main-menu[449]: DEBUG: Menu item 'kbd-chooser' selected=20
Dec 31 16:11:39 main-menu[449]: DEBUG: configure kbd-chooser, status: 2 =20
Dec 31 16:11:39 main-menu[449]: DEBUG: configure libc6, status: 0 =20
Dec 31 16:11:39 main-menu[449]: DEBUG: configure libdebconfclient0, status:=
 0 =20
Dec 31 16:11:39 main-menu[449]: DEBUG: virtual package libdebconfclient0 =
=20
Dec 31 16:11:39 main-menu[449]: INFO: Falling back to the package descripti=
on for libdebconfclient0-udeb=20
Dec 31 16:11:39 main-menu[449]: INFO: Falling back to the package descripti=
on for libdebconfclient0-udeb=20
Dec 31 16:11:39 main-menu[449]: DEBUG: configure libdebconfclient0-udeb, st=
atus: 2 =20
Dec 31 16:11:39 main-menu[449]: DEBUG: configure libc6, status: 0 =20
Dec 31 16:11:39 main-menu[449]: DEBUG: configure libdebian-installer4, stat=
us: 0 =20
Dec 31 16:11:39 main-menu[449]: DEBUG: virtual package libdebian-installer4=
 =20
Dec 31 16:11:39 main-menu[449]: DEBUG: configure console-keymaps, status: 0=
 =20
Dec 31 16:11:39 main-menu[449]: DEBUG: virtual package console-keymaps =20
Dec 31 16:11:39 main-menu[449]: INFO: Falling back to the package descripti=
on for console-keymaps-usb=20
Dec 31 16:11:39 main-menu[449]: INFO: Falling back to the package descripti=
on for console-keymaps-at=20
Dec 31 16:11:39 main-menu[449]: INFO: Falling back to the package descripti=
on for console-keymaps-usb=20
Dec 31 16:11:39 main-menu[449]: DEBUG: configure console-keymaps-usb, statu=
s: 2 =20
Dec 31 16:11:39 main-menu[449]: INFO: Falling back to the package descripti=
on for console-keymaps-at=20
Dec 31 16:11:39 main-menu[449]: DEBUG: configure console-keymaps-at, status=
: 2 =20
Dec 31 16:11:39 main-menu[449]: DEBUG: configure archdetect, status: 2 =20
Dec 31 16:11:39 kbd-chooser[611]: INFO: Setting debian-installer/serial-con=
sole to true=20
Dec 31 16:11:39 kbd-chooser[611]: DEBUG: Mounting usbdevfs to look for kbd =
=20
Dec 31 16:11:39 kbd-chooser[611]: DEBUG: Failed to open /proc/bus/usb/devic=
es: 2 =20
Dec 31 16:11:39 kbd-chooser[611]: DEBUG: Adding generic entry for USB keyma=
ps =20
Dec 31 16:11:39 kbd-chooser[611]: INFO: keyboard type at: present: false  =
=20
Dec 31 16:11:39 kbd-chooser[611]: INFO: keyboard type usb: present: unknown=
   =20
Dec 31 16:11:39 kbd-chooser[611]: INFO: Setting debian-installer/serial-con=
sole to true=20
Dec 31 16:11:39 kbd-chooser[611]: INFO: Setting debian-installer/uml-consol=
e to false=20
Dec 31 16:11:39 kbd-chooser[611]: INFO: kbd-chooser: not setting keymap (kb=
d =3D=3D none selected)=20
Dec 31 16:11:40 main-menu[449]: DEBUG: resolver (libc6): package doesn't ex=
ist (ignored)=20
Dec 31 16:11:40 main-menu[449]: DEBUG: resolver (libdebian-installer4): sea=
rch, dependency from cdebconf-udeb=20
Dec 31 16:11:40 main-menu[449]: DEBUG: resolver (libdebian-installer4-udeb)=
: mark, dependency from cdebconf-udeb=20
Dec 31 16:11:40 main-menu[449]: DEBUG: resolver (libtextwrap1): package doe=
sn't exist (ignored)=20
Dec 31 16:11:40 main-menu[449]: DEBUG: resolver (cdebconf-udeb): mark, depe=
ndency from languagechooser=20
Dec 31 16:11:40 main-menu[449]: DEBUG: resolver (languagechooser): mark=20
Dec 31 16:11:40 main-menu[449]: DEBUG: resolver (iso-3166-udeb): mark, depe=
ndency from countrychooser=20
Dec 31 16:11:40 main-menu[449]: DEBUG: resolver (countrychooser): mark=20
Dec 31 16:11:40 main-menu[449]: DEBUG: resolver (libdebconfclient0): search=
, dependency from kbd-chooser=20
Dec 31 16:11:40 main-menu[449]: DEBUG: resolver (libdebconfclient0-udeb): m=
ark, dependency from kbd-chooser=20
Dec 31 16:11:40 main-menu[449]: DEBUG: resolver (console-keymaps): search, =
dependency from kbd-chooser=20
Dec 31 16:11:40 main-menu[449]: DEBUG: resolver (console-keymaps-usb): mark=
, dependency from kbd-chooser=20
Dec 31 16:11:40 main-menu[449]: DEBUG: resolver (archdetect): mark, depende=
ncy from kbd-chooser=20
Dec 31 16:11:40 main-menu[449]: DEBUG: resolver (kbd-chooser): mark=20
Dec 31 16:11:40 main-menu[449]: DEBUG: resolver (discover): search, depende=
ncy from hw-detect=20
Dec 31 16:11:40 main-menu[449]: DEBUG: resolver (libdiscover1): package doe=
sn't exist (ignored)=20
Dec 31 16:11:40 main-menu[449]: DEBUG: resolver (discover1-data-udeb): mark=
, dependency from discover1-udeb=20
Dec 31 16:11:40 main-menu[449]: DEBUG: resolver (discover1-udeb): mark, dep=
endency from hw-detect=20
Dec 31 16:11:40 main-menu[449]: DEBUG: resolver (rootskel): mark, dependenc=
y from hw-detect=20
Dec 31 16:11:40 main-menu[449]: DEBUG: resolver (hw-detect): mark, dependen=
cy from ethdetect=20
Dec 31 16:11:40 main-menu[449]: DEBUG: resolver (ethdetect): mark=20
Dec 31 16:11:40 main-menu[449]: DEBUG: resolver (libiw27): search, dependen=
cy from netcfg=20
Dec 31 16:11:40 main-menu[449]: DEBUG: resolver (libiw27-udeb): mark, depen=
dency from netcfg=20
Dec 31 16:11:40 main-menu[449]: DEBUG: resolver (dhcp-client-udeb): mark, d=
ependency from netcfg=20
Dec 31 16:11:40 main-menu[449]: DEBUG: resolver (ethernet-card-detection): =
search, dependency from netcfg=20
Dec 31 16:11:40 main-menu[449]: DEBUG: resolver (netcfg): mark=20
Dec 31 16:11:40 main-menu[449]: DEBUG: resolver (configured-network): searc=
h, dependency from network-preseed=20
Dec 31 16:11:40 main-menu[449]: DEBUG: resolver (di-utils): mark, dependenc=
y from network-preseed=20
Dec 31 16:11:40 main-menu[449]: DEBUG: resolver (network-preseed): mark=20
Dec 31 16:11:40 main-menu[449]: DEBUG: resolver (choose-mirror): mark=20
Dec 31 16:11:40 main-menu[449]: DEBUG: resolver (net-retriever): mark, depe=
ndency from download-installer=20
Dec 31 16:11:40 main-menu[449]: DEBUG: resolver (anna): mark, dependency fr=
om download-installer=20
Dec 31 16:11:40 main-menu[449]: DEBUG: resolver (download-installer): mark=
=20
Dec 31 16:11:40 main-menu[449]: DEBUG: resolver (di-utils-shell): mark=20
Dec 31 16:11:40 main-menu[449]: DEBUG: resolver (di-utils-reboot): mark=20
Dec 31 16:11:40 main-menu[449]: DEBUG: Menu item 'ethdetect' selected=20
Dec 31 16:11:40 main-menu[449]: DEBUG: configure ethdetect, status: 2 =20
Dec 31 16:11:40 main-menu[449]: DEBUG: configure hw-detect, status: 2 =20
Dec 31 16:11:40 main-menu[449]: DEBUG: configure discover, status: 0 =20
Dec 31 16:11:40 main-menu[449]: DEBUG: virtual package discover =20
Dec 31 16:11:40 main-menu[449]: INFO: Falling back to the package descripti=
on for discover1-udeb=20
Dec 31 16:11:40 main-menu[449]: INFO: Falling back to the package descripti=
on for discover1-udeb=20
Dec 31 16:11:40 main-menu[449]: DEBUG: configure discover1-udeb, status: 2 =
=20
Dec 31 16:11:40 main-menu[449]: DEBUG: configure libc6, status: 0 =20
Dec 31 16:11:40 main-menu[449]: DEBUG: configure libdiscover1, status: 0 =
=20
Dec 31 16:11:40 main-menu[449]: DEBUG: configure discover1-data-udeb, statu=
s: 2 =20
Dec 31 16:11:40 main-menu[449]: DEBUG: configure rootskel, status: 2 =20
Dec 31 16:11:40 hw-detect: Using discover version 1.
Dec 31 16:11:42 hw-detect: Detecting hardware...
Dec 31 16:11:43 hw-detect: Missing module 'sym53c8xx'.
Dec 31 16:11:43 hw-detect: Missing module 'usb-storage'.
Dec 31 16:11:43 hw-detect: Missing module 'ide-mod'.
Dec 31 16:11:43 hw-detect: Missing module 'ide-probe-mod'.
Dec 31 16:11:44 hw-detect: Missing module 'ide-detect'.
Dec 31 16:11:44 hw-detect: Missing module 'ide-generic'.
Dec 31 16:11:44 hw-detect: Missing module 'ide-floppy'.
Dec 31 16:11:44 hw-detect: Missing module 'ide-disk'.
Dec 31 16:11:44 hw-detect: Missing module 'ide-cd'.
Dec 31 16:11:44 hw-detect: Missing module 'isofs'.
Dec 31 16:11:44 hw-detect: Loading modules...
Dec 31 16:11:44 hw-detect: Detected module 'pcnet32' for 'Advanced Micro De=
vices [AMD] 79c970 [PCnet32 LANCE]'
Dec 31 16:11:44 hw-detect: Trying to load module 'pcnet32'
Dec 31 16:11:45 kernel: pcnet32.c:v1.30i 06.28.2004 tsbogend@alpha.franken.=
de
Dec 31 16:11:45 kernel: PCI: Enabling device 0000:00:0c.0 (0000 -> 0003)
Dec 31 16:11:45 kernel: pcnet32: PCnet/PCI II 79C970A at 0x1020, 00 06 29 b=
a 40 05 assigned IRQ 22.
Dec 31 16:11:45 kernel: divert: allocating divert_blk for eth0
Dec 31 16:11:45 kernel: eth0: registered as PCnet/PCI II 79C970A
Dec 31 16:11:45 kernel: pcnet32: 1 cards_found.
Dec 31 16:11:45 hw-detect: Detected module 'floppy' for 'Linux Floppy'
Dec 31 16:11:45 hw-detect: Trying to load module 'floppy'
Dec 31 16:11:45 kernel: inserting floppy driver for 2.6.8-powerpc
Dec 31 16:11:45 kernel: Using anticipatory io scheduler
Dec 31 16:11:45 kernel: Floppy drive(s): fd0 is 2.88M
Dec 31 16:11:45 kernel: FDC 0 is a National Semiconductor PC87306
Dec 31 16:11:45 kernel: Linux Kernel Card Services
Dec 31 16:11:45 kernel:   options:  [pci] [cardbus] [pm]
Dec 31 16:11:46 hw-detect: Starting PCMCIA services: using yenta_socket ins=
tead of i82365
Dec 31 16:11:46 hw-detect: cardmgr[1075]: no sockets found!
Dec 31 16:11:46 cardmgr[1075]: no sockets found!
Dec 31 16:11:46 hw-detect: done.
Dec 31 16:11:46 hw-detect: Detected discover version 1, installing discover=
1.
Dec 31 16:11:46 hw-detect: Detected hotplug support, installing hotplug.
Dec 31 16:11:47 hw-detect: Missing modules 'sym53c8xx (Symbios Logic Inc. /=
 NCR 53c825), usb-storage (USB storage), ide-mod (Linux IDE driver), ide-pr=
obe-mod (Linux IDE probe driver), ide-detect (Linux IDE detection), ide-gen=
eric (Linux IDE support), ide-floppy (Linux IDE floppy), ide-disk (Linux AT=
A DISK), ide-cd (Linux ATAPI CD-ROM), isofs (Linux ISO 9660 filesystem)
Dec 31 16:11:47 main-menu[449]: (process:625): find: =20
Dec 31 16:11:47 main-menu[449]: (process:625): /proc/device-tree/=20
Dec 31 16:11:47 main-menu[449]: (process:625): : No such file or directory=
=20
Dec 31 16:11:47 main-menu[449]: DEBUG: resolver (libc6): package doesn't ex=
ist (ignored)=20
Dec 31 16:11:47 main-menu[449]: DEBUG: resolver (libdebian-installer4): sea=
rch, dependency from cdebconf-udeb=20
Dec 31 16:11:47 main-menu[449]: DEBUG: resolver (libdebian-installer4-udeb)=
: mark, dependency from cdebconf-udeb=20
Dec 31 16:11:47 main-menu[449]: DEBUG: resolver (libtextwrap1): package doe=
sn't exist (ignored)=20
Dec 31 16:11:47 main-menu[449]: DEBUG: resolver (cdebconf-udeb): mark, depe=
ndency from languagechooser=20
Dec 31 16:11:47 main-menu[449]: DEBUG: resolver (languagechooser): mark=20
Dec 31 16:11:47 main-menu[449]: DEBUG: resolver (iso-3166-udeb): mark, depe=
ndency from countrychooser=20
Dec 31 16:11:47 main-menu[449]: DEBUG: resolver (countrychooser): mark=20
Dec 31 16:11:47 main-menu[449]: DEBUG: resolver (libdebconfclient0): search=
, dependency from kbd-chooser=20
Dec 31 16:11:47 main-menu[449]: DEBUG: resolver (libdebconfclient0-udeb): m=
ark, dependency from kbd-chooser=20
Dec 31 16:11:47 main-menu[449]: DEBUG: resolver (console-keymaps): search, =
dependency from kbd-chooser=20
Dec 31 16:11:47 main-menu[449]: DEBUG: resolver (console-keymaps-usb): mark=
, dependency from kbd-chooser=20
Dec 31 16:11:47 main-menu[449]: DEBUG: resolver (archdetect): mark, depende=
ncy from kbd-chooser=20
Dec 31 16:11:47 main-menu[449]: DEBUG: resolver (kbd-chooser): mark=20
Dec 31 16:11:47 main-menu[449]: DEBUG: resolver (discover): search, depende=
ncy from hw-detect=20
Dec 31 16:11:47 main-menu[449]: DEBUG: resolver (libdiscover1): package doe=
sn't exist (ignored)=20
Dec 31 16:11:47 main-menu[449]: DEBUG: resolver (discover1-data-udeb): mark=
, dependency from discover1-udeb=20
Dec 31 16:11:47 main-menu[449]: DEBUG: resolver (discover1-udeb): mark, dep=
endency from hw-detect=20
Dec 31 16:11:47 main-menu[449]: DEBUG: resolver (rootskel): mark, dependenc=
y from hw-detect=20
Dec 31 16:11:47 main-menu[449]: DEBUG: resolver (hw-detect): mark, dependen=
cy from ethdetect=20
Dec 31 16:11:47 main-menu[449]: DEBUG: resolver (ethdetect): mark=20
Dec 31 16:11:47 main-menu[449]: DEBUG: resolver (libiw27): search, dependen=
cy from netcfg=20
Dec 31 16:11:47 main-menu[449]: DEBUG: resolver (libiw27-udeb): mark, depen=
dency from netcfg=20
Dec 31 16:11:47 main-menu[449]: DEBUG: resolver (dhcp-client-udeb): mark, d=
ependency from netcfg=20
Dec 31 16:11:47 main-menu[449]: DEBUG: resolver (ethernet-card-detection): =
search, dependency from netcfg=20
Dec 31 16:11:47 main-menu[449]: DEBUG: resolver (netcfg): mark=20
Dec 31 16:11:47 main-menu[449]: DEBUG: resolver (configured-network): searc=
h, dependency from network-preseed=20
Dec 31 16:11:47 main-menu[449]: DEBUG: resolver (di-utils): mark, dependenc=
y from network-preseed=20
Dec 31 16:11:47 main-menu[449]: DEBUG: resolver (network-preseed): mark=20
Dec 31 16:11:47 main-menu[449]: DEBUG: resolver (choose-mirror): mark=20
Dec 31 16:11:47 main-menu[449]: DEBUG: resolver (net-retriever): mark, depe=
ndency from download-installer=20
Dec 31 16:11:47 main-menu[449]: DEBUG: resolver (anna): mark, dependency fr=
om download-installer=20
Dec 31 16:11:47 main-menu[449]: DEBUG: resolver (download-installer): mark=
=20
Dec 31 16:11:47 main-menu[449]: DEBUG: resolver (di-utils-shell): mark=20
Dec 31 16:11:47 main-menu[449]: DEBUG: resolver (di-utils-reboot): mark=20
Dec 31 16:11:47 main-menu[449]: DEBUG: Menu item 'netcfg' selected=20
Dec 31 16:11:47 main-menu[449]: DEBUG: configure netcfg, status: 2 =20
Dec 31 16:11:47 main-menu[449]: DEBUG: configure libc6, status: 0 =20
Dec 31 16:11:47 main-menu[449]: DEBUG: configure libdebconfclient0, status:=
 0 =20
Dec 31 16:11:47 main-menu[449]: DEBUG: virtual package libdebconfclient0 =
=20
Dec 31 16:11:47 main-menu[449]: DEBUG: configure libdebian-installer4, stat=
us: 0 =20
Dec 31 16:11:47 main-menu[449]: DEBUG: virtual package libdebian-installer4=
 =20
Dec 31 16:11:47 main-menu[449]: DEBUG: configure libiw27, status: 0 =20
Dec 31 16:11:47 main-menu[449]: DEBUG: virtual package libiw27 =20
Dec 31 16:11:47 main-menu[449]: INFO: Falling back to the package descripti=
on for libiw27-udeb=20
Dec 31 16:11:47 main-menu[449]: INFO: Falling back to the package descripti=
on for libiw27-udeb=20
Dec 31 16:11:47 main-menu[449]: DEBUG: configure libiw27-udeb, status: 2 =
=20
Dec 31 16:11:47 main-menu[449]: DEBUG: configure dhcp-client-udeb, status: =
2 =20
Dec 31 16:11:47 main-menu[449]: DEBUG: configure libc6, status: 0 =20
Dec 31 16:11:47 main-menu[449]: DEBUG: configure ethernet-card-detection, s=
tatus: 0 =20
Dec 31 16:11:47 main-menu[449]: DEBUG: virtual package ethernet-card-detect=
ion =20
Dec 31 16:11:47 kernel: NET: Registered protocol family 17
Dec 31 16:11:47 dhclient: Internet Software Consortium DHCP Client 2.0pl5
Dec 31 16:11:47 dhclient: Copyright 1995, 1996, 1997, 1998, 1999 The Intern=
et Software Consortium.
Dec 31 16:11:47 dhclient: All rights reserved.
Dec 31 16:11:47 dhclient:=20
Dec 31 16:11:47 dhclient: Please contribute if you find this software usefu=
l.
Dec 31 16:11:47 dhclient: For info, please visit http://www.isc.org/dhcp-co=
ntrib.html
Dec 31 16:11:47 dhclient:=20
Dec 31 16:11:48 dhclient: Listening on LPF/eth0/00:06:29:ba:40:05
Dec 31 16:11:48 dhclient: Sending on   LPF/eth0/00:06:29:ba:40:05
Dec 31 16:11:48 dhclient: Sending on   Socket/fallback/fallback-net
Dec 31 16:11:48 dhclient: DHCPDISCOVER on eth0 to 255.255.255.255 port 67 i=
nterval 8
Dec 31 16:11:56 dhclient: DHCPDISCOVER on eth0 to 255.255.255.255 port 67 i=
nterval 15
Dec 31 16:12:11 dhclient: DHCPDISCOVER on eth0 to 255.255.255.255 port 67 i=
nterval 20
Dec 31 16:12:31 dhclient: DHCPDISCOVER on eth0 to 255.255.255.255 port 67 i=
nterval 13
Dec 31 16:12:37 main-menu[449]: (process:1127): Internet Software Consortiu=
m DHCP Client 2.0pl5=20
Dec 31 16:12:37 main-menu[449]: (process:1127): =20
Dec 31 16:12:37 main-menu[449]: (process:1127): Copyright 1995, 1996, 1997,=
 1998, 1999 The Internet Software Consortium.=20
Dec 31 16:12:37 main-menu[449]: (process:1127): =20
Dec 31 16:12:37 main-menu[449]: (process:1127): All rights reserved.=20
Dec 31 16:12:37 main-menu[449]: (process:1127): =20
Dec 31 16:12:37 main-menu[449]: (process:1127): =20
Dec 31 16:12:37 main-menu[449]: (process:1127): Please contribute if you fi=
nd this software useful.=20
Dec 31 16:12:37 main-menu[449]: (process:1127): =20
Dec 31 16:12:37 main-menu[449]: (process:1127): For info, please visit http=
://www.isc.org/dhcp-contrib.html=20
Dec 31 16:12:37 main-menu[449]: (process:1127): =20
Dec 31 16:12:37 main-menu[449]: (process:1127): =20
Dec 31 16:12:37 main-menu[449]: (process:1127): Listening on LPF/eth0/00:06=
:29:ba:40:05=20
Dec 31 16:12:37 main-menu[449]: (process:1127): =20
Dec 31 16:12:37 main-menu[449]: (process:1127): Sending on   LPF/eth0/00:06=
:29:ba:40:05=20
Dec 31 16:12:37 main-menu[449]: (process:1127): Sending on   Socket/fallbac=
k/fallback-net=20
Dec 31 16:12:37 main-menu[449]: (process:1127): DHCPDISCOVER on eth0 to 255=
.255.255.255 port 67 interval 8=20
Dec 31 16:12:37 main-menu[449]: (process:1127): DHCPDISCOVER on eth0 to 255=
.255.255.255 port 67 interval 15=20
Dec 31 16:12:37 main-menu[449]: (process:1127): DHCPDISCOVER on eth0 to 255=
.255.255.255 port 67 interval 20=20
Dec 31 16:12:37 main-menu[449]: (process:1127): DHCPDISCOVER on eth0 to 255=
.255.255.255 port 67 interval 13=20
Dec 31 16:12:37 main-menu[449]: INFO: Menu item 'netcfg' succeeded but requ=
ested to be left unconfigured.=20
Dec 31 16:12:37 main-menu[449]: INFO: Modifying debconf priority limit from=
 'high' to 'medium'=20
Dec 31 16:12:37 debconf: Setting debconf/priority to medium
Dec 31 16:12:37 main-menu[449]: DEBUG: resolver (libc6): package doesn't ex=
ist (ignored)=20
Dec 31 16:12:37 main-menu[449]: DEBUG: resolver (libdebian-installer4): sea=
rch, dependency from cdebconf-udeb=20
Dec 31 16:12:37 main-menu[449]: DEBUG: resolver (libdebian-installer4-udeb)=
: mark, dependency from cdebconf-udeb=20
Dec 31 16:12:37 main-menu[449]: DEBUG: resolver (libtextwrap1): package doe=
sn't exist (ignored)=20
Dec 31 16:12:37 main-menu[449]: DEBUG: resolver (cdebconf-udeb): mark, depe=
ndency from languagechooser=20
Dec 31 16:12:37 main-menu[449]: DEBUG: resolver (languagechooser): mark=20
Dec 31 16:12:37 main-menu[449]: DEBUG: resolver (iso-3166-udeb): mark, depe=
ndency from countrychooser=20
Dec 31 16:12:37 main-menu[449]: DEBUG: resolver (countrychooser): mark=20
Dec 31 16:12:37 main-menu[449]: DEBUG: resolver (libdebconfclient0): search=
, dependency from kbd-chooser=20
Dec 31 16:12:37 main-menu[449]: DEBUG: resolver (libdebconfclient0-udeb): m=
ark, dependency from kbd-chooser=20
Dec 31 16:12:37 main-menu[449]: DEBUG: resolver (console-keymaps): search, =
dependency from kbd-chooser=20
Dec 31 16:12:37 main-menu[449]: DEBUG: resolver (console-keymaps-usb): mark=
, dependency from kbd-chooser=20
Dec 31 16:12:37 main-menu[449]: DEBUG: resolver (archdetect): mark, depende=
ncy from kbd-chooser=20
Dec 31 16:12:37 main-menu[449]: DEBUG: resolver (kbd-chooser): mark=20
Dec 31 16:12:37 main-menu[449]: DEBUG: resolver (discover): search, depende=
ncy from hw-detect=20
Dec 31 16:12:37 main-menu[449]: DEBUG: resolver (libdiscover1): package doe=
sn't exist (ignored)=20
Dec 31 16:12:37 main-menu[449]: DEBUG: resolver (discover1-data-udeb): mark=
, dependency from discover1-udeb=20
Dec 31 16:12:37 main-menu[449]: DEBUG: resolver (discover1-udeb): mark, dep=
endency from hw-detect=20
Dec 31 16:12:37 main-menu[449]: DEBUG: resolver (rootskel): mark, dependenc=
y from hw-detect=20
Dec 31 16:12:37 main-menu[449]: DEBUG: resolver (hw-detect): mark, dependen=
cy from ethdetect=20
Dec 31 16:12:37 main-menu[449]: DEBUG: resolver (ethdetect): mark=20
Dec 31 16:12:37 main-menu[449]: DEBUG: resolver (libiw27): search, dependen=
cy from netcfg=20
Dec 31 16:12:37 main-menu[449]: DEBUG: resolver (libiw27-udeb): mark, depen=
dency from netcfg=20
Dec 31 16:12:37 main-menu[449]: DEBUG: resolver (dhcp-client-udeb): mark, d=
ependency from netcfg=20
Dec 31 16:12:37 main-menu[449]: DEBUG: resolver (ethernet-card-detection): =
search, dependency from netcfg=20
Dec 31 16:12:37 main-menu[449]: DEBUG: resolver (netcfg): mark=20
Dec 31 16:12:37 main-menu[449]: DEBUG: resolver (configured-network): searc=
h, dependency from network-preseed=20
Dec 31 16:12:37 main-menu[449]: DEBUG: resolver (di-utils): mark, dependenc=
y from network-preseed=20
Dec 31 16:12:37 main-menu[449]: DEBUG: resolver (network-preseed): mark=20
Dec 31 16:12:37 main-menu[449]: DEBUG: resolver (choose-mirror): mark=20
Dec 31 16:12:37 main-menu[449]: DEBUG: resolver (net-retriever): mark, depe=
ndency from download-installer=20
Dec 31 16:12:37 main-menu[449]: DEBUG: resolver (anna): mark, dependency fr=
om download-installer=20
Dec 31 16:12:37 main-menu[449]: DEBUG: resolver (download-installer): mark=
=20
Dec 31 16:12:37 main-menu[449]: DEBUG: resolver (di-utils-shell): mark=20
Dec 31 16:12:37 main-menu[449]: DEBUG: resolver (di-utils-reboot): mark=20
Dec 31 16:13:00 main-menu[449]: DEBUG: Menu item 'di-utils-shell' selected=
=20
Dec 31 16:13:00 main-menu[449]: DEBUG: configure di-utils-shell, status: 2 =
=20
Dec 31 16:13:00 main-menu[449]: DEBUG: configure libc6, status: 0 =20
Dec 31 16:13:00 main-menu[449]: DEBUG: configure libdebconfclient0, status:=
 0 =20
Dec 31 16:13:00 main-menu[449]: DEBUG: virtual package libdebconfclient0 =
=20
Dec 31 16:13:00 main-menu[449]: DEBUG: configure libdebian-installer4, stat=
us: 0 =20
Dec 31 16:13:00 main-menu[449]: DEBUG: virtual package libdebian-installer4=
 =20
~ #=20
~ #=20
~ #=20
~ #=20
~ # cat /var/log/messages
insmod /lib/modules/2.6.8-powerpc/kernel/lib/crc32.ko=20
insmod /lib/modules/2.6.8-powerpc/kernel/drivers/net/pcnet32.ko=20
insmod /lib/modules/2.6.8-powerpc/kernel/drivers/block/floppy.ko=20
~ # exit
------=_Part_720_2236249.1104540874883--
