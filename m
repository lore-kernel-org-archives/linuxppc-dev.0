Mime-Version: 1.0
Message-Id: <p0433010ab649bafec687@[206.6.156.5]>
In-Reply-To: 
 <Pine.LNX.4.10.10011282036580.22745-100000@opal.biophys.uni-duesseld
 orf.de>
References: 
 <Pine.LNX.4.10.10011282036580.22745-100000@opal.biophys.uni-duesseld
 orf.de>
Date: Tue, 28 Nov 2000 14:55:28 -0500
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
From: Stefan Jeglinski <jeglin@4pi.com>
Subject: Re: usb wheel mouse, XF4.0
Cc: linuxppc-dev@lists.linuxppc.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>  > ... not that there isn't a simple trick, and not that I've exhausted
>>  all my possibilities yet, but my level of exasperation is rather high
>>  at the moment... so far I'm chalking it up mostly to usb still being
>>  not really built into the stable kernel.
>
>Wrong: support for USB PCI cards not being built into the stable kernel.
>Support for recent Mac builtin USB controllers (OHCI) is just fine.
>Support for anything above the controller (protocols) apparently works
>fine with OHCI (PPC) and UHCI (Intel).

I take it you're saying that PCI USB cards are not being officially
supported, but they may work. Otherwise I don't get your comment. The
backport into 2.2.18 (which will be defined as stable when it is no
longer pre status) seems to include config options for many keyspan
devices, among others. Are these not PCI cards? I could clearly be
dead wrong here, I'm now surmising.


>What exactly is on the PCI USB card?

It's an Orangelink USB/Firewire card, 2 usbs, 2 firewire ports.
Otherwise I'm not sure what your question means. Do you ask for chip
brands/numbers, etc?

I -think- the card is seen fine, as per my recent dmesg posted on
linuxppc-user. AFAICT, I've done everything as I should with the
input layer. I can't absolutely prove the mouse works (Logitech
2-button + wheel), but I -think- it is there. The problem is that in
console, I get no mouse action (I can see and move a cursor around
the screen with the ADB mouse), and in X, it's as if only every
10000th mouse event is being registered (every once in a while, when
there is disk activity, the USB mouse will jump in the general
direction I've moved it, the ADB mouse continues to work fine).

As I implied in my e-mail but could have been clearer about, I'm not
at all certain that the issue really is with the usb or the mouse or
the usb card, etc. It's just that for me, on an old-world Mac, the
usb experience as a whole has a flaw somewhere that I've been unable
to figure out.


Stefan Jeglinski

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
