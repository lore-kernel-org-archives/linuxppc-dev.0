Date: Sat, 07 Apr 2001 11:56:06 +0100
Subject: Re: DMASOUND->rev6  (2.4.3)(attn: Xine, MOL, PowerComputing,
	 ibook, Tumbler)
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: phandel@cise.ufl.edu
Cc: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Message-Id: <20010407105610.94080DBA03@atlas.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>  - fix bug where TX stops when dbdma status comes up "DEAD"
>>    so far only reported on PowerComputing clones ... but.
>>    (PowerComputing clones - NOT TESTED - please let me know what happens).
>
> Nope, I can still kill sound by merely moving the mouse.  Here is the new
> line from the console:
>
> Apr  7 03:31:13 like kernel: dmasound_pmac: tx-irq: xfer died - patching
> it up...
>
> ...but sound is dead, along with the player app, just as before.

damn... so much for the dbdma manual... :-(

what do you _have_ to do to re-start the sound?
kill & re-start the app?
close & re-open /dev/dsp?
un-load & re-load the module?
- or reboot?

can you make sure it's not the app that's stopping?
(or is this equally the case with _any_ app?)

If you have a big-ish file (although it doesn't sound like you need very
big) then my stest program would do to test it... it's *very* simple and
therefore should eliminate lots of other possibilities ;-)

ciao,
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
