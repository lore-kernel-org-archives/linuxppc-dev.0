Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3AA5808C.4F976328@mvista.com>
Date: Tue, 06 Mar 2001 16:27:56 -0800
From: Matthew Locke <mlocke@mvista.com>
MIME-Version: 1.0
To: kingseft@samsung.co.kr
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [Question] init does not find library files.....
References: <H00002af04a809ff@MHS>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


you are probably missing an important link.  It is in
.../target/opt/hardhat...

Include that link in your ramdisk and it should work fine.

kingseft@samsung.co.kr wrote:
>
>   Thank for your kindful replying for our question about ramdisk.
>
>   Now we installed HardHat Linux CDK and found file system in /targer directory.
>   we follwed all procedures and made ramdisk.gz
>
>   But, when we ran this ramdisk iamge, init didn't found libc.so.6
>   of course, we put this libc.so.6 file into our /lib directory in ramdisk.gz
>   following is our result...
>
>   We need your comments, any comments will help us.. thanks...
>
>   ----------- our experiment result ----------
>
> RAM disk driver initialized: 16 RAM disks of 10240K size
> loop: registered device at major 7
> eth0: CPM ENET Version 0.2, 00:05:27:00:00:01
> RAMDISK: Compressed image found at block 0
> EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended
> VFS: Mounted root (ext2 filesystem).
> Freeing unused kernel memory: 28k in
> init: error in loading shared libraries: libc.so.6: cannot open shared object fi
> le: No such file or directory      <--- Here is our problem!!!
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
