Message-Id: <200101031947.TAA19299@hyperion.valhalla.net>
Date: Wed, 03 Jan 2001 19:47:36 +0000
Subject: Re: esound and 2.2's dmasound
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Hollis R Blanchard <hollis+@andrew.cmu.edu>,
        linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Hollis et. al...

>However, with dmasound as a module (and 'alias sound dmasound_pmac' in
>/etc/modules.conf), everything (including esound) works perfectly.

;-)))

> - 2.2.18 final and esound still don't play well together
> - the 2.4 dmasound backport doesn't work compiled in (and probably could be
>   updated for 2.2.18)

it's probably a silly - like forgetting to call the init from within
drivers/char/mem.c  (that change has been made several times by both me &
Geert) but it seems to slip out of the diffs somehow)...

I will be back on the case as soon as poss (maybe after this month).

There's obviously lots still to do to get full duplex working properly for
2.4.0 - from other reports... and a niggle in my mind that says "maybe some
of the dbdma traffic I've seen on the list might have an effect on the
flakinesss (or otherwise) of the dmasound driver..."

(and also there's the start of an ALSA version - from a posting on the
ALSA-dev list yesterday)...

- I'm just still bogged down in "work-that-pays-the-rent" :-(

ciao,
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
