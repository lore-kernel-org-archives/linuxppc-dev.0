Message-Id: <200009201537.QAA05334@hyperion.valhalla.net>
Date: Wed, 20 Sep 2000 16:38:12 +0100
Subject: 2.4.0-t8 (dumb question & two crashes)
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


OK...

I don't seem to be able to get modprobe to work on 2.4.0-t8 unless I move
the modules from where the build puts them into their old positions.
According to rpmfind I have the latest modutils... where am I going wrong?

====

It crashes (not got output from xmon yet) on my 9600 on reboot [don't know
where]

crashes on G3/beige on reboot (ditto on xmon output) but this time I'm
fairly sure it only crashes when it has an unknown USB device on the bus (an
epson styluscan 2500) - seems OK if the printer is switched off.

Iain.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
