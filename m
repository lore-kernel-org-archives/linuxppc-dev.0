Date: Tue, 27 Apr 2004 11:22:08 +0200 (CEST)
From: Marius Groeger <mgroeger@sysgo.com>
To: Oliver Korpilla <okorpil@fh-landshut.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Initrd and PPCbug, can it work?
In-Reply-To: <408E1ED0.4050404@fh-landshut.de>
Message-ID: <Pine.LNX.4.56.0404271119270.2567@mag.sysgo.com>
References: <Pine.LNX.4.58.0404211503050.20798@ppcproject1>
 <20040426220944.GI19246@smtp.west.cox.net> <408E000A.6040303@fh-landshut.de>
 <Pine.LNX.4.56.0404270913230.2035@mag.sysgo.com> <408E1ED0.4050404@fh-landshut.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 27 Apr 2004, Oliver Korpilla wrote:

> The initrd image was made with ext2, copied over to
> arch/ppc/boot/images/ramdisk.image.gz, and I made make zImage.initrd
...
> TCP: Hash tables configured (established 2048 bind 2048)
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> cramfs: wrong magic
> Kernel panic: VFS: Unable to mount root fs on 01:00
>   <0>Rebooting in 180 seconds..

Now -- is it cramfs or ext2 that you want to boot? It looks like you haven't
configured ext2 in your kernel!?

Regards,
Marius

--
Marius Groeger <mgroeger@sysgo.com>           Project Manager
SYSGO AG                      Embedded and Real-Time Software
Voice: +49 6136 9948 0                  FAX: +49 6136 9948 10
www.sysgo.com | www.elinos.com | www.osek.de | www.imerva.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
