Message-ID: <20021115044425.798.qmail@web8007.mail.in.yahoo.com>
Date: Thu, 14 Nov 2002 20:44:25 -0800 (PST)
From: rekha gvv <rekhagvvc@yahoo.co.in>
Subject: Floating point exception
To: zhongqx <zhongqx@guoguang.com.cn>
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <000601c28c56$4b9d20a0$7301a8c0@zhongqx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


HI,
even i use the same busy box only.
but canu just tell the steps how u created the file
system ....I had built some of the utilities like busy
box.and theni added them in the simple ramdisk image
and also if i try to execute the executable i get the
error after the kernel boots up..:(
*************************************************
ttyS0 on SMC1 at 0x0280, BRG1
block: queued sectors max/low 3912kB/1304kB, 64 slots
per queue
RAMDISK driver initialized: 16 RAM disks of 4096K size
1024 blocksize
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 717k freed
devfs: v0.102 (20000622) Richard Gooch
(rgooch@atnf.csiro.au)
devfs: devfs_debug: 0x0
devfs: boot_options: 0x0
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 512 bind 512)
IP-Config: No network devices available.
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem).
Mounted devfs on /dev
Freeing unused kernel memory: 48k inÿ
bash# cd bin
bash# ls
depmod  ls      sh
bash# depmod
Bad emulation depmod/8
NIP: 3004f000 instruction: 7f454c46 opcode: 1f A: 5 B:
9 C: 11 code: 223 rc: 0
pte @ 0x3004f000:
(0xc02cd300)->(0xc02c013c)-0x002c2881
RPN: 002c2 PP: 2 SPS: 0 SH: 0 CI: 0 v: 1
Kernel VA for NIP c02c2000  pte @ 0xc02c2000: no pmd
Floating point exception
bash#
bash#
*******************************************************
why do i get this floating point exception error ?
is the problem in the compilation or problem in kernel
..

thanks ..bye



--- zhongqx <zhongqx@guoguang.com.cn> wrote:
> I don't use SELF ,I use busybox you can download it
> from it's web.
>
> ----- Original Message -----
> From: "rekha gvv" <rekhagvvc@yahoo.co.in>
> To: "zhongqx" <zhongqx@guoguang.com.cn>
> Sent: Wednesday, November 13, 2002 12:12 PM
> Subject: Re: Hi
>
>
> > Hi,
> > I am using kernel version of 2.4.4 and SELF from
> that
> > denx site ..I have compiled SELF using uclibc ..i
> have
> > got the images but then wheni download it gives
> the
> > kernel panic error:(
> > how do check if they are executables for powerpc
> ...
> > did u use SELF ..or u created your own ramdisk ??
> > bye!
> >
> > --- zhongqx <zhongqx@guoguang.com.cn> wrote:
> > > I also meet this problem before when I used
> version
> > > 2.4.18,and I do not known how to do.
> > > now I am used linux-2.4.4-2002-02-14 ,it is ok
> for
> > > ramdisk.image,so I advise you not to waste
> > > you time if you use linux-2.4.18,you should use
> > > other version such as 2.4.4.
> > > ----- Original Message -----
> > > From: "rekha gvv" <rekhagvvc@yahoo.co.in>
> > > To: <zhongqx@guoguang.com.cn>
> > > Sent: Tuesday, November 12, 2002 8:30 PM
> > > Subject: Hi
> > >
> > >
> > > > HI zhongqx,
> > > > I am facing some problems with the ramdisk
> image
> > > ..
> > > > wheni created my own ramdisk also i faced this
> > > error
> > > > Kernel panic: No init found.  Try passing
> init=
> > > option
> > > > to kernel.
> > > >
> > > > and now after downloading SELF and compiling
> the
> > > > kernel also am facing the same problem ...
> > > >
> > > > I am sure u are much ahead of this problem and
> > > solved
> > > > it ..can u please help regarding this ...
> > > >
> > > > I have used uclibc which is a small library
> > > compared
> > > > to glibc ...
> > > > expecting some hints ..thankyou
> > > >
> > > > Regards
> > > > Rekha.c
> > > >
> > > >
> > > >
> > >
> >
> >
>


Yahoo! Web Hosting - Let the expert host your site
http://webhosting.yahoo.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
