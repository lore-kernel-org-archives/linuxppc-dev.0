Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Reply-To: <acurtis@onz.com>
From: "Allen Curtis" <acurtis@onz.com>
To: "Wolfgang Denk" <wd@denx.de>, "Sangmoon Kim" <dogoil@etinsys.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: File System on 64-bit-bus-width Flash memory 
Date: Tue, 14 May 2002 06:00:02 -0700
Message-ID: <NCBBIINEHIPFGJPLBEIFOEBEDHAA.acurtis@onz.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <20020514111336.A39B411960@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


MTD has support for 64-bit bus. They have not pushed the code the main tree.
Goto www.infradead.org and checkout the CVS tree. (I have not personally
used this code version. I implemented modified MTD myself last December)

> -----Original Message-----
> From: owner-linuxppc-embedded@lists.linuxppc.org
> [mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of Wolfgang
> Denk
> Sent: Tuesday, May 14, 2002 4:14 AM
> To: Sangmoon Kim
> Cc: linuxppc-embedded@lists.linuxppc.org
> Subject: Re: File System on 64-bit-bus-width Flash memory
>
>
>
> In message
> <000b01c1fb37$50751cf0$1a11efcb@industrialDiv.hanasys.co.kr> you wrote:
> >
> > Hi,
> > I want to make a flash file system on a custom MPC755 board
> with a 64-bit (bus width) flash memory.
> > I set CONFIG_MTD_PHYSMAP_BUSWIDTH = 8 at kernel configure, and
> when it boots the following message appears.
> >
> > physmap flash device: 400000 at 7c000000
> > genprobe_new_chip called with unsupported buswidth 8
>
> Seems your MTD drivers are missing support for 64 bit buswidth.
>
> > Is it possible to make a flash file system with a flash memory
> of  64 bit bus width? If possible, what's the method? Please let me know.
>
> We implemented this long ago. See our kernel source tree at
> ftp://ftp.denx.de/pub/LinuxPPC/usr/src/
>
> For example:
>
> ...
> TQM8260 flash bank 0: Using static image partition definition
> Creating 4 MTD partitions on "TQM8260 Bank 0":
> 0x00000000-0x00040000 : "ppcboot"
> 0x00040000-0x00100000 : "kernel"
> 0x00100000-0x00400000 : "initrd"
> 0x00400000-0x00800000 : "jffs"
> ...
>
> Wolfgang Denk
>
> --
> Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
> Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
> There are two ways to write error-free programs. Only the  third  one
> works.
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
