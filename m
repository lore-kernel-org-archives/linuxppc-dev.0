Message-Id: <200007121807.TAA15034@hyperion.valhalla.net>
Date: Wed, 12 Jul 2000 19:07:23 +0100
Subject: Re: 2.4.0-t1 & t3: dmasound
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Dan Malek <dan@netx4.com>
CC: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> Cool... can you tell me what AWACS rev you have working?
>> (we have one report of rev == OK) My rev 3 (!OK)
>
> Here is what I have been able to discover by poking around in the
> device-tree and in memory.  It has "davbus" and "sound", so it isn't
> Burgandy.  The value of awacs_revision in memory appears to be 3......

Thnx.

BTW cat /dev/sndstat is probably the quickest way of finding out ;-)

> Now, when I say "works"......I have lots of my own custom audio
> programs (lots of hacks, nothing interesting) and I don't typically
> use any of the mixer or other playback programs (except mpeg3 players).
> I can control speaker/line volume, enable disable speaker.  I am
> really interested in audio processing (hence the G4 :-), and use
> the output to just validate things sound correct.

Yeah... well that's my line of work too... just trying to get the
'underneath' in place and then I'm onto configuring my G4...

>> [I'm struggling right now to try and get a common code base between
>> 2.2.17prexx & 2.4.0 - to avoid confusion on *my* part :-)]
>
> You mean it won't just "drop in" (just kidding, been there :-).  Good
> Luck...Have fun!

It probably will...

Geert's split-up of the code makes it all modular with a separate routine
for each conversion...

I just don't want to add more confusion at the present..
Thanks for the reports..
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
