Message-ID: <B0CAE42C9EE0D311AAAD00500422FC6302CD80@iis000.microdata.fr>
From: Patrick Lerda <Lerda@microprocess.com>
To: linuxppc-dev@lists.linuxppc.org,
        "'howarth@bromo.med.uc.edu'"
	 <howarth@bromo.med.uc.edu>
Subject: RE: Stability of 2.3.47 (G4)
Date: Mon, 28 Feb 2000 16:53:06 +0100
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I try linux 2.3.47 on an other kind of PowerPC box, a 740 with a PCI bus.
The kernel start, but my NE2000 or my tulip board don't work in an
nfs mode. The IDE driver crash, and The adaptec driver don't work too.
Otherwise USB seems to work, and my framebuffer works...

I don't know who sync beta PowerPC linux, but I suspect a lot of
little-endian to big-endian problems...


	Patrick L.ERDA


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
