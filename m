Message-ID: <38B5D3E0.F89E6490@huawei.com.cn>
Date: Fri, 25 Feb 2000 08:59:12 +0800
From: dony <dony.he@huawei.com.cn>
MIME-Version: 1.0
To: Ruedi.Hofer@ascom.ch
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: LinuxPPC2000 on MPC860
References: <0FQF00LG1O1J7P@pmdf-it.hasler.ascom.ch>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>




Ruedi.Hofer@ascom.ch wrote:

> Some further info.
>
> I'm right now using the ramdisk.image.gz from the LinuxPPC-2000-lite cdrom
> as nfs mounted rootdisk. (I installed the ramdisk on the PC)
>
> Like that I get an error message right after the kernel has booted:
>
> >...
> >Looking up port of RPC 100003/2 on 10.1.20.2
> >Looking up port of RPC 100005/1 on 10.1.20.2
> >VFS: Mounted root (NFS filesystem) readonly.
> >Freeing unused kernel memory: 32k init
> >tty_io.c: process 1 (swapper) used obsolete /dev/cua0 - update software to use /dev/ttyS0
>
> I found out that the kernel generates this error message in drivers/char/tty_io.c .
>
> Does someone know what this error message means? How to avoid it?

Hi, Ruedi,

       Check you nfs root file, and make sure that the "/dev/console" is a symbol link to
"/dev/ttyS0", instead of "/dev/cua0" .
      Please tell me if this helps.
      dony


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
