Message-ID: <3B4A44ED.79D7D545@aps.anl.gov>
Date: Mon, 09 Jul 2001 18:57:33 -0500
From: Andrew Johnson <anj@aps.anl.gov>
MIME-Version: 1.0
To: LinuxPPC-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: SSSSlllloooowwww MPC8240
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Can anybody suggest why I'm seeing the following:

Under Hard Hat Linux 2.0 (2.4.2 kernel) on my MVME2100 board (MPC8240 CPU
running at 200MHz), Linux startup reports a BogoMIPS rating of 9.59.  I've
just built and run the exact same calibration code under vxWorks, and here
I get a rating of 133.73 BogoMIPS, which seems much more likely to be
correct.  Linux does seem rather sluggish at running things, so I don't
think it's problem with the calibration.  Any ideas what could be going on
behind the scenes to slow Linux down, and how I might track it down?

I wonder whether it's related to that openpic interrupt stuff in the other
thread...

TIA,

- Andrew
--
The world is such a cheerful place when viewed from upside-down
It makes a rise of every fall, a smile of every frown

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
