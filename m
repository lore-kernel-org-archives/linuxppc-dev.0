Message-ID: <38AA15EF.34407992@huawei.com.cn>
Date: Wed, 16 Feb 2000 11:13:51 +0800
From: dony <dony.he@huawei.com.cn>
MIME-Version: 1.0
To: sungyeon <sungyeon@cosmo.etri.re.kr>
CC: Ruedi.Hofer@ascom.ch,
        linuxppc-embed <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: initrd question...
References: <0FPX00FFH0XJV5@pmdf-it.hasler.ascom.ch> <38AA0E9C.619E523@huawei.com.cn> <006a01bf7829$d9390c10$5a01a8c0@blue>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>




sungyeon wrote:

> ----- Original Message -----
> From: "dony" <dony.he@huawei.com.cn>
> To: <Ruedi.Hofer@ascom.ch>; "linuxppc-embed"
> <linuxppc-embedded@lists.linuxppc.org>
> Sent: Wednesday, February 16, 2000 11:42 AM
> Subject: initrd question...
>
> >
> > Hello:
> >     Now I want to get my initrd running. I use the ramdisk demo
> "ramdisk.image.gz" under
> > arch/ppc/mbxboot and compile my zvmlinux.initrd.
> >     The target boots correctly at the beginning. It decompresses the
> kernel and runs the kernel and
> > shows the boot messages. When all is done, it begins to mount root
> filesystem (on Ramdisk), and shows
> > the following messages:
> >         RAMDISK:Compressed image found at block 0
> >         VFS:Mounted root (ext2 filesystem)
> >          Freeing unused kernel memory:28k init
> > Then nothing happen.
>
> If your root file system is nfs, and disable BOOTP kernel option
> then nothing happen. like you.
>
> I'v changed root file system from NFS to RAMdisk. and disabled BOOTP.

Yes, I have also done this. But the problem still exists. why?

>
>
> > At this time it should show the shell prompt. But I don't know why it
> didn't show. And I couldnot input
> > any character.
> > Cross-compile environment:
> > [binutils-2.9.1.0.19a        egcs-1.1.2           glibc-2.1(including
> crypt, linuxthreads)]
> > I cross-compile my kernel under the above environment.
> > Any suggestions will be highly appreciated.
> > Thank in advance
> > dony
> >
> >
> >


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
