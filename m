Date: Thu, 9 May 2002 10:37:02 -0400
From: Bill Fink <billfink@mindspring.com>
To: LinuxPPC Developers <linuxppc-dev@lists.linuxppc.org>
Cc: Bill Fink <billfink@mindspring.com>
Subject: 2.4.19-pre8-ben0 acenic driver and 867 MHz G4 sound problems
Message-Id: <20020509103702.528f1a7c.billfink@mindspring.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

First, thanks to BenH for his fix in the 2.4.19-pre8-ben0 kernel that
once again allows booting of the 867 MHz G4.  Unfortunately, I now have
a new problem as the acenic driver is now broken (using a NetGear GA620
NIC).  The previously working version was from a 2.4.17-pre2-ben0 kernel.
I can send a diff between the two sources if that would be of any help.

Also, is there any update on why sound doesn't work on the 867?  It would
be nice to listen to CDs or watch DVDs on these machines.

						-Bill

P.S.  For the sound problem, here's some info starting with the dmesg output:

      dmasound_pmac: found Keylargo rev 2 or later - H/W byte-swap disabled
      PowerMac Tumbler  DMA sound driver rev 016 installed
      Core driver edition 01.06 : PowerMac Built-in Sound driver edition 00.06

      proc/pci:

        Bus  1, device  23, function  0:
          Class ff00: Apple Computer Inc. KeyLargo Mac I/O (rev 3).
            Master Capable.  Latency=16.
            Non-prefetchable 32 bit memory at 0x80000000 [0x8007ffff].
        Bus  1, device  24, function  0:
          USB Controller: Apple Computer Inc. KeyLargo USB (rev 0).
            IRQ 27.
            Master Capable.  Latency=16.  Min Gnt=3.Max Lat=86.
            Non-prefetchable 32 bit memory at 0x80081000 [0x80081fff].
        Bus  1, device  25, function  0:
          USB Controller: Apple Computer Inc. KeyLargo USB (#2) (rev 0).
            IRQ 28.
            Master Capable.  Latency=16.  Min Gnt=3.Max Lat=86.
            Non-prefetchable 32 bit memory at 0x80080000 [0x80080fff].

      /dev/sndstat:

      PowerMac Tumbler DMA sound driver rev 016 :
      Core driver edition 01.06 : PowerMac Built-in Sound driver edition 00.06
      HW rates: 48000 44100 s/sec
      HW AFMTS: signed 16 bit BE
                       === Formats & settings ===
      Parameter                 soft                hard
      Format   :    signed 16 bit BE    signed 16 bit BE
      Samp Rate:         22050 s/sec         44100 s/sec
      Channels :              stereo              stereo
                       === Sound Queue status ===
      Allocated: Buffers  Size
          write:       4 32768
      Current  : MaxFrg FragSiz MaxAct Frnt Rear Cnt RrSize A B S L  xruns
          write:      4   32768      4    0   -1   0      0 0 0 0 0      0

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
