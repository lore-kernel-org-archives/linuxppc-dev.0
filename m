Subject: Re: Fast boot times
From: Kenneth Johansson <ken@switchboard.ericsson.se>
To: "Kevin P. Dankwardt" <k@kcomputing.com>
Cc: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <KCEOLLHGFJIAFNAMGACHIEGADMAA.k@kcomputing.com>
References: <KCEOLLHGFJIAFNAMGACHIEGADMAA.k@kcomputing.com>
Content-Type: text/plain
Message-Id: <1086702496.4640.8.camel@spawn.uab.ericsson.se>
Mime-Version: 1.0
Date: Tue, 08 Jun 2004 15:48:17 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 2004-06-08 at 03:57, Kevin P. Dankwardt wrote:
> I am participating in a project that has a challenging boot time
> requirement. We need a Linux boot solution where we have booted in the
> 50msec range, talking on a protocol stack, from a COLD Start (power being
> applied to the board.) The loading of the drivers and the stack
> initialization has to occur within 50msec.
>
> Does anyone have any leads/ideas for being able to meet this deadline?

You don't say much about the hardware but I would say it's a borderline
case even if you put a lot of work into it.

say you have a 8bit flash 120ns access time that gives
8.3 MB/sec thus you can only copy 400kB data in 50ms so you have barley
enough time getting the data into dram before your time is up.

It's not going to happen just checking a config option that's for sure.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
