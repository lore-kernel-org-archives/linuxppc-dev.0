Date: Wed, 9 Jul 2003 20:35:36 +0400
From: Jack Angel <man@oceanography.ru>
To: linuxppc-embedded@lists.linuxppc.org
Subject: embeddedplanet.com IcePlanet bootloader troubles
Message-Id: <20030709203536.12e4ed0e.man@oceanography.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello.

I've got the following problem with embeddedplanet.com IcePlanet board

At the beginning, the iceplanet was, when turned on, waiting for 2
seconds, and then booting into diagnostic utilities. The boot process
could be interrupted, leading to the bootloader shell. In this shell,
config variables may be get/set by the "set" command. The value of
"Variant" variable which designates the on-board processor type, was
set to "GPr", and the legal values for this variable were "?" and "GPr".

Trying to load and boot something using tftp, I tried the file which
is mentioned in the iceplanet manual 4xx_pc_load.pdf as an example -
PCL4xx103.ep
After loading, I typed "go", the file executed, spitting out messages
that it's a planetcore bootloader flash burner, then, almost
immediately, it displayed the message that burning is underway, and,
not much time afterwards, complete and that I should press "R" to reset.

After reset, the bootloader loaded to it's shell (no autoboot),
displaying:
PPC4xx PlanetCore Boot Loader v1.03
Copyright 1998-2002 Embedded Planet, LLC. All rights reserved.
DRAM available size = 64 MB
wv 435 errors CV 720 errors
RAM test failed

Before experimenting with tftp, the "DRAM ok" message was displayed.
Also, the set command exposed the fact that Variant variable was now
set to "GP" and
legal value for it were "?", "GP".

Currently, when cold-booted after some off-line time, the DRAM is
reported ok, and tftp works,
but after some uptime, the device report the same errors about RAM
(various numbers each time),  and fails to load anything via tftp.
Doesn't autoboot, either (manual "go" works though, going to
diagnostic utilities).

--
The human knowledge belongs to the world

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
