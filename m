Date: Sun, 08 Apr 2001 15:47:43 +0100
Subject: Re: DMASOUND->rev6  (2.4.3)(attn: Xine, MOL, PowerComputing,
	 ibook, Tumbler)
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: phandel@cise.ufl.edu
Cc: linuxppc-dev@lists.linuxppc.org, gewrgiou@imbc.gr
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Message-Id: <20010408144747.361B92F074@apollo.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Apr 7, 2001, Peter wrote:
> On Sat, 7 Apr 2001, Iain Sandoe wrote:
>> >>  - fix bug where TX stops when dbdma status comes up "DEAD"
>> >>    so far only reported on PowerComputing clones ... but.
>> >>    (PowerComputing clones - NOT TESTED - please let me know what happens).
>> >
>> > Nope, I can still kill sound by merely moving the mouse.  Here is the new
>> > line from the console:
>> > Apr  7 03:31:13 like kernel: dmasound_pmac: tx-irq: xfer died - patching
>> > it up...
>> >
>> > ...but sound is dead, along with the player app, just as before.

It's disappointing that the sound won't re-start... (with Kostas' tests - it
_was_ - just from the 'wrong' place).

> Another datapoint: It seems as if I can kill sound more easily when I play
> mp3s that reside on my fast drive -> I can kill it within 30sec from the
> IBM 7200rpm UltraSCSI drive, but it takes a few minutes of playing from
> the Seagate 5400rpm UltraSCSI drive.

Hmmm. I'm getting a bit confused... the disk problem we think we (might)
understand - the mouse one is different, maybe ?

I need to get a report from Kostas - because I don't (think) he has the
mouse problem?

ciao,
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
