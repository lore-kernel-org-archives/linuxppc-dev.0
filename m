Message-ID: <3A2C1D38.F710DCC@nexus-tech.net>
Date: Mon, 04 Dec 2000 17:39:52 -0500
From: Kyle Harris <kharris@nexus-tech.net>
MIME-Version: 1.0
To: Joe Green <jgreen@mvista.com>
CC: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: lcd823.c color macros
References: <3A2BEAB0.3056A043@nexus-tech.net> <00120414244202.00900@minotaur.mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Joe Green wrote:
>
> On Mon, 04 Dec 2000, Kyle Harris wrote:
> > I don't think the following 2 macros (defined in lcd823.c) work for 8
> > bit color (bit_code = 3).
> >
> > #define NBITS(bit_code)     (1 << (bit_code))
> > #define NCOLORS(bit_code)   (1 << NBITS(bit_code))
>
> Maybe I'm being thick here, but doesn't NBITS(3) = 8 and
> NCOLORS(3) = 256?  What's the problem?

Nope, I'm the one being thick. For some reason I looked at this and
thought it was doing

((bit_code) << 1)

and as usual, all I have to do is send an email for me to discover how
something really works. I apologize for the errant email. I'll try to
limit future ones for real issues.

GIFLI (Gee I Feel Like an Idiot), Kyle.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
