Message-Id: <200007121801.TAA14537@hyperion.valhalla.net>
Date: Wed, 12 Jul 2000 19:01:44 +0100
Subject: dmasound (2.1.27pre10, 2.4.0-test1, 2.4.0-test3)
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: linuxppc-dev@lists.linuxppc.org
CC: Benjamin Herrenschmidt <bh40@calva.net>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


OK.

I've now made a *single* code base for all three versions.

There are two areas that change (between 2.2.17pre10 & 2.4.0-testxx):

    * the wait_queue stuff
    * the ADB access stuff

These are conditionalised on the KERNEL_VERSION .

results are exactly as before:
    2.2.7pre10-ben1   OK
    2.4.0-testx            no sound, no crash, no apparent problem (!)

I will go back and look harder at the init code - although I diffed the
2.3.52 version against the 2.2.17pre7 version whilst I was doing the
backport (at Geert's suggestion)... 2.3.52 was the split point IIRC.

Any ideas how the two changed areas could affect things would be appreciated
- although from reports:

    AWACS rev 2 *does* appear to work with the new version
    AWACS rev 3 appears to work on G4 but not on G3... hmmm.

I must be missing something obvious (yes I have tried altering the volume -
kmixer seems to think all is OK as well).

BTW there is a call that reads a particular byte in nvram (to determine
initial volume)  - is this still valid at 2.4 ?

Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
