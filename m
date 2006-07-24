Return-Path: <arunkat@gmail.com>
Received: from nz-out-0102.google.com (nz-out-0102.google.com [64.233.162.206])
	by ozlabs.org (Postfix) with ESMTP id 756AA67B5F
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 24 Jul 2006 19:24:20 +1000 (EST)
Received: by nz-out-0102.google.com with SMTP id o1so392382nzf
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 24 Jul 2006 02:24:19 -0700 (PDT)
Message-ID: <edd12c050607240224v28232edfsa12d9649ee4789f3@mail.gmail.com>
Date: Mon, 24 Jul 2006 14:54:19 +0530
From: "Arun Kumar" <arunkat@gmail.com>
To: bwarren@qstreams.com
Subject: Re: problems with mounting JFFS2 using CFI for AM29LV160MT on ppc8245
	k2.4.x
In-Reply-To: <edd12c050607240124gd001d11q77796ab4d13c241b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_71994_10983903.1153733059697"
References: <edd12c050607210756h71bab7f8ve323edf3bf6077c6@mail.gmail.com>
	<1153498817.19682.149.camel@saruman.qstreams.net>
	<edd12c050607240124gd001d11q77796ab4d13c241b@mail.gmail.com>
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

------=_Part_71994_10983903.1153733059697
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Ben ,
Further to my previous mail I have another problem with my busybox
initrd/RAMDISK  system -my ext2 root file system is mounted as root && Read
only .as a result my mknod etc commands always returns ERROR -- root mounte=
d
as read only ?

Any pointers for the same ? to make my RAMDISK read/writable ? so that i ca=
n
check by your method ?

Thanks ,
Arun


On 7/24/06, Arun Kumar <arunkat@gmail.com> wrote:
>
> Hi Ben ,
>
> Thanks for your reply .It was indeed very comrehensive .I am able to
> proceed further But still there is a bit problem .
>
> When I try to mknod physically viz mknod /dev/mtd0 .....
>
> It says the node is readonly .
>
> Can you please point out the problem . I am attaching a dump of the
> console .
>
>
> Linux/PPC load:
> Uncompressing Linux...done.
> Now booting the kernel ....
> Memory BAT mapping: BAT2=3D64Mb, BAT3=3D0Mb, residual: 0Mb
> Linux version 2.4.20_mvl31 ( aks@IIB-A1040829) (gcc version 3.3.1(MontaVi=
sta
> 3.3
> .1-3.0.10.0300532 2003-12-24)) #368 Mon Jul 24 13:02:13 IST 2006
> DBAT0U =3D 0x800001fe
> DBAT0L =3D 0x8000002a
> DBAT1U =3D 0xf0001ffe
> DBAT1L =3D 0xf000002a
> DBAT2U =3D 0xc00007fe
> DBAT2L =3D 0x00000002
> DBAT3U =3D 0xff8001fe
> DBAT3L =3D 0xff80002a
> ET4K Montavista Linux Test Platform
> Port by Agere Systems
> On node 0 totalpages: 16384
> zone(0): 16384 pages.
> zone(1): 0 pages.
> zone(2): 0 pages.
> Kernel command line:
> OpenPIC Version 1.2 (1 CPUs and 14 IRQ sources) at fcf40000
> Calibrating delay loop... 884.73 BogoMIPS
> Memory: 62084k available (1000k kernel code, 356k data, 76k init, 0k
> highmem)
> Dentry cache hash table entries: 8192 (order: 4, 65536 bytes)
> Inode cache hash table entries: 4096 (order: 3, 32768 bytes)
> Mount-cache hash table entries: 1024 (order: 1, 8192 bytes)
> Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
> Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
> POSIX conformance testing by UNIFIX
> PCI: Probing PCI hardware
> Scanning bus 00
> Found 00:00 [1057/0006] 000600 00
> PCI:00:00.0 Resource 0 [00000000-ffffffff] is unassigned
> PCI:00:00.0 Resource 1 [00000000-00000fff] is unassigned
> PCI:00:00.0 Resource 2 [00000000-ffffffff] is unassigned
> Found 00:78 [8086/1013] 000200 00
> PCI:00:0f.0 Resource 6 [00000000-0000ffff] is unassigned
> Found 00:f0 [0700/1107] 000600 00
> Fixups for bus 00
> Bus scan for 00 returning with max=3D00
> PCI: bridge rsrc fc000000..fcc00000 (100), parent c011ddd4
> PCI: bridge rsrc 80000000..fe000000 (200), parent c011ddf0
> PCI:00:0f.0: Resource 0: fdfe0000-fdffffff (f=3D204)
> PCI:00:0f.0: Resource 2: fdfd0000-fdfdffff (f=3D204)
> PCI:00:0f.0: Resource 4: fcbfffc0-fcbfffff (f=3D101)
> PCI:00:1e.0: Resource 0: fc000000-fcffffff (f=3D120c)
> PCI:00:1e.0: Resource 2: fcbffe00-fcbffeff (f=3D101)
> Linux NET4.0 for Linux 2.4
> Based upon Swansea University Computer Society NET3.039
> Initializing RT netlink socket
>
> LSP Revision 1
> Starting kswapd
> Disabling the Out Of Memory Killer
> JFFS2 version 2.1. (C) 2001, 2002 Red Hat, Inc., designed by Axis
> Communications
>  AB.
> Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
> SERIAL_PCI en
> abled
> ttyS00 at 0xfcf04500 (irq =3D 13) is a ST16650
> RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
>
>  AMD_FLASH_INIT called  *aks *
> physmap flash device: 800000 at ff800000 virtual address Number of erase
> regions
> : 4
> Primary Vendor Command Set: 0002 (AMD/Fujitsu Standard)
> Primary Algorithm Table at 0040
> Alternative Vendor Command Set: 0000 (None)
> No Alternate Algorithm Table
> Vcc Minimum: 2.7 V
> Vcc Maximum: 3.6 V
> No Vpp line
> Typical byte/word write timeout: 128 =B5s
> Maximum byte/word write timeout: 256 =B5s
> Full buffer write not supported
> Typical block erase timeout: 1024 ms
> Maximum block erase timeout: 16384 ms
> Chip erase not supported
> Device size: 0x200000 bytes (2 MiB)
> Flash Device Interface description: 0x0002
>   - supports x8 and x16 via BYTE# with asynchronous interface
> Max. bytes in buffer write: 0x1
> Number of Erase Block Regions: 4
>   Erase Region #0: BlockSize 0x4000 bytes, 1 blocks
>   Erase Region #1: BlockSize 0x2000 bytes, 2 blocks
>   Erase Region #2: BlockSize 0x8000 bytes, 1 blocks
>   Erase Region #3: BlockSize 0x10000 bytes, 31 blocks
>  Amd/Fujitsu Extended Query Table v1.3 at 0x0040
> number of CFI chips: 4
>
>  in amdstd_setup 0: offset=3D0x0,size=3D0x10000,blocks=3D1
> 1: offset=3D0x10000,size=3D0x8000,blocks=3D2
> 2: offset=3D0x20000,size=3D0x20000,blocks=3D1
> 3: offset=3D0x40000,size=3D0x40000,blocks=3D31
> 4: offset=3D0x800000,size=3D0x10000,blocks=3D1
> 5: offset=3D0x810000,size=3D0x8000,blocks=3D2
> 6: offset=3D0x820000,size=3D0x20000,blocks=3D1
> 7: offset=3D0x840000,size=3D0x40000,blocks=3D31
> 8: offset=3D0x1000000,size=3D0x10000,blocks=3D1
> 9: offset=3D0x1010000,size=3D0x8000,blocks=3D2
> 10: offset=3D0x1020000,size=3D0x20000,blocks=3D1
> 11: offset=3D0x1040000,size=3D0x40000,blocks=3D31
> 12: offset=3D0x1800000,size=3D0x10000,blocks=3D1
> 13: offset=3D0x1810000,size=3D0x8000,blocks=3D2
> 14: offset=3D0x1820000,size=3D0x20000,blocks=3D1
> 15: offset=3D0x1840000,size=3D0x40000,blocks=3D31
> cfi_cmdset_0002: Disabling fast programming due to code brokenness. aks
> Enabling
> *
>
>
>  in MTD Partitioning <5>No RedBoot partition table detected in
> phys_mapped_flash
>
> Using physmap partition definition
> Creating 3 MTD partitions on "phys_mapped_flash":
> 0x00000000-0x00040000 : "agere-ets0"
> mtd: Giving out device 0 to agere-ets0
> 0x00040000-0x00080000 : "agere-ets1"
> mtd: Giving out device 1 to agere-ets1
> 0x00080000-0x0007fffe : "agere-ets2"
> mtd: partition "agere-ets2" doesn't end on an erase block -- force
> read-only
> mtd: Giving out device 2 to agere-ets2
>
> NET4: Linux TCP/IP 1.0 for NET4.0
> IP Protocols: ICMP, UDP, TCP, IGMP
> IP: routing cache hash table of 512 buckets, 4Kbytes
> TCP: Hash tables configured (established 4096 bind 8192)
> IP-Config: No network devices available.
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> /dev/console mapped to mkdev 5: minor: 1
> RAMDISK: Compressed image found at block 0
> Freeing initrd memory: 1247k freed
> VFS: Mounted root (ext2 filesystem) readonly.
> Freeing unused kernel memory: 76k init
> calling sbin/init
> init started:  BusyBox v1.2.0 (2006.07.12-05:25+0000) multi-call binary
> init started:  BusyBox v1.2.0 (2006.07.12-05:25+0000) multi-call binary
> Starting pid 8, console /dev/ttyS0: '/bin/ash'
>
>
> BusyBox v1.2.0 (2006.07.12-05:25+0000) Built-in shell (ash)
> Enter 'help' for a list of built-in commands.
>
> / $ mknod /dev/mtd0 c 90 0
> mknod: /dev/mtd0: Read-only file system
> / $
>
>
> also can you point out why it is trying to disable the fast programming ?
>
>
> Thanks,
> Arun
>
>
>
> On 7/21/06, Ben Warren < bwarren@qstreams.com> wrote:
> >
> > Hi Arun,
> >
> > On Fri, 2006-07-21 at 20:26 +0530, Arun Kumar wrote:
> > > Hi ,
> > > Can anyone help me in this naive problem ?
> > >
> > Then a naive answer is most fitting...  Turns out that's my specialty.
> >
> > > #
> > > # Memory Technology Devices (MTD)
> > > #
> > > CONFIG_MTD=3Dy
> > > CONFIG_MTD_DEBUG=3Dy
> > > CONFIG_MTD_DEBUG_VERBOSE=3D2
> > > CONFIG_MTD_PARTITIONS=3Dy
> > > CONFIG_MTD_CONCAT=3Dy
> > > CONFIG_MTD_REDBOOT_PARTS=3Dy
> > > CONFIG_MTD_CMDLINE_PARTS=3Dy
> > Probably get rid of REDBOOT if you're not using that bootloader
> > >
> > > #
> > > # User Modules And Translation Layers
> > > #
> > > # CONFIG_MTD_CHAR is not set
> > > # CONFIG_MTD_BLOCK is not set
> > > # CONFIG_MTD_BLOCK_RO is not set
> > > # CONFIG_FTL is not set
> > > # CONFIG_NFTL is not set
> > > # CONFIG_INFTL is not set
> > >
> > You need to enable MTD_CHAR to read/write and MTD_BLOCK to mount
> >
> > > Can any happy soul let me know  :--
> > >
> > > 1)How to mount jffs2 on this flash and also to test mtd->read/write
> > > routines ?
> > Start with the char drivers (/dev/mtd0 etc.).  You'll need one for each
> > partition you want to experiment with.
> > How about creating the nodes manually?
> >
> > mknod /dev/mtd0 c 90 0
> > mknod /dev/mtd1 c 90 2 etc. (minor # increments in 2s)
> >
> > Add a block device for each partition:
> >
> > mknod /dev/mtdblock0 b 31 0
> > mknod /dev/mtdblock1 b 31 1 etc.
> >
> > Once you clean up #3 below, you should be able to read/write the char
> > devices using commands like 'cat', or write a simple user-space app
> > using "open, read, write", etc if you'd rather look at the actual binar=
y
> > data.
> >
> > You can then experiment with mounting the JFFS2.  I recommend booting t=
o
> > an NFS file system then mounting the JFFS2 with something like:
> >
> > mount -t jffs2 /dev/mtdblock5 /mnt/temp    (Use the correct partition)
> >
> > >
> > > 2) Is it ok not to see mtd0.. partions in /dev directory .
> > Pretty sure you'll need these
> > >
> > > 3 ) Where do I register the mtd partitions to get them noticed
> > > here ??
> > Looks like your partitions are already being found, but are probably no=
t
> > set up right.  I don't know if this is a static definition in your boar=
d
> > init code or passed by command line from the bootloader, but it looks
> > like the values don't line up with your device:
> >
> > *********
> > Using physmap partition definition
> > Creating 3 MTD partitions on "phys_mapped_flash":
> > 0x00000000-0x00040000 : "foo-ets0"
> > mtd: Giving out device 0 to foo-ets0
> > 0x00040000-0x001e0000 : "foo-ets1"
> > mtd: partition "agere-ets1" doesn't end on an erase block -- force
> > read-only
> > mtd: Giving out device 1 to foo-ets1
> > 0x001e0000-0x00200000 : "foo-ets2"
> > mtd: partition "foo-ets2" doesn't start on an erase block boundary --
> > force read-only
> > *********
> > -----------------------------------------------------------------------=
---
> >
> > Hopefully this helps you proceed a little bit.
> >
> > regards,
> > Ben
> >
> >
>
>
> --
> Arun Kumar Singh
> Tech Lead.
> Agere India
> Bangalore
>



--=20
Arun Kumar Singh
Tech Lead.
Agere India
Bangalore

------=_Part_71994_10983903.1153733059697
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Ben ,<br>Further to my previous mail I have another problem with my busybox=
 initrd/RAMDISK&nbsp; system -my ext2 root file system is mounted as root &=
amp;&amp; Read only .as a result my mknod etc commands always returns ERROR=
 -- root mounted as read only ?=20
<br><br>Any pointers for the same ? to make my RAMDISK read/writable ? so t=
hat i can check by your method ?<br><br>Thanks ,<br>Arun<br><br><br><div><s=
pan class=3D"gmail_quote">On 7/24/06, <b class=3D"gmail_sendername">Arun Ku=
mar
</b> &lt;<a href=3D"mailto:arunkat@gmail.com">arunkat@gmail.com</a>&gt; wro=
te:</span><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid=
 rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div>Hi=
 Ben ,
<br><br>Thanks for your reply .It was indeed very comrehensive .I am able t=
o proceed further But still there is a bit problem .<br><br>When I try to m=
knod physically viz mknod /dev/mtd0 .....<br><br>It says the node is readon=
ly .
<br><br>Can you please point out the problem . I am attaching a dump of the=
 console .<br><br><br style=3D"font-style: italic; font-family: times new r=
oman,serif; color: rgb(51, 0, 153);"><span style=3D"font-style: italic; fon=
t-family: times new roman,serif; color: rgb(51, 0, 153);">

Linux/PPC load:</span><br style=3D"font-style: italic; font-family: times n=
ew roman,serif; color: rgb(51, 0, 153);"><span style=3D"font-style: italic;=
 font-family: times new roman,serif; color: rgb(51, 0, 153);">Uncompressing=
 Linux...done.
</span><br style=3D"font-style: italic; font-family: times new roman,serif;=
 color: rgb(51, 0, 153);"><span style=3D"font-style: italic; font-family: t=
imes new roman,serif; color: rgb(51, 0, 153);">Now booting the kernel ....
</span>
<br style=3D"font-style: italic; font-family: times new roman,serif; color:=
 rgb(51, 0, 153);"><span style=3D"font-style: italic; font-family: times ne=
w roman,serif; color: rgb(51, 0, 153);">Memory BAT mapping: BAT2=3D64Mb, BA=
T3=3D0Mb, residual: 0Mb
</span><br style=3D"font-style: italic; font-family: times new roman,serif;=
 color: rgb(51, 0, 153);"><span style=3D"font-style: italic; font-family: t=
imes new roman,serif; color: rgb(51, 0, 153);">Linux version 2.4.20_mvl31 (
aks@IIB-A1040829) (gcc version 3.3.1 (MontaVista 3.3</span><br style=3D"fon=
t-style: italic; font-family: times new roman,serif; color: rgb(51, 0, 153)=
;"><span style=3D"font-style: italic; font-family: times new roman,serif; c=
olor: rgb(51, 0, 153);">

.1-3.0.10.0300532 2003-12-24)) #368 Mon Jul 24 13:02:13 IST 2006</span><br =
style=3D"font-style: italic; font-family: times new roman,serif; color: rgb=
(51, 0, 153);"><span style=3D"font-style: italic; font-family: times new ro=
man,serif; color: rgb(51, 0, 153);">

DBAT0U =3D 0x800001fe</span><br style=3D"font-style: italic; font-family: t=
imes new roman,serif; color: rgb(51, 0, 153);"><span style=3D"font-style: i=
talic; font-family: times new roman,serif; color: rgb(51, 0, 153);">DBAT0L =
=3D 0x8000002a
</span><br style=3D"font-style: italic; font-family: times new roman,serif;=
 color: rgb(51, 0, 153);"><span style=3D"font-style: italic; font-family: t=
imes new roman,serif; color: rgb(51, 0, 153);">DBAT1U =3D 0xf0001ffe</span>=
<br style=3D"font-style: italic; font-family: times new roman,serif; color:=
 rgb(51, 0, 153);">

<span style=3D"font-style: italic; font-family: times new roman,serif; colo=
r: rgb(51, 0, 153);">DBAT1L =3D 0xf000002a</span><br style=3D"font-style: i=
talic; font-family: times new roman,serif; color: rgb(51, 0, 153);"><span s=
tyle=3D"font-style: italic; font-family: times new roman,serif; color: rgb(=
51, 0, 153);">

DBAT2U =3D 0xc00007fe</span><br style=3D"font-style: italic; font-family: t=
imes new roman,serif; color: rgb(51, 0, 153);"><span style=3D"font-style: i=
talic; font-family: times new roman,serif; color: rgb(51, 0, 153);">DBAT2L =
=3D 0x00000002
</span><br style=3D"font-style: italic; font-family: times new roman,serif;=
 color: rgb(51, 0, 153);"><span style=3D"font-style: italic; font-family: t=
imes new roman,serif; color: rgb(51, 0, 153);">DBAT3U =3D 0xff8001fe</span>=
<br style=3D"font-style: italic; font-family: times new roman,serif; color:=
 rgb(51, 0, 153);">

<span style=3D"font-style: italic; font-family: times new roman,serif; colo=
r: rgb(51, 0, 153);">DBAT3L =3D 0xff80002a</span><br style=3D"font-style: i=
talic; font-family: times new roman,serif; color: rgb(51, 0, 153);"><span s=
tyle=3D"font-style: italic; font-family: times new roman,serif; color: rgb(=
51, 0, 153);">

ET4K Montavista Linux Test Platform</span><br style=3D"font-style: italic; =
font-family: times new roman,serif; color: rgb(51, 0, 153);"><span style=3D=
"font-style: italic; font-family: times new roman,serif; color: rgb(51, 0, =
153);">

Port by Agere Systems</span><br style=3D"font-style: italic; font-family: t=
imes new roman,serif; color: rgb(51, 0, 153);"><span style=3D"font-style: i=
talic; font-family: times new roman,serif; color: rgb(51, 0, 153);">On node=
 0 totalpages: 16384
</span><br style=3D"font-style: italic; font-family: times new roman,serif;=
 color: rgb(51, 0, 153);"><span style=3D"font-style: italic; font-family: t=
imes new roman,serif; color: rgb(51, 0, 153);">zone(0): 16384 pages.</span>

<br style=3D"font-style: italic; font-family: times new roman,serif; color:=
 rgb(51, 0, 153);"><span style=3D"font-style: italic; font-family: times ne=
w roman,serif; color: rgb(51, 0, 153);">zone(1): 0 pages.</span><br style=
=3D"font-style: italic; font-family: times new roman,serif; color: rgb(51, =
0, 153);">

<span style=3D"font-style: italic; font-family: times new roman,serif; colo=
r: rgb(51, 0, 153);">zone(2): 0 pages.</span><br style=3D"font-style: itali=
c; font-family: times new roman,serif; color: rgb(51, 0, 153);"><span style=
=3D"font-style: italic; font-family: times new roman,serif; color: rgb(51, =
0, 153);">

Kernel command line:</span><br style=3D"font-style: italic; font-family: ti=
mes new roman,serif; color: rgb(51, 0, 153);"><span style=3D"font-style: it=
alic; font-family: times new roman,serif; color: rgb(51, 0, 153);">OpenPIC =
Version=20
1.2 (1 CPUs and 14 IRQ sources) at fcf40000</span><br style=3D"font-style: =
italic; font-family: times new roman,serif; color: rgb(51, 0, 153);"><span =
style=3D"font-style: italic; font-family: times new roman,serif; color: rgb=
(51, 0, 153);">

Calibrating delay loop... 884.73 BogoMIPS</span><br style=3D"font-style: it=
alic; font-family: times new roman,serif; color: rgb(51, 0, 153);"><span st=
yle=3D"font-style: italic; font-family: times new roman,serif; color: rgb(5=
1, 0, 153);">

Memory: 62084k available (1000k kernel code, 356k data, 76k init, 0k highme=
m)</span><br style=3D"font-style: italic; font-family: times new roman,seri=
f; color: rgb(51, 0, 153);"><span style=3D"font-style: italic; font-family:=
 times new roman,serif; color: rgb(51, 0, 153);">

Dentry cache hash table entries: 8192 (order: 4, 65536 bytes)</span><br sty=
le=3D"font-style: italic; font-family: times new roman,serif; color: rgb(51=
, 0, 153);"><span style=3D"font-style: italic; font-family: times new roman=
,serif; color: rgb(51, 0, 153);">

Inode cache hash table entries: 4096 (order: 3, 32768 bytes)</span><br styl=
e=3D"font-style: italic; font-family: times new roman,serif; color: rgb(51,=
 0, 153);"><span style=3D"font-style: italic; font-family: times new roman,=
serif; color: rgb(51, 0, 153);">

Mount-cache hash table entries: 1024 (order: 1, 8192 bytes)</span><br style=
=3D"font-style: italic; font-family: times new roman,serif; color: rgb(51, =
0, 153);"><span style=3D"font-style: italic; font-family: times new roman,s=
erif; color: rgb(51, 0, 153);">

Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)</span><br sty=
le=3D"font-style: italic; font-family: times new roman,serif; color: rgb(51=
, 0, 153);"><span style=3D"font-style: italic; font-family: times new roman=
,serif; color: rgb(51, 0, 153);">

Page-cache hash table entries: 16384 (order: 4, 65536 bytes)</span><br styl=
e=3D"font-style: italic; font-family: times new roman,serif; color: rgb(51,=
 0, 153);"><span style=3D"font-style: italic; font-family: times new roman,=
serif; color: rgb(51, 0, 153);">

POSIX conformance testing by UNIFIX</span><br style=3D"font-style: italic; =
font-family: times new roman,serif; color: rgb(51, 0, 153);"><span style=3D=
"font-style: italic; font-family: times new roman,serif; color: rgb(51, 0, =
153);">

PCI: Probing PCI hardware</span><br style=3D"font-style: italic; font-famil=
y: times new roman,serif; color: rgb(51, 0, 153);"><span style=3D"font-styl=
e: italic; font-family: times new roman,serif; color: rgb(51, 0, 153);">Sca=
nning bus 00
</span><br style=3D"font-style: italic; font-family: times new roman,serif;=
 color: rgb(51, 0, 153);"><span style=3D"font-style: italic; font-family: t=
imes new roman,serif; color: rgb(51, 0, 153);">Found 00:00 [1057/0006] 0006=
00 00
</span><br style=3D"font-style: italic; font-family: times new roman,serif;=
 color: rgb(51, 0, 153);"><span style=3D"font-style: italic; font-family: t=
imes new roman,serif; color: rgb(51, 0, 153);">PCI:00:00.0 Resource 0 [0000=
0000-ffffffff] is unassigned
</span><br style=3D"font-style: italic; font-family: times new roman,serif;=
 color: rgb(51, 0, 153);"><span style=3D"font-style: italic; font-family: t=
imes new roman,serif; color: rgb(51, 0, 153);">PCI:00:00.0 Resource 1 [0000=
0000-00000fff] is unassigned
</span><br style=3D"font-style: italic; font-family: times new roman,serif;=
 color: rgb(51, 0, 153);"><span style=3D"font-style: italic; font-family: t=
imes new roman,serif; color: rgb(51, 0, 153);">PCI:00:00.0 Resource 2 [0000=
0000-ffffffff] is unassigned
</span><br style=3D"font-style: italic; font-family: times new roman,serif;=
 color: rgb(51, 0, 153);"><span style=3D"font-style: italic; font-family: t=
imes new roman,serif; color: rgb(51, 0, 153);">Found 00:78 [8086/1013] 0002=
00 00
</span><br style=3D"font-style: italic; font-family: times new roman,serif;=
 color: rgb(51, 0, 153);"><span style=3D"font-style: italic; font-family: t=
imes new roman,serif; color: rgb(51, 0, 153);">PCI:00:0f.0 Resource 6 [0000=
0000-0000ffff] is unassigned
</span><br style=3D"font-style: italic; font-family: times new roman,serif;=
 color: rgb(51, 0, 153);"><span style=3D"font-style: italic; font-family: t=
imes new roman,serif; color: rgb(51, 0, 153);">Found 00:f0 [0700/1107] 0006=
00 00
</span><br style=3D"font-style: italic; font-family: times new roman,serif;=
 color: rgb(51, 0, 153);"><span style=3D"font-style: italic; font-family: t=
imes new roman,serif; color: rgb(51, 0, 153);">Fixups for bus 00</span><br =
style=3D"font-style: italic; font-family: times new roman,serif; color: rgb=
(51, 0, 153);">

<span style=3D"font-style: italic; font-family: times new roman,serif; colo=
r: rgb(51, 0, 153);">Bus scan for 00 returning with max=3D00</span><br styl=
e=3D"font-style: italic; font-family: times new roman,serif; color: rgb(51,=
 0, 153);">

<span style=3D"font-style: italic; font-family: times new roman,serif; colo=
r: rgb(51, 0, 153);">PCI: bridge rsrc fc000000..fcc00000 (100), parent c011=
ddd4</span><br style=3D"font-style: italic; font-family: times new roman,se=
rif; color: rgb(51, 0, 153);">

<span style=3D"font-style: italic; font-family: times new roman,serif; colo=
r: rgb(51, 0, 153);">PCI: bridge rsrc 80000000..fe000000 (200), parent c011=
ddf0</span><br style=3D"font-style: italic; font-family: times new roman,se=
rif; color: rgb(51, 0, 153);">

<span style=3D"font-style: italic; font-family: times new roman,serif; colo=
r: rgb(51, 0, 153);">PCI:00:0f.0: Resource 0: fdfe0000-fdffffff (f=3D204)</=
span><br style=3D"font-style: italic; font-family: times new roman,serif; c=
olor: rgb(51, 0, 153);">

<span style=3D"font-style: italic; font-family: times new roman,serif; colo=
r: rgb(51, 0, 153);">PCI:00:0f.0: Resource 2: fdfd0000-fdfdffff (f=3D204)</=
span><br style=3D"font-style: italic; font-family: times new roman,serif; c=
olor: rgb(51, 0, 153);">

<span style=3D"font-style: italic; font-family: times new roman,serif; colo=
r: rgb(51, 0, 153);">PCI:00:0f.0: Resource 4: fcbfffc0-fcbfffff (f=3D101)</=
span><br style=3D"font-style: italic; font-family: times new roman,serif; c=
olor: rgb(51, 0, 153);">

<span style=3D"font-style: italic; font-family: times new roman,serif; colo=
r: rgb(51, 0, 153);">PCI:00:1e.0: Resource 0: fc000000-fcffffff (f=3D120c)<=
/span><br style=3D"font-style: italic; font-family: times new roman,serif; =
color: rgb(51, 0, 153);">

<span style=3D"font-style: italic; font-family: times new roman,serif; colo=
r: rgb(51, 0, 153);">PCI:00:1e.0: Resource 2: fcbffe00-fcbffeff (f=3D101)</=
span><br style=3D"font-style: italic; font-family: times new roman,serif; c=
olor: rgb(51, 0, 153);">

<span style=3D"font-style: italic; font-family: times new roman,serif; colo=
r: rgb(51, 0, 153);">Linux NET4.0 for Linux 2.4</span><br style=3D"font-sty=
le: italic; font-family: times new roman,serif; color: rgb(51, 0, 153);"><s=
pan style=3D"font-style: italic; font-family: times new roman,serif; color:=
 rgb(51, 0, 153);">

Based upon Swansea University Computer Society NET3.039</span><br style=3D"=
font-style: italic; font-family: times new roman,serif; color: rgb(51, 0, 1=
53);"><span style=3D"font-style: italic; font-family: times new roman,serif=
; color: rgb(51, 0, 153);">

Initializing RT netlink socket</span></div><div><span class=3D"e" id=3D"q_1=
0c9fa2ce2fa3827_1"><br style=3D"font-style: italic; font-family: times new =
roman,serif; color: rgb(51, 0, 153);"><span style=3D"font-style: italic; fo=
nt-family: times new roman,serif; color: rgb(51, 0, 153);">

LSP Revision 1</span><br style=3D"font-style: italic; font-family: times ne=
w roman,serif; color: rgb(51, 0, 153);"><span style=3D"font-style: italic; =
font-family: times new roman,serif; color: rgb(51, 0, 153);">Starting kswap=
d
</span><br style=3D"font-style: italic; font-family: times new roman,serif;=
 color: rgb(51, 0, 153);"><span style=3D"font-style: italic; font-family: t=
imes new roman,serif; color: rgb(51, 0, 153);">Disabling the Out Of Memory =
Killer
</span><br style=3D"font-style: italic; font-family: times new roman,serif;=
 color: rgb(51, 0, 153);"><span style=3D"font-style: italic; font-family: t=
imes new roman,serif; color: rgb(51, 0, 153);">JFFS2 version 2.1. (C) 2001,=
 2002 Red Hat, Inc., designed by Axis Communications
</span><br style=3D"font-style: italic; font-family: times new roman,serif;=
 color: rgb(51, 0, 153);"><span style=3D"font-style: italic; font-family: t=
imes new roman,serif; color: rgb(51, 0, 153);">&nbsp;AB.</span><br style=3D=
"font-style: italic; font-family: times new roman,serif; color: rgb(51, 0, =
153);">

<span style=3D"font-style: italic; font-family: times new roman,serif; colo=
r: rgb(51, 0, 153);">Serial driver version 5.05c (2001-07-08) with MANY_POR=
TS SHARE_IRQ SERIAL_PCI en</span><br style=3D"font-style: italic; font-fami=
ly: times new roman,serif; color: rgb(51, 0, 153);">

<span style=3D"font-style: italic; font-family: times new roman,serif; colo=
r: rgb(51, 0, 153);">abled</span><br style=3D"font-style: italic; font-fami=
ly: times new roman,serif; color: rgb(51, 0, 153);"><span style=3D"font-sty=
le: italic; font-family: times new roman,serif; color: rgb(51, 0, 153);">

ttyS00 at 0xfcf04500 (irq =3D 13) is a ST16650</span><br style=3D"font-styl=
e: italic; font-family: times new roman,serif; color: rgb(51, 0, 153);"><sp=
an style=3D"font-style: italic; font-family: times new roman,serif; color: =
rgb(51, 0, 153);">

RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize</span=
><br style=3D"font-style: italic; font-family: times new roman,serif; color=
: rgb(51, 0, 153);"><br style=3D"font-style: italic; font-family: times new=
 roman,serif; color: rgb(51, 0, 153);">

<span style=3D"font-style: italic; font-family: times new roman,serif; colo=
r: rgb(51, 0, 153);">&nbsp;AMD_FLASH_INIT called&nbsp; *aks *</span><br sty=
le=3D"font-style: italic; font-family: times new roman,serif; color: rgb(51=
, 0, 153);">

<span style=3D"font-style: italic; font-family: times new roman,serif; colo=
r: rgb(51, 0, 153);">physmap flash device: 800000 at ff800000 virtual addre=
ss Number of erase regions</span><br style=3D"font-style: italic; font-fami=
ly: times new roman,serif; color: rgb(51, 0, 153);">

<span style=3D"font-style: italic; font-family: times new roman,serif; colo=
r: rgb(51, 0, 153);">: 4</span><br style=3D"font-style: italic; font-family=
: times new roman,serif; color: rgb(51, 0, 153);"><span style=3D"font-style=
: italic; font-family: times new roman,serif; color: rgb(51, 0, 153);">

Primary Vendor Command Set: 0002 (AMD/Fujitsu Standard)</span><br style=3D"=
font-style: italic; font-family: times new roman,serif; color: rgb(51, 0, 1=
53);"><span style=3D"font-style: italic; font-family: times new roman,serif=
; color: rgb(51, 0, 153);">

Primary Algorithm Table at 0040</span><br style=3D"font-style: italic; font=
-family: times new roman,serif; color: rgb(51, 0, 153);"><span style=3D"fon=
t-style: italic; font-family: times new roman,serif; color: rgb(51, 0, 153)=
;">

Alternative Vendor Command Set: 0000 (None)</span><br style=3D"font-style: =
italic; font-family: times new roman,serif; color: rgb(51, 0, 153);"><span =
style=3D"font-style: italic; font-family: times new roman,serif; color: rgb=
(51, 0, 153);">

No Alternate Algorithm Table</span><br style=3D"font-style: italic; font-fa=
mily: times new roman,serif; color: rgb(51, 0, 153);"><span style=3D"font-s=
tyle: italic; font-family: times new roman,serif; color: rgb(51, 0, 153);">

Vcc Minimum: 2.7 V</span><br style=3D"font-style: italic; font-family: time=
s new roman,serif; color: rgb(51, 0, 153);"><span style=3D"font-style: ital=
ic; font-family: times new roman,serif; color: rgb(51, 0, 153);">Vcc Maximu=
m:=20
3.6 V</span><br style=3D"font-style: italic; font-family: times new roman,s=
erif; color: rgb(51, 0, 153);"><span style=3D"font-style: italic; font-fami=
ly: times new roman,serif; color: rgb(51, 0, 153);">No Vpp line</span><br s=
tyle=3D"font-style: italic; font-family: times new roman,serif; color: rgb(=
51, 0, 153);">

<span style=3D"font-style: italic; font-family: times new roman,serif; colo=
r: rgb(51, 0, 153);">Typical byte/word write timeout: 128 =B5s</span><br st=
yle=3D"font-style: italic; font-family: times new roman,serif; color: rgb(5=
1, 0, 153);">

<span style=3D"font-style: italic; font-family: times new roman,serif; colo=
r: rgb(51, 0, 153);">Maximum byte/word write timeout: 256 =B5s</span><br st=
yle=3D"font-style: italic; font-family: times new roman,serif; color: rgb(5=
1, 0, 153);">

<span style=3D"font-style: italic; font-family: times new roman,serif; colo=
r: rgb(51, 0, 153);">Full buffer write not supported</span><br style=3D"fon=
t-style: italic; font-family: times new roman,serif; color: rgb(51, 0, 153)=
;">

<span style=3D"font-style: italic; font-family: times new roman,serif; colo=
r: rgb(51, 0, 153);">Typical block erase timeout: 1024 ms</span><br style=
=3D"font-style: italic; font-family: times new roman,serif; color: rgb(51, =
0, 153);">

<span style=3D"font-style: italic; font-family: times new roman,serif; colo=
r: rgb(51, 0, 153);">Maximum block erase timeout: 16384 ms</span><br style=
=3D"font-style: italic; font-family: times new roman,serif; color: rgb(51, =
0, 153);">

<span style=3D"font-style: italic; font-family: times new roman,serif; colo=
r: rgb(51, 0, 153);">Chip erase not supported</span><br style=3D"font-style=
: italic; font-family: times new roman,serif; color: rgb(51, 0, 153);"><spa=
n style=3D"font-style: italic; font-family: times new roman,serif; color: r=
gb(51, 0, 153);">

Device size: 0x200000 bytes (2 MiB)</span><br style=3D"font-style: italic; =
font-family: times new roman,serif; color: rgb(51, 0, 153);"><span style=3D=
"font-style: italic; font-family: times new roman,serif; color: rgb(51, 0, =
153);">

Flash Device Interface description: 0x0002</span><br style=3D"font-style: i=
talic; font-family: times new roman,serif; color: rgb(51, 0, 153);"><span s=
tyle=3D"font-style: italic; font-family: times new roman,serif; color: rgb(=
51, 0, 153);">

&nbsp; - supports x8 and x16 via BYTE# with asynchronous interface</span><b=
r style=3D"font-style: italic; font-family: times new roman,serif; color: r=
gb(51, 0, 153);"><span style=3D"font-style: italic; font-family: times new =
roman,serif; color: rgb(51, 0, 153);">

Max. bytes in buffer write: 0x1</span><br style=3D"font-style: italic; font=
-family: times new roman,serif; color: rgb(51, 0, 153);"><span style=3D"fon=
t-style: italic; font-family: times new roman,serif; color: rgb(51, 0, 153)=
;">

Number of Erase Block Regions: 4</span><br style=3D"font-style: italic; fon=
t-family: times new roman,serif; color: rgb(51, 0, 153);"><span style=3D"fo=
nt-style: italic; font-family: times new roman,serif; color: rgb(51, 0, 153=
);">

&nbsp; Erase Region #0: BlockSize 0x4000 bytes, 1 blocks</span><br style=3D=
"font-style: italic; font-family: times new roman,serif; color: rgb(51, 0, =
153);"><span style=3D"font-style: italic; font-family: times new roman,seri=
f; color: rgb(51, 0, 153);">

&nbsp; Erase Region #1: BlockSize 0x2000 bytes, 2 blocks</span><br style=3D=
"font-style: italic; font-family: times new roman,serif; color: rgb(51, 0, =
153);"><span style=3D"font-style: italic; font-family: times new roman,seri=
f; color: rgb(51, 0, 153);">

&nbsp; Erase Region #2: BlockSize 0x8000 bytes, 1 blocks</span><br style=3D=
"font-style: italic; font-family: times new roman,serif; color: rgb(51, 0, =
153);"><span style=3D"font-style: italic; font-family: times new roman,seri=
f; color: rgb(51, 0, 153);">

&nbsp; Erase Region #3: BlockSize 0x10000 bytes, 31 blocks</span><br style=
=3D"font-style: italic; font-family: times new roman,serif; color: rgb(51, =
0, 153);"><span style=3D"font-style: italic; font-family: times new roman,s=
erif; color: rgb(51, 0, 153);">

&nbsp;Amd/Fujitsu Extended Query Table v1.3 at 0x0040</span><br style=3D"fo=
nt-style: italic; font-family: times new roman,serif; color: rgb(51, 0, 153=
);"><span style=3D"font-style: italic; font-family: times new roman,serif; =
color: rgb(51, 0, 153);">

number of CFI chips: 4</span><br style=3D"font-style: italic; font-family: =
times new roman,serif; color: rgb(51, 0, 153);"><br style=3D"font-style: it=
alic; font-family: times new roman,serif; color: rgb(51, 0, 153);"></span>
</div><div><span style=3D"font-style: italic; font-family: times new roman,=
serif; color: rgb(51, 0, 153);">
&nbsp;in amdstd_setup 0: offset=3D0x0,size=3D0x10000,blocks=3D1</span><br s=
tyle=3D"font-style: italic; font-family: times new roman,serif; color: rgb(=
51, 0, 153);"><span style=3D"font-style: italic; font-family: times new rom=
an,serif; color: rgb(51, 0, 153);">

1: offset=3D0x10000,size=3D0x8000,blocks=3D2</span><br style=3D"font-style:=
 italic; font-family: times new roman,serif; color: rgb(51, 0, 153);"><span=
 style=3D"font-style: italic; font-family: times new roman,serif; color: rg=
b(51, 0, 153);">

2: offset=3D0x20000,size=3D0x20000,blocks=3D1</span><br style=3D"font-style=
: italic; font-family: times new roman,serif; color: rgb(51, 0, 153);"><spa=
n style=3D"font-style: italic; font-family: times new roman,serif; color: r=
gb(51, 0, 153);">

3: offset=3D0x40000,size=3D0x40000,blocks=3D31</span><br style=3D"font-styl=
e: italic; font-family: times new roman,serif; color: rgb(51, 0, 153);"><sp=
an style=3D"font-style: italic; font-family: times new roman,serif; color: =
rgb(51, 0, 153);">

4: offset=3D0x800000,size=3D0x10000,blocks=3D1</span><br style=3D"font-styl=
e: italic; font-family: times new roman,serif; color: rgb(51, 0, 153);"><sp=
an style=3D"font-style: italic; font-family: times new roman,serif; color: =
rgb(51, 0, 153);">

5: offset=3D0x810000,size=3D0x8000,blocks=3D2</span><br style=3D"font-style=
: italic; font-family: times new roman,serif; color: rgb(51, 0, 153);"><spa=
n style=3D"font-style: italic; font-family: times new roman,serif; color: r=
gb(51, 0, 153);">

6: offset=3D0x820000,size=3D0x20000,blocks=3D1</span><br style=3D"font-styl=
e: italic; font-family: times new roman,serif; color: rgb(51, 0, 153);"><sp=
an style=3D"font-style: italic; font-family: times new roman,serif; color: =
rgb(51, 0, 153);">

7: offset=3D0x840000,size=3D0x40000,blocks=3D31</span><br style=3D"font-sty=
le: italic; font-family: times new roman,serif; color: rgb(51, 0, 153);"><s=
pan style=3D"font-style: italic; font-family: times new roman,serif; color:=
 rgb(51, 0, 153);">

8: offset=3D0x1000000,size=3D0x10000,blocks=3D1</span><br style=3D"font-sty=
le: italic; font-family: times new roman,serif; color: rgb(51, 0, 153);"><s=
pan style=3D"font-style: italic; font-family: times new roman,serif; color:=
 rgb(51, 0, 153);">

9: offset=3D0x1010000,size=3D0x8000,blocks=3D2</span><br style=3D"font-styl=
e: italic; font-family: times new roman,serif; color: rgb(51, 0, 153);"><sp=
an style=3D"font-style: italic; font-family: times new roman,serif; color: =
rgb(51, 0, 153);">

10: offset=3D0x1020000,size=3D0x20000,blocks=3D1</span><br style=3D"font-st=
yle: italic; font-family: times new roman,serif; color: rgb(51, 0, 153);"><=
span style=3D"font-style: italic; font-family: times new roman,serif; color=
: rgb(51, 0, 153);">

11: offset=3D0x1040000,size=3D0x40000,blocks=3D31</span><br style=3D"font-s=
tyle: italic; font-family: times new roman,serif; color: rgb(51, 0, 153);">=
<span style=3D"font-style: italic; font-family: times new roman,serif; colo=
r: rgb(51, 0, 153);">

12: offset=3D0x1800000,size=3D0x10000,blocks=3D1</span><br style=3D"font-st=
yle: italic; font-family: times new roman,serif; color: rgb(51, 0, 153);"><=
span style=3D"font-style: italic; font-family: times new roman,serif; color=
: rgb(51, 0, 153);">

13: offset=3D0x1810000,size=3D0x8000,blocks=3D2</span><br style=3D"font-sty=
le: italic; font-family: times new roman,serif; color: rgb(51, 0, 153);"><s=
pan style=3D"font-style: italic; font-family: times new roman,serif; color:=
 rgb(51, 0, 153);">

14: offset=3D0x1820000,size=3D0x20000,blocks=3D1</span><br style=3D"font-st=
yle: italic; font-family: times new roman,serif; color: rgb(51, 0, 153);"><=
span style=3D"font-style: italic; font-family: times new roman,serif; color=
: rgb(51, 0, 153);">

15: offset=3D0x1840000,size=3D0x40000,blocks=3D31</span><br style=3D"font-s=
tyle: italic; font-family: times new roman,serif; color: rgb(51, 0, 153);">=
<span style=3D"font-style: italic; font-family: times new roman,serif; colo=
r: rgb(51, 0, 153);">

cfi_cmdset_0002: Disabling fast programming due to code brokenness. aks Ena=
bling</span><br style=3D"font-style: italic; font-family: times new roman,s=
erif; color: rgb(51, 0, 153);"><span style=3D"font-style: italic; font-fami=
ly: times new roman,serif; color: rgb(51, 0, 153);">

*</span></div><div><span class=3D"q"><br style=3D"font-style: italic; font-=
family: times new roman,serif; color: rgb(51, 0, 153);"><br style=3D"font-s=
tyle: italic; font-family: times new roman,serif; color: rgb(51, 0, 153);">=
<span style=3D"font-style: italic; font-family: times new roman,serif; colo=
r: rgb(51, 0, 153);">

&nbsp;in MTD Partitioning &lt;5&gt;No RedBoot partition table detected in p=
hys_mapped_flash</span><br style=3D"font-style: italic; font-family: times =
new roman,serif; color: rgb(51, 0, 153);"><br style=3D"font-style: italic; =
font-family: times new roman,serif; color: rgb(51, 0, 153);">
</span></div><div><span class=3D"q">
<span style=3D"font-style: italic; font-family: times new roman,serif; colo=
r: rgb(51, 0, 153);">Using physmap partition definition</span><br style=3D"=
font-style: italic; font-family: times new roman,serif; color: rgb(51, 0, 1=
53);">

<span style=3D"font-style: italic; font-family: times new roman,serif; colo=
r: rgb(51, 0, 153);">Creating 3 MTD partitions on &quot;phys_mapped_flash&q=
uot;:</span><br style=3D"font-style: italic; font-family: times new roman,s=
erif; color: rgb(51, 0, 153);">
</span></div><div>
<span style=3D"font-style: italic; font-family: times new roman,serif; colo=
r: rgb(51, 0, 153);">0x00000000-0x00040000 : &quot;agere-ets0&quot;</span><=
br style=3D"font-style: italic; font-family: times new roman,serif; color: =
rgb(51, 0, 153);">

<span style=3D"font-style: italic; font-family: times new roman,serif; colo=
r: rgb(51, 0, 153);">mtd: Giving out device 0 to agere-ets0</span><br style=
=3D"font-style: italic; font-family: times new roman,serif; color: rgb(51, =
0, 153);">

<span style=3D"font-style: italic; font-family: times new roman,serif; colo=
r: rgb(51, 0, 153);">0x00040000-0x00080000 : &quot;agere-ets1&quot;</span><=
br style=3D"font-style: italic; font-family: times new roman,serif; color: =
rgb(51, 0, 153);">

<span style=3D"font-style: italic; font-family: times new roman,serif; colo=
r: rgb(51, 0, 153);">mtd: Giving out device 1 to agere-ets1</span><br style=
=3D"font-style: italic; font-family: times new roman,serif; color: rgb(51, =
0, 153);">

<span style=3D"font-style: italic; font-family: times new roman,serif; colo=
r: rgb(51, 0, 153);">0x00080000-0x0007fffe : &quot;agere-ets2&quot;</span><=
br style=3D"font-style: italic; font-family: times new roman,serif; color: =
rgb(51, 0, 153);">

<span style=3D"font-style: italic; font-family: times new roman,serif; colo=
r: rgb(51, 0, 153);">mtd: partition &quot;agere-ets2&quot; doesn't end on a=
n erase block -- force read-only</span><br style=3D"font-style: italic; fon=
t-family: times new roman,serif; color: rgb(51, 0, 153);">

<span style=3D"font-style: italic; font-family: times new roman,serif; colo=
r: rgb(51, 0, 153);">mtd: Giving out device 2 to agere-ets2</span></div><di=
v><span class=3D"q"><br style=3D"font-style: italic; font-family: times new=
 roman,serif; color: rgb(51, 0, 153);">

<span style=3D"font-style: italic; font-family: times new roman,serif; colo=
r: rgb(51, 0, 153);">NET4: Linux TCP/IP 1.0 for NET4.0</span><br style=3D"f=
ont-style: italic; font-family: times new roman,serif; color: rgb(51, 0, 15=
3);">

<span style=3D"font-style: italic; font-family: times new roman,serif; colo=
r: rgb(51, 0, 153);">IP Protocols: ICMP, UDP, TCP, IGMP</span><br style=3D"=
font-style: italic; font-family: times new roman,serif; color: rgb(51, 0, 1=
53);">

<span style=3D"font-style: italic; font-family: times new roman,serif; colo=
r: rgb(51, 0, 153);">IP: routing cache hash table of 512 buckets, 4Kbytes</=
span><br style=3D"font-style: italic; font-family: times new roman,serif; c=
olor: rgb(51, 0, 153);">

<span style=3D"font-style: italic; font-family: times new roman,serif; colo=
r: rgb(51, 0, 153);">TCP: Hash tables configured (established 4096 bind 819=
2)</span><br style=3D"font-style: italic; font-family: times new roman,seri=
f; color: rgb(51, 0, 153);">

<span style=3D"font-style: italic; font-family: times new roman,serif; colo=
r: rgb(51, 0, 153);">IP-Config: No network devices available.</span><br sty=
le=3D"font-style: italic; font-family: times new roman,serif; color: rgb(51=
, 0, 153);">

<span style=3D"font-style: italic; font-family: times new roman,serif; colo=
r: rgb(51, 0, 153);">NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.</s=
pan><br style=3D"font-style: italic; font-family: times new roman,serif; co=
lor: rgb(51, 0, 153);">

<span style=3D"font-style: italic; font-family: times new roman,serif; colo=
r: rgb(51, 0, 153);">/dev/console mapped to mkdev 5: minor: 1</span><br sty=
le=3D"font-style: italic; font-family: times new roman,serif; color: rgb(51=
, 0, 153);">

<span style=3D"font-style: italic; font-family: times new roman,serif; colo=
r: rgb(51, 0, 153);">RAMDISK: Compressed image found at block 0</span><br s=
tyle=3D"font-style: italic; font-family: times new roman,serif; color: rgb(=
51, 0, 153);">

<span style=3D"font-style: italic; font-family: times new roman,serif; colo=
r: rgb(51, 0, 153);">Freeing initrd memory: 1247k freed</span><br style=3D"=
font-style: italic; font-family: times new roman,serif; color: rgb(51, 0, 1=
53);">

<span style=3D"font-style: italic; font-family: times new roman,serif; colo=
r: rgb(51, 0, 153);">VFS: Mounted root (ext2 filesystem) readonly.</span><b=
r style=3D"font-style: italic; font-family: times new roman,serif; color: r=
gb(51, 0, 153);">

<span style=3D"font-style: italic; font-family: times new roman,serif; colo=
r: rgb(51, 0, 153);">Freeing unused kernel memory: 76k init</span><br style=
=3D"font-style: italic; font-family: times new roman,serif; color: rgb(51, =
0, 153);">

<span style=3D"font-style: italic; font-family: times new roman,serif; colo=
r: rgb(51, 0, 153);">calling sbin/init</span><br style=3D"font-style: itali=
c; font-family: times new roman,serif; color: rgb(51, 0, 153);"><span style=
=3D"font-style: italic; font-family: times new roman,serif; color: rgb(51, =
0, 153);">

init started:&nbsp; BusyBox v1.2.0 (2006.07.12-05:25+0000) multi-call binar=
y</span><br style=3D"font-style: italic; font-family: times new roman,serif=
; color: rgb(51, 0, 153);"><span style=3D"font-style: italic; font-family: =
times new roman,serif; color: rgb(51, 0, 153);">

init started:&nbsp; BusyBox v1.2.0 (2006.07.12-05:25+0000) multi-call binar=
y</span><br style=3D"font-style: italic; font-family: times new roman,serif=
; color: rgb(51, 0, 153);"><span style=3D"font-style: italic; font-family: =
times new roman,serif; color: rgb(51, 0, 153);">

Starting pid 8, console /dev/ttyS0: '/bin/ash'</span><br style=3D"font-styl=
e: italic; font-family: times new roman,serif; color: rgb(51, 0, 153);"><br=
 style=3D"font-style: italic; font-family: times new roman,serif; color: rg=
b(51, 0, 153);">

<br style=3D"font-style: italic; font-family: times new roman,serif; color:=
 rgb(51, 0, 153);"></span></div><div><span style=3D"font-style: italic; fon=
t-family: times new roman,serif; color: rgb(51, 0, 153);">BusyBox v1.2.0 (
2006.07.12-05:25+0000) Built-in shell (ash)
</span><br style=3D"font-style: italic; font-family: times new roman,serif;=
 color: rgb(51, 0, 153);"><span style=3D"font-style: italic; font-family: t=
imes new roman,serif; color: rgb(51, 0, 153);">Enter 'help' for a list of b=
uilt-in commands.
</span><br style=3D"font-style: italic; font-family: times new roman,serif;=
 color: rgb(51, 0, 153);"><br style=3D"font-style: italic; font-family: tim=
es new roman,serif; color: rgb(51, 0, 153);"><span style=3D"font-style: ita=
lic; font-family: times new roman,serif; color: rgb(51, 0, 153);">

/ $ mknod /dev/mtd0 c 90 0</span><br style=3D"font-style: italic; font-fami=
ly: times new roman,serif; color: rgb(51, 0, 153);"><span style=3D"font-sty=
le: italic; font-family: times new roman,serif; color: rgb(51, 0, 153);">mk=
nod: /dev/mtd0: Read-only file system
</span><br style=3D"font-style: italic; font-family: times new roman,serif;=
 color: rgb(51, 0, 153);"><span style=3D"font-style: italic; font-family: t=
imes new roman,serif; color: rgb(51, 0, 153);">/ $</span><br style=3D"font-=
style: italic; font-family: times new roman,serif; color: rgb(51, 0, 153);"=
>

<br><br>also can you point out why it is trying to disable the fast program=
ming ?<br><br><br>Thanks,<br>Arun</div><div><span class=3D"e" id=3D"q_10c9f=
a2ce2fa3827_8"><br><br><br><div><span class=3D"gmail_quote">On 7/21/06, <b =
class=3D"gmail_sendername">
Ben Warren</b> &lt;<a href=3D"mailto:bwarren@qstreams.com" title=3D"mailto:=
bwarren@qstreams.com" target=3D"_blank" onclick=3D"return top.js.OpenExtLin=
k(window,event,this)">
bwarren@qstreams.com</a>&gt; wrote:</span><blockquote class=3D"gmail_quote"=
 style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.=
8ex; padding-left: 1ex;">Hi Arun,<br><br>On Fri, 2006-07-21 at 20:26 +0530,=
 Arun Kumar wrote:
<br>&gt; Hi ,<br>&gt; Can anyone help me in this naive problem ?<br>&gt;<br=
>Then a naive answer is most fitting...&nbsp;&nbsp;Turns out that's my spec=
ialty.<br><br>&gt; #<br>&gt; # Memory Technology Devices (MTD)<br>&gt; #<br=
>&gt; CONFIG_MTD=3Dy
<br>&gt; CONFIG_MTD_DEBUG=3Dy<br>&gt; CONFIG_MTD_DEBUG_VERBOSE=3D2<br>&gt; =
CONFIG_MTD_PARTITIONS=3Dy<br>&gt; CONFIG_MTD_CONCAT=3Dy<br>&gt; CONFIG_MTD_=
REDBOOT_PARTS=3Dy<br>&gt; CONFIG_MTD_CMDLINE_PARTS=3Dy<br>Probably get rid =
of REDBOOT if you're not using that bootloader
<br>&gt;<br>&gt; #<br>&gt; # User Modules And Translation Layers<br>&gt; #<=
br>&gt; # CONFIG_MTD_CHAR is not set<br>&gt; # CONFIG_MTD_BLOCK is not set<=
br>&gt; # CONFIG_MTD_BLOCK_RO is not set<br>&gt; # CONFIG_FTL is not set
<br>&gt; # CONFIG_NFTL is not set<br>&gt; # CONFIG_INFTL is not set<br>&gt;=
<br>You need to enable MTD_CHAR to read/write and MTD_BLOCK to mount<br><br=
>&gt; Can any happy soul let me know&nbsp;&nbsp;:--<br>&gt;<br>&gt; 1)How t=
o mount jffs2 on this flash and also to test mtd-&gt;read/write
<br>&gt; routines ?<br>Start with the char drivers (/dev/mtd0 etc.).&nbsp;&=
nbsp;You'll need one for each<br>partition you want to experiment with.<br>=
How about creating the nodes manually?<br><br>mknod /dev/mtd0 c 90 0<br>mkn=
od /dev/mtd1 c 90 2 etc. (minor # increments in 2s)
<br><br>Add a block device for each partition:<br><br>mknod /dev/mtdblock0 =
b 31 0<br>mknod /dev/mtdblock1 b 31 1 etc.<br><br>Once you clean up #3 belo=
w, you should be able to read/write the char<br>devices using commands like=
 'cat', or write a simple user-space app
<br>using &quot;open, read, write&quot;, etc if you'd rather look at the ac=
tual binary<br>data.<br><br>You can then experiment with mounting the JFFS2=
.&nbsp;&nbsp;I recommend booting to<br>an NFS file system then mounting the=
 JFFS2 with something like:
<br><br>mount -t jffs2 /dev/mtdblock5 /mnt/temp&nbsp;&nbsp;&nbsp;&nbsp;(Use=
 the correct partition)<br><br>&gt;<br>&gt; 2) Is it ok not to see mtd0.. p=
artions in /dev directory .<br>Pretty sure you'll need these<br>&gt;<br>&gt=
; 3 ) Where do I register the mtd partitions to get them noticed
<br>&gt; here ??<br>Looks like your partitions are already being found, but=
 are probably not<br>set up right.&nbsp;&nbsp;I don't know if this is a sta=
tic definition in your board<br>init code or passed by command line from th=
e bootloader, but it looks
<br>like the values don't line up with your device:<br><br>*********<br>Usi=
ng physmap partition definition<br>Creating 3 MTD partitions on &quot;phys_=
mapped_flash&quot;:<br>0x00000000-0x00040000 : &quot;foo-ets0&quot;<br>

mtd: Giving out device 0 to foo-ets0<br>0x00040000-0x001e0000 : &quot;foo-e=
ts1&quot;<br>mtd: partition &quot;agere-ets1&quot; doesn't end on an erase =
block -- force<br>read-only<br>mtd: Giving out device 1 to foo-ets1<br>

0x001e0000-0x00200000 : &quot;foo-ets2&quot;<br>mtd: partition &quot;foo-et=
s2&quot; doesn't start on an erase block boundary --<br>force read-only<br>=
*********<br>--------------------------------------------------------------=
------------
<br>Hopefully this helps you proceed a little bit.<br><br>regards,<br>Ben<b=
r><br></blockquote></div><br><br clear=3D"all"><br></span></div><div><span =
class=3D"sg">-- <br>Arun Kumar Singh<br>Tech Lead.<br>Agere India <br>Banga=
lore

</span></div></blockquote></div><br><br clear=3D"all"><br>-- <br>Arun Kumar=
 Singh<br>Tech Lead.<br>Agere India <br>Bangalore

------=_Part_71994_10983903.1153733059697--
