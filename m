Message-ID: <3A2BD0B7.1D7F9D8C@dera.gov.uk>
Date: Mon, 04 Dec 2000 17:13:29 +0000
From: CRS <cshaw@dera.gov.uk>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: MVME2700 VME
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Has anyone managed to get a Linux VME driver to work with the MVME 2700?

I've been trying to get vmelinux-0.10 working on it.  I've got as far as being able to

read/write the universe registers by using PCI IO mapping (PCI memory mapping doesn't seem to

work).  I haven't been able to read or write to a VME device yet, though.

Anybody managed to get further or is there another driver that will work on this platform?

Carl Shaw

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
