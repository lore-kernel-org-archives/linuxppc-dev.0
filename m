Message-Id: <200012081221.MAA24453@hyperion.valhalla.net>
Date: Fri, 08 Dec 2000 11:56:32 +0000
Subject: Re: AW: Sound on an iBook?
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        "Halfmann, Klaus" <khalfmann@libra.de>
CC: "'Christof Petig'" <christof.petig@wtal.de>,
        linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi All,

(Michael, this might not make to you... because of the dreaded ORBS
situation - which *still* hasn't been resolved after 4 months).

>> > I got no answer on the debian-ppc list, so I'll try here.
>> >
>> > does anybody know a way to get the sound hardware on my iBook working?
>> > Everything else is working fine.
>> >
>>
>> The iBook has a different Hardware than all other Macs found so far.
> [...]
>> This issue needs a good assembler-/Forth- Programmer that must
>> use MacsBug in MacOS or dissassemble the OF to find out whats
>> going on there. I'd really like to do that but that is nothing
>> I can do when going to work by train ....
>
> Christof could always resort to petitioning Apple to release the specs, or
> digging though Darwin source code to discover the secret.

There was a guy working on the iBook sound (which was why I'd left it alone
for now).  He said that it only took a couple of lines to get sound out...
although I suspect you'll have to rely on whatever settings MacOS last left
for it.... because...

The "problem" is that the mixer abstraction needs a re-write to talk to the
Micronas chip.

I've been (very) out of circulation and will be until Xmas or so... but if I
have a chance I'll see if I can find the relevant lines (IIRC it only
involves detecting the iBook in init and dealing with the register
assignments... but it's been a while since I looked).

Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
