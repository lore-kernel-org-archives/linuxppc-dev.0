In-Reply-To: <Pine.LNX.3.96.1000411215343.219D-100000@deepspace.mklinux.org>
Date: Wed, 12 Apr 2000 14:44:23 +0200
To: "David A. Gatwood" <dgatwood@deepspace.mklinux.org>,
        linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: Problems with Ethernet on PowerBook Wallstreet G3
Message-Id: <20000412144423.023044@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Apr 11, 2000, David A. Gatwood <dgatwood@deepspace.mklinux.org> wrote:

>> * Ethernet is extremely slow when SENDING data.  While  incoming  FTP
>>   traffic  reaches  800...900  kB/s  (which  seems  ok  on  a 10 mbps
>>   network), outgoing traffic makes only 40...50 kB/s.
>
>Interesting.  The MkLinux driver exhibits the same symptoms.  Hmm... I
>wonder....  Do a side by side code comparison, and they're basically the
>same driver...  *coughs*  You might want to have a look at Darwin's
>drivers and see if they shed any light on this.  Unless of course, that's
>just another clone....  I won't even ask....
>
>There are apparently occasional issues of outgoing packets getting hosed.
>Probably a DMA bug somewhere, if I were guessing, but....  I seem to
>recall the data being off by a byte in one direction or the other (i.e. a
>byte getting dropped or added), but I could be remembering wrong.  It has
>been a very long time since I heard anyone mention this bug -- as in two
>years, at least.

The Darwin bmac driver contains interesting comments about chip bugs that
cause Tx packets to get corrupted in some conditions (and possibly other
issues). I didn't have time to look more closely, but for those
interested, the new kernel in Darwin CVS is the module System/xnu (not
System/kernel, this is the old kernel).

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
