Message-ID: <388853FC.5ECAED85@switchboard.ericsson.se>
Date: Fri, 21 Jan 2000 13:41:32 +0100
From: Magnus Damm <damm@kieraypc01.p.y.ki.era.ericsson.se>
MIME-Version: 1.0
To: Graham Stoney <greyham@research.canon.com.au>
CC: Hans - Dulimarta <dulimart@egr.msu.edu>,
        linuxppc-embedded@lists.linuxppc.org
Subject: PCMCIA socket driver (was Re: Non NFS boot)
References: <20000121013945.A4B981B298@elph.research.canon.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am working on a PCMCIA socket driver for the 8xx series.

I've managed to run a Xircom based ethernetcard and ATA-Flash.

The following boards will be supported:

BOARD                CPU

RPX CLASSIC LOW FAT  860T
RPX LITE             850 823
ADS                  860
FADS                 860T

This will make it possible to use any ATA-Disk as root fs.

The code will be available as a patch againts pcmcia-cs-3.1.8.tar.gz

Cheers /

Magnus

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
