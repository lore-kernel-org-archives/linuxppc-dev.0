Message-Id: <200008061359.OAA14167@hyperion.valhalla.net>
Date: Sun, 06 Aug 2000 14:59:26 +0100
Subject: sound testers...
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi to all those that have been dmasound driver-testing.

There have been a couple of cases where apparent problems with the dmasound
driver have turned out to be application-related.

Here is a very simple test prog. (must have been done a million times
before) and some test data in different sound formats (ditto).

http://www.drfruitcake.com/linux/stest.html

All these work fine on my system - and I can see no behaviour problems with
the driver using them.

If anyone can uncover one that doesn't work with a particular machine
configuration this will help us refine the init code to get over such
things.  If you find a non-working case - I would like to know the machine,
and as much of the content of mac-io:davbus & sound from the device tree as
poss.




thanks
Iain.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
