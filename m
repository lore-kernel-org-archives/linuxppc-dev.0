Message-ID: <39A51B4A.B01F84D7@adtran.com>
Date: Thu, 24 Aug 2000 07:55:38 -0500
From: Ron Flory <ron.flory@adtran.com>
MIME-Version: 1.0
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: ext2fs or ramdisk problems......
References: <OF18903253.173E814B-ON00256945.00432B3E@flaga.is>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


kd@flaga.is wrote:
>
> Hi,
>
> Is it for shure that the ext2fs is endian independent?
> fs created with the commands (issued in Debian 2.2. (potato) on an i386
> machine) :

 unless something changed in the last few weeks, it is.  I use e2fs on
x86 (little-endian) and m68k (big-endian) on the same physical disk
drive all the time, but that doesn't mean the partitioning schemes are
identical on all systems...

ron

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
