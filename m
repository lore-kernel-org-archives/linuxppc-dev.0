Message-ID: <386B5437.86F7449B@switchboard.ericsson.se>
Date: Thu, 30 Dec 1999 13:46:47 +0100
From: Magnus Damm <damm@kieraypc01.p.y.ki.era.ericsson.se>
MIME-Version: 1.0
To: dhinds@sourceforge.org
CC: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>,
        phr-pcmcia@nightsong.com, nknack@vikingcomponents.com
Subject: CompactFlash Viking problem
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello!

I've been playing around with the 8xxrom pcmcia code and
done some simple CIS parsing code.

I am using a ADS860 Rev B board.
The MMU is off, the code is running from flash.
I've done a workaround for the bugs in the MACH-circuits.

The code works fine with:

SanDisk CompactFlash
Mitsubishi CompactFlash
Ericsson Pcmcia V34 Modem

The following card does not work:

Viking components CompactFlash.

My code reads the attribute space on each card
and parses the tuples. The problem is that the
Viking card gives me correct CIS sometimes,
but mostly crap (I guess some kind of test-pattern).
This leads to no end-of-cis marker, which is bad.

I browsed the net and found that Paul Rubin have had a problem
that seems related:

http://hyper.stanford.edu/HyperNews/get/pcmcia/ataide/39.html

People has experienced problem with Viking components before:

http://www.goof.com/~mmead/dc120/mail-archive/9806/msg00026.html

I've contacted Viking support but they told me that they didn't
do that kind of tech-support.

Another thing is that if I stick to access the ATA registers
all CompactFlash cards (even the Viking) work.

Any ideas, workarounds, similar problems?

TIA /

Magnus Damm

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
