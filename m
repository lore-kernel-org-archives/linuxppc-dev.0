Message-ID: <3897F5E8.818AED11@switchboard.ericsson.se>
Date: Wed, 02 Feb 2000 10:16:24 +0100
From: Magnus Damm <damm@kieraypc01.p.y.ki.era.ericsson.se>
MIME-Version: 1.0
To: Karl Pálsson <KPA@infocom.dk>
CC: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: 821/823 and Linuxppc problems revisited
References: <819E3E914E0AD11194DE00805F0D100B010882DD@fbi.infocom.dk>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>




Karl Pálsson wrote:
>
> Hi all,

Hi!

> Thank you for your replies regarding the 821 and related problems.
> We will use 823 in our design instead of the 821. That brings me back to the
> original question: Are there any known problems implementing Linuxppc on the
> 823? Hints? Advice? Any luck with DiskOnChip?

I say: Go for CompactFlash on the PCMCIA port instead of the DiskOnChip.
They are cheap and they work great.

We use it here.

I tried linux on a 823 yesterday and it works great!
The cpu core is the same as 850 (not 823e though).

As I said before - try a RPX LITE 823 from embedded planet.
I've got one here!

Then you can run Linux on it and try it out if it meets
your performance demands before you make your own board.

The 860/821/823e has bigger caches/mmu which will give you
better performance.

Cheers /

Magnus


> Best regards,
> Karl Palsson, B.Sc.E.E.
> Infocom Defence Systems A/S
> Ellegaardsvej 25
> 6400 Soenderborg
> Tel: +45-73 12 30 00

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
