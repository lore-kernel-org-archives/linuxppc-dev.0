Message-ID: <389D018F.A081DBFF@unlserve.unl.edu>
Date: Sat, 05 Feb 2000 22:50:29 -0600
From: Takashi Oe <toe@unlserve.unl.edu>
MIME-Version: 1.0
To: BenH <bh40@calva.net>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: [patch] little-endian dmasound silently fails
References: <20000205142613.026592@192.168.1.10>
Content-Type: text/plain; charset=iso-2022-jp
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


BenH wrote:
>
> Actually, I had some reports about this problem too and I'm wondering if
> all revisions of AWACS actually support byte swapping. (I think I
> remember seeing a comment on this list telling explicitely that some
> revisions didn't support it).

AWACS on Nubus PowerMac doesn't support byte swapping.  I know for sure
rev. 2 and 3 (beige G3) do support it.  In any case, many apps are
simply broken.

By the way, I was looking through Darwin code the other day, and I
noticed their pmu code have the following for pmu command:

        kPMUsoundSet            = 0x90,  // sound power control
        kPMUSetDFAC             = 0x91,  // set DFAC register (DBLite)
        kPMUsoundRead           = 0x98,  // read sound power state
        kPMUReadDFAC            = 0x99,  // read DFAC register (DBLite)

Do you have any idea if they are used with G3 PowerBooks under Mac OS?
There was a report long time that an user would lose ability to play
audio CD from media bay drive after sleep, and he needed to boot Mac OS
completely before coming back to Linux to get the lost audio CD
capability back, though beep and other sound functions weren't affected
at all.


Takashi Oe

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
