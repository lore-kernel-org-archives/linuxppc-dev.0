Message-ID: <3AB6249E.BCF2855C@ces.ch>
Date: Mon, 19 Mar 2001 16:24:14 +0100
From: Wolfgang Grandegger <wolfgang@ces.ch>
MIME-Version: 1.0
To: Carl Lin <carl@fiberlogic.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Problem about running kernel with root fs
References: <3AB61394.D9CD1DB3@fiberlogic.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Carl Lin wrote:
>
> Please help :
>
> I try to run Linux kernel 2.4.0-test13-pre2 (ramdisk size
> =4096KB and initrd supported) with a root fs (hello.rfs
> from BlueCat) on a board equivalent to TQM855L with the
> following configuration :

As far as I know the BlueCat Root File System (RFS) is not
exactly the same thing than initrd. The RFS is similar to the
one used on LynxOS. On a BlueCat Linux kernel you must set
CONFIG_BLUECAT_RFS (and unset CONFIG_BLK_DEV_INITRD) to enable
the BlutCat RFS kernel extension but I guess the kernel you
use is not from BlueCat anyhow. There are also differences in
the way the rootfs is setup at boot time.

Hope this helps,

Wolfgang.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
