Mime-Version: 1.0
Message-Id: <v04220804b555aff9390d@[192.168.0.2]>
In-Reply-To: <20000524225002.O383@plato.local.lan>
References: <392C4F17.61D04687@mac.com>
 <20000524225002.O383@plato.local.lan>
Date: Sat, 27 May 2000 10:33:04 -0700
To: Ethan Benson <erbenson@alaska.net>
From: "Michael A. Peters" <mpeters@mac.com>
Subject: ybin and kernel level
Cc: linuxppc-dev@lists.linuxppc.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I saw it noted in the preliminary yBin/yaBoot documentation that a
newer kernel was recommended, suggesting a 2.2.15pre3 or later.

Is there anything specific about the 2.2.14 that won't allow it to work?

I'm using a 2.2.14 kernel built from standard source (ftp.kernel.org)
with the 2.3.50 usb backport.

I tried that backport with a 2.2.15 kernel, and it boots (BootX), but
when booting the typical USB info doesn't scroll by the screen and no
usb devices are available (for example, upon starting X, error 19,
can't open usb mouse device)

Part of me thinks that may be BootX related, I had to upgrade BootX
when switching to my current kernel due to usb weirdness, but I don't
know for sure.

I know the FAQ is up, but its not quite finished yet- (but what is
done is very good so far)

The way I made a boostrap partition was to first create apple hfs
partition. I then wrote down the start block and length in blocks,
and (using pdisk) deleted the partition, using a C {create by
specified type), entering Apple_Bootstrap when it asked for file
system type.

Is that correct?

***

The drive my bootstrap partition will be located on is internal scsi,
attached to an adaptec 2930u controller.

I'm fairly sure I can find the full path to the device in the open
firmware, but interestingly enough- Apple System Profiler does NOT
see the scsi card or give any info on it.

It does not appear in the pci devices, although volumes attached to
the card ARE seen by System Profiler, and seen on bus 1 (opposed to
the built in bus 0)

Weird.



Thanks,
Michael A. Peters


-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
Michael A. Peters--		http://216.22.163.20/Linux_Pages/
				http://www.linuxzombies.com/
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
