Subject: Re: ext2fs or ramdisk problems......
To: kd@flaga.is
Date: Fri, 25 Aug 2000 10:19:05 +1000 (EST)
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <OF18903253.173E814B-ON00256945.00432B3E@flaga.is> from "kd@flaga.is" at Aug 24, 2000 12:25:04 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000825001905.1A60E211@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


kd@flaga.is writes:
> Or is this still the ramdisk driver teesing me?

If you haven't solved your problem with the ramdisk crashing, I very much
doubt that it will cope with having a filesystem mounted on it.  As it's a
custom board, how do you know your UPM tables are correct?  Have you tried
running the same kernel on a known-good board from Embedded Planet,
Bright Star or TQM?

Regards,
Graham

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
