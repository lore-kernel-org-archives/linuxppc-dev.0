Message-Id: <200004151632.RAA09255@hyperion.valhalla.net>
Date: Sat, 15 Apr 2000 17:40:01 +0100
Subject: Re: Preserving memory...
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: "PPC-DEV" <linuxppc-dev@lists.linuxppc.org>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> On Tue, 11 Apr 2000, Josh Huber wrote:
>> First, is there a way to tell powerpc hardware (Macs in particular -- for
>> now) to preserve memory across a system restart?  It looks like it does this
>> by default, partially.
>>
>> Secondly, if I can get the first part to work reliably, does anyone know
>> what regions of memory should be avoided, i.e. are thrashed by OF etc?
>
> At least on the LongTrail, all memory is cleared by OF (at least it looks like
> that).

The macs have the OF #MEGS variable - so you should be able to control it -
it seems to work on the 9500.

I think that the trashed area is from the start.
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
