Message-ID: <39A6AE48.57526AE5@mvista.com>
Date: Fri, 25 Aug 2000 17:35:04 +0000
From: Scott Anderson <sanders@mvista.com>
MIME-Version: 1.0
To: "Whitney, John" <johnw@aiinet.com>
CC: "'greyham@research.canon.com.au'" <greyham@research.canon.com.au>,
        kd@flaga.is, linuxppc-embedded@lists.linuxppc.org
Subject: Re: ext2fs or ramdisk problems......
References: <7283DE19D141D111AD0E00A0C95B195502C5F605@mail2.aiinet.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


"Whitney, John" wrote:
>
> I have had odd results using ext2 on the ramdisk (in my case, a 16MB
> ramdisk).  Using the 2.2.13, ramdisks I created using ext2 would boot
> up just fine on the system, but after use the filesystem would declare
> that it was out of space, even though "df" showed several megabytes
> free on that filesystem.

My guess is that you ran out of inodes.  Examine the output of dumpe2fs
and see if it gives you any clues.

    Scott Anderson
    scott_anderson@mvista.com	MontaVista Software Inc.
    (408)328-9214		490 Potrero Ave.
    http://www.mvista.com	Sunnyvale, CA  94086

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
