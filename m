Message-ID: <3ADFF92F.131937C5@opensource.se>
Date: Fri, 20 Apr 2001 10:54:07 +0200
From: Magnus Damm <damm@opensource.se>
MIME-Version: 1.0
To: Michael Habermann <MHabermann@gmx.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MPC8xxFADS support
References: <5.0.2.1.0.20010420083110.009f5850@pop.gmx.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Michael Habermann wrote:
>
> I intend to use the MPC8xxFADS board with an 855T. I've read in this
> newsgroup several times that the FADS are causing problems.
> Which kind of problems do I have to expect? Is PCMCIA supported reliable?

Don't get me started.
I had some problems with the ZIF socket on my FADS860T.
And the MACH chips might have some bugs which makes PCMCIA/FLASH
accesses
wierd if not done the right way. I think that the PCMCIA accesses was
trashed
in some way if the previous access was made to the flash...
But that is usually no problem if you run Linux from memory.

Only some versions of the 860T chip seemed to work with my FADS860T,
even if all my 860:s (T:s and non-T:s) acted normal with my ADS860
board....

The socket driver for the pcmcia-cs package should support FADS860T.
I don't know how the 855T is connected to the PCMCIA socket on the FADS,
you might need to modify the socket driver...

Cheers /

Magnus

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
