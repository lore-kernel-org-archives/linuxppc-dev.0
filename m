Message-Id: <200007121558.QAA32590@hyperion.valhalla.net>
Date: Wed, 12 Jul 2000 16:55:16 +0100
Subject: Re: 2.4.0-t1 & t3: dmasound
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Dan Malek <dan@netx4.com>
CC: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  Wed, Jul 12, 2000,  Dan Malek wrote:
> Iain Sandoe wrote:
>>
>> has anyone got dmasound_awacs to produce output under test1-ac21 or test3?
>
> I am using test2-ac18 on my G4 server (workstation :-).  It works
> fine there.  I haven't tried -test3 yet because of all of the other
> bugs we are fixing.

Cool... can you tell me what AWACS rev you have working?
(we have one report of rev == OK) My rev 3 (!OK)

> By the way, I have some 48Khz modifications.  Basically the inverse
> of the expand functions.  Anyone else doing this or attempting 48Khz
> playback?  Obviously record only works at 44.1Khz.

Later definitely :-)))

[I'm struggling right now to try and get a common code base between
2.2.17prexx & 2.4.0 - to avoid confusion on *my* part :-)]

Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
