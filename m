To: <linuxppc-embedded@lists.linuxppc.org>
Subject: floppy device detection
MIME-Version: 1.0
Message-ID: <OF0CD7BA45.CD58F567-ONC1256D80.00221184-C1256D80.00248BDB@se.wavetek.com>
From: "Laurent Mohin" <laurent.mohin@acterna.com>
Date: Tue, 12 Aug 2003 08:18:56 +0200
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I'm designing a product in which some devices are optional (hard drive,
floppy ...).
After the linux booting, my application program need to know which devices
are present, and if possible without performing a transfer to the device
in order to be as quicker as possible.

To detect the hard drive presence, I think I can detect if the directory
/proc/ide/hda exists because my hard drive will always be recognized as
hda.
Is there a similar way of detection for the floppy?

Thanks,

Laurent

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
