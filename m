Message-Id: <200008020034.BAA22318@hyperion.valhalla.net>
Date: Wed, 02 Aug 2000 01:34:04 +0100
Subject: Re: CONFIG_PPC != Mac
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        Martin Costabel <costabel@wanadoo.fr>
CC: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
        "linuxppc-dev" <linuxppc-dev@lists.linuxppc.org>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



>> The main problem so far is that I cannot get mouse button emulation to
>> work. Has anyone tested this on an ADB keyboard/mouse? Or does it only
>> work if one goes over completely to the "linux" keycodes? I don't want
>> to do this yet, because it will make my system unusable with any other
>> kernel (or maybe unusable at all). Last time I tried, it took me several
>> hours to get a usable system back.
>
> ADB keyboard and mouse work (and button emulation works as well) with
> CONFIG_NEW_INPUT_LAYER not set. What doesn't work for me anymore is the
> USB mouse. The 2.2.17 kernel (rsynced last Thursday) only compiled after I
> added a #ifdef CONFIG_MOUSEDEV somewhere in mac_keyb.c as a consequence of
> not having CONFIG_NEW_INPUT_LAYER defined. I'd look it up on the Lombard
> but the box just crashed on me the second time in a row today. 2.2.17 sure
> is exciting.

2.2.17pre13ben2

Actually, (in contrast to my debacle with the Xserver) this has all gone
very smoothly for me - I'm using the new input layer and USB & ADB work
together beautifully on both B3 beige (with a cheepo USB card) and Lombard
(with a logitech wheel mouse).

It also works fine on my 9600 - which hasn't got the faintest clue of the
existence of USB :-)

The only gottcha I found was (as Ben suggested) that you *do* need to delete
the adbmouse entry in /dev rather than just rename it (OK, so I'm paranoid
sometimes).

I had a nasty crash with 2.2.17pre13ben2 on the Lombard (posted) but this
was IDE disk-related (and prob. something to do with sleep).

I suppose that I'm using Xpmac (still :-) rev.10 which might be why it's all
gone easily.

Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
