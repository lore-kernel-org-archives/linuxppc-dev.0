Message-ID: <005901c044fb$958252c0$1a6a1504@strayer.edu>
From: "Robert Thompson" <rothomp3@vt.edu>
To: "Benjamin Herrenschmidt" <bh40@calva.net>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: iBook trackpad still not working
Date: Thu, 2 Nov 2000 13:34:39 -0500
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0056_01C044D1.A61017A0"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.

------=_NextPart_000_0056_01C044D1.A61017A0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Hi, I don't know if y'all remember me, but I have been having trouble
getting my iBook SE's trackpad working under Linux for months now. Recently
Nathan Wagner (nw@granicus.if.org) complained on the list of a similar
problem with his Pismo, only he was using 2.4.0testSomethingorOther. I just
rsynced linux-pmac-stable, and the problem persists. It started when benh
merged the new input layer into his tree (which I had to use for Rage
Mobility support and so forth). I did some testing with the latest
linux-pmac-stable::

If I configure the kernel not to use the new input layer for adb, the
trackpad does not work. doing 'cat /dev/adbmouse > mousedata.out' to test
results in "/dev/adbmouse: Resource temporarily unavailable". GPM was not
running. X was not running. dmesg reports that everything was detected fine,
says I have an adbmouse at 3 and sets handler to 4 (trackpad).

If I configure the kernel with the new input layer, the trackpad *still*
doesn't work. This time, I get no errors of any kind, it just "doesn't
work." dmesg still reports everything detected fine, registers input devices
and event devices and mouse0 and mouse1 (apparently, the mouse button
emulation) and mentions mice as the PS/2 device for all mice in the system.
Repeating the cat test with 'cat /dev/mice > mouseout.data' now results in
an empty file, no matter how much I move my finger on the trackpad and click
the button. No errors are reported on screen or in any log, there's just no
data coming from the trackpad. Same results with /dev/mouse0.

Attached is the dmesg for the kernel with the input layer.

So, does anybody have any ideas? The keyboard works fine, so it's not a
large ADB problem. It must be specific to mouse/trackpad handling...

Thanks,
Robbie Thompson

------=_NextPart_000_0056_01C044D1.A61017A0
Content-Type: application/x-stuffit;
	name="dmesg.txt.gz"
Content-Disposition: attachment;
	filename="dmesg.txt.gz"
Content-Transfer-Encoding: base64

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
tnCQzvjCd2K2jb8A/5Sc1Y0TAAA=

------=_NextPart_000_0056_01C044D1.A61017A0--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
