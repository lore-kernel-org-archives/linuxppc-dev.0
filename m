Date: Mon, 12 Aug 2002 14:18:37 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Khai Trinh <kqtrinh@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: linuxppc_2_4_dev tree
Message-ID: <20020812211837.GA20176@opus.bloom.county>
References: <20020812205133.41469.qmail@web11501.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020812205133.41469.qmail@web11501.mail.yahoo.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Aug 12, 2002 at 01:51:33PM -0700, Khai Trinh wrote:

> How can I build a kernel image with target filesystem
> mounted via NFS fro mthe dev tree? The dev tree
> doesn't seem to have the target filesystem directory
> structure like the ones distributed by MVista for NFS
> mount.
>
Er, I don't quite follow you.  If you want to build a kernel from the
_devel tree which mounts it's filesystem over NFS, you need to start
with the config file from the MVL kernel, and then turn on
CONFIG_CMDLINE_BOOL, and have a command line of 'ip=on'.

> If it's not nfs mountable, can I create a ramdisk
> filesystem together with the kernel image?

Yes.  Make the filesystem image, gzip it, and place it was
'arch/ppc/boot/images/ramdisk.image.gz', and then do 'make
zImage.initrd'

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
