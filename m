Message-ID: <396C9E3A.B1775C43@embeddededge.com>
Date: Wed, 12 Jul 2000 12:35:06 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Iain Sandoe <iain@sandoe.co.uk>
CC: Dan Malek <dan@netx4.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.4.0-t1 & t3: dmasound
References: <200007121558.QAA32590@hyperion.valhalla.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Iain Sandoe wrote:

> Cool... can you tell me what AWACS rev you have working?
> (we have one report of rev == OK) My rev 3 (!OK)

Here is what I have been able to discover by poking around in the
device-tree and in memory.  It has "davbus" and "sound", so it isn't
Burgandy.  The value of awacs_revision in memory appears to be 3......

Now, when I say "works"......I have lots of my own custom audio
programs (lots of hacks, nothing interesting) and I don't typically
use any of the mixer or other playback programs (except mpeg3 players).
I can control speaker/line volume, enable disable speaker.  I am
really interested in audio processing (hence the G4 :-), and use
the output to just validate things sound correct.

> [I'm struggling right now to try and get a common code base between
> 2.2.17prexx & 2.4.0 - to avoid confusion on *my* part :-)]

You mean it won't just "drop in" (just kidding, been there :-).  Good
Luck...Have fun!


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
