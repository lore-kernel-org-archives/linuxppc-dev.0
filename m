Message-Id: <200008030957.KAA17120@hyperion.valhalla.net>
Date: Thu, 03 Aug 2000 10:56:55 +0100
Subject: Re: rtc again...
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Benjamin Herrenschmidt <bh40@calva.net>,
        martin costabel <costabel@wanadoo.fr>, linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


and the 2.2.17pre15 dmesg contains the lines:

====
Linux version 2.2.17pre15-ben1-snd (root@athena) (gcc version 2.95.2
19991024 (release/franzo)) #2 Wed Aug 2 23:16:52 BST 2000
[...]
pmac nvram is core99: 0
System has 64 possible interrupts
GMT Delta read from XPRAM: 60 minutes, DST: on

====

which, as I said, works as long as RTC is -not- involved.
are we applying a correct twice?

Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
