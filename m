Message-Id: <200009210730.IAA12731@hyperion.valhalla.net>
Date: Thu, 21 Sep 2000 08:30:36 +0100
Subject: Re: __ioremap_at() in 2.4.0-test9-pre2
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: paulus@linuxcare.com.au, Dan Malek <dan@mvista.com>
CC: "Linux/PPC Development" <linuxppc-dev@lists.linuxppc.org>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I admit that I haven't followed all the points in this thread..

>> Yes....IMHO I think the PC is one of the worst architecture designs
>> ever, and making my PowerMac or anything else live within those
>> contraints isn't progress....
>
> Well, your powermac has a PCI bus, and PCI has an I/O space as well as
> a memory space (for better or for worse).
>
> I think my basic point is that a setup where you can't do inb(n) to
> read the byte at address n in PCI I/O space is broken.  On systems
> with 1 PCI host bridge, this is unambiguous, on systems with >1 host
> bridge inb(n) should access address n in PCI I/O space on the first
> host bridge.


Whatever solution is chosen/evolves I have one request:

If we (linux on PPC generally) want to be able to take part in audio on
linux is is (quite/highly) likely that we will have to adopt ALSA fairly
soon - poss. starting with 2.5.

This involves the import of 30+ (at a guess) drivers, with soft-RT
requirements, *all* of these at present are written for PC - to the best of
my knowledge none have been ported yet.

It seems quite a formidable challenge that could put us off the audio stage
for a long while if we can't make is as easy as poss.

Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
