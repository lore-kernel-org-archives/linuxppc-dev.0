Message-Id: <200007272341.AAA12154@hyperion.valhalla.net>
Date: Fri, 28 Jul 2000 00:41:47 +0100
Subject: 9600/imsttfb - pre13 better but...
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


9600 (604e)/233

OK, so I built 2.2.17pre13-ben1.

Now I have an imsttfb working - albeit with some faults.... I guess, for
that, it might be time to try 4.0.1

But I still have no mouse...

dmesg reports all the usual things (keyboard & mouse numbers etc.)

The input layer seems to register stuff...

(BTW I can't build this without enabling USB stuff - even with the new input
layer disabled).

The problem is... that nothing *looks* wrong/crashes or gives any hints...
but the mouse is inactive...

any ideas?
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
