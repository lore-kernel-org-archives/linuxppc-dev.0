Message-ID: <408E2AF4.2050907@fh-landshut.de>
Date: Tue, 27 Apr 2004 11:42:12 +0200
From: Oliver Korpilla <okorpil@fh-landshut.de>
MIME-Version: 1.0
To: Marius Groeger <mgroeger@sysgo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Initrd and PPCbug, can it work?
References: <Pine.LNX.4.58.0404211503050.20798@ppcproject1> <20040426220944.GI19246@smtp.west.cox.net> <408E000A.6040303@fh-landshut.de> <Pine.LNX.4.56.0404270913230.2035@mag.sysgo.com> <408E1ED0.4050404@fh-landshut.de> <Pine.LNX.4.56.0404271119270.2567@mag.sysgo.com>
In-Reply-To: <Pine.LNX.4.56.0404271119270.2567@mag.sysgo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Marius Groeger wrote:
> On Tue, 27 Apr 2004, Oliver Korpilla wrote:
>
>
>>TCP: Hash tables configured (established 2048 bind 2048)
>>NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
>>cramfs: wrong magic
>>Kernel panic: VFS: Unable to mount root fs on 01:00
>>  <0>Rebooting in 180 seconds..
>
>
> Now -- is it cramfs or ext2 that you want to boot? It looks like you haven't
> configured ext2 in your kernel!?
>

This was the first I checked - CONFIG_EXT2_FS is set to y. Besides, I
tried doing the same with a cramfs initrd - won't work either. Cannot
say whether I configured that right.

Maybe this is an endianess problem in my initrds?

I don't know. :(

With kind regards,
Oliver Korpilla

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
