Message-Id: <200007282223.XAA13505@hyperion.valhalla.net>
Date: Fri, 28 Jul 2000 23:23:56 +0100
Subject: dmasound patch - three machine tests
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've supplemented the tests that others have done with the machines I have
(not G4 yet).

Against 2.2.17pre13ben2 + IRQ blocking patch + dmasound patch

G3 beige minitower (SCSI disk, IDE CDROM only)
G3 Lombard (All IDE)
604e 9600/233  (All SCSI)

All three are OK and exhibit more or less the same behaviour as reported
elsewhere (i.e. some cases no sound from internal speaker, weird mixer
controls etc.)

No crashes.

Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
