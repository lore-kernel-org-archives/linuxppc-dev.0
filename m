Date: Sun, 3 Sep 2000 22:40:03 -0500 (CDT)
From: Takashi Oe <toe@unlserve.unl.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: SCC chip bug on various macs
In-Reply-To: <20000802162229.12340@mailhost.mipsys.com>
Message-ID: <Pine.LNX.3.96LJ1.1b7.1000903222140.13609D-100000@ofey.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

According to Darwin's SCC driver, there is a chip bug in that the receiver
may lock up when certain conditions are met.  The affected machines listed
in the driver source are:

Performa 5400/6400/6500, 20th Anniversary Mac, PowerBook 2400/3400,
StarMax 3000, PowerMac 4400, Power Macintosh G3 (Gossamer).

The workaround is in FixZeroBug() of Darwin source:

IO/Drivers/Port/AppleSCCSerial/AppleSCCSerial.kmodproj/SccChipPrimatives.cpp

Last I checked, this workaround is not in Linux's
drivers/macintosh/macserial.c, and I suspect this bug might account for
occassional failure reports with mac serial.

Anybody care to code it for Linux?  I would do it if I had any of the
affected machine, but I don't, so .... anybody?  :)


Cheers,

Takashi Oe


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
