Subject: Running CompactFlash and HDD on mpc8xx
To: linuxppc-embedded@lists.linuxppc.org
Message-ID: <OF6BAADFDA.4583E669-ON85256E90.005833B1-85256E90.0059BCB3@nanometrics.ca>
From: David Ho <DavidHo@nanometrics.ca>
Date: Mon, 10 May 2004 12:20:10 -0400
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

I am looking a way to have CompactFlash and HDD working together on a
MPC8xx platform.  Ultimately both (IDE, IDE_CS) systems calls
m8xx_ide_init_hwif_ports to initialize ATA register location/hardware.
Right now this function is pretty stupid:  it assumes that it is being
called from the same subsystem and initialize stuff as if it is always a
hard drive hanging off of the processor bus.

One idea I have is to make m8xx_ide_init_hwif_ports smarter and have it
identify from the parameters passed which stack it is being called from so
that it can initialize to the appropriate hardware.  Right now I don't see
anything that can indicate/differentiate between the two.

Would anyone else has any ideas about this.  I would appreciate hearing
your suggestions.

I am cross posting this to Linux PCMCIA forums as well.

Regards,

David Ho
Nanometrics Seimological Instruments


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
