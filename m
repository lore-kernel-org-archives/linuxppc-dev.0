Date: Sat, 07 Apr 2001 12:56:51 +0100
Subject: Re: DMASOUND->rev6  (2.4.3)(attn: Xine, MOL, PowerComputing,
	 ibook, Tumbler)
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: phandel@cise.ufl.edu
Cc: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Message-Id: <20010407115656.B5F2EDBA70@atlas.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


]
>>  - fix bug where TX stops when dbdma status comes up "DEAD"
>>    so far only reported on PowerComputing clones ... but.
>>    (PowerComputing clones - NOT TESTED - please let me know what happens).
>
> Nope, I can still kill sound by merely moving the mouse.

This is beginning to  worry me - I can't see what it has to do with the
disk-sound interaction we were originally talking about.

(did I ever get your dev-tree? - I can't find a mail with it...).

when you move the mouse:

via-cuda (?)
...
move cursor in display driver (*PCI* , I guess?).

does the problem occur if you press & hold a key?
(i.e. is it the adb end or the display driver end?)

what display device?
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
