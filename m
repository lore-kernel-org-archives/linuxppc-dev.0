Message-Id: <200007271931.UAA32685@hyperion.valhalla.net>
Date: Thu, 27 Jul 2000 20:32:01 +0100
Subject: pre10 ben2 9600/IMSTTFB (part2)
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


OK, it's a bit weird...

I'm trying to boot "single" now with no imsttfb option...

I have the new input layer selected in the compile (and the changes made in
/dev)

It doesn't work (i.e. I get a blank screen) with the no video option ticked
either... until...
I do sysrq-k at which point I get the init 5 stuff (and an X server with a
login prompt)...

So I can get in (and check that it is the kernel I thought I was trying) and
also look at messages - which seems to reveal no log for the previous
attempt (in spite of the fact that it seems to have made it to 'single' -
because I could type 'reboot').

No mouse working... although all the correct messages (for the new input
layer) appear in dmesg....
keyboard is OK.

I've never had a problem booting "single"  with the OF display before...
Ho Hum...

Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
