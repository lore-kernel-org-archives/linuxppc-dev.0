Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <v04020a00b333dce82245@[128.32.182.85]>
In-Reply-To: <199904090459.XAA24735@lists.linuxppc.org>
Date: Fri, 9 Apr 1999 10:03:15 -0700
To: linuxppc-dev@lists.linuxppc.org
From: Brian C Burke <bcburke@socrates.berkeley.edu>
Subject: Re: TurboMax PCI host adapter (Ultra-ATA)
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


The TurboMax card is not detected at start up with LinuxPPC 2.2.1. With the
MacOS the card is seen as a scsi card and apple drive setup can partition
and initialize disks attached to the card, as can FWB Hard Disk ToolKit
using its generic scsi drivers. I have a pair of 17.2G maxtors attached to
the card each on its own cable, configured as a master drive. Oddly enough
on my setup (rev1 G3) pdisk only sees the first, scsi1.0, failing to see
scsi1.1.
 I wish a I knew enough to attempt setting up a driver as these drives are
cheap (whole setup including tax and shipping $730) and fast.

Brian


>Date: 8 Apr 1999 17:38:50 -0000
>From: LinuxPPC-Dev@associate.com
>Subject: TurboMax PCI host adapter (Ultra-ATA)
>
>Hi,
>
>Can anyone verify that this card works with LinuxPPC?  Comparing the price
>of an Ultra ATA drive with SCSI makes this
>method look really attractive at the 17Gb drive size.  They confirm that
>it'll run under MacOS on a 7500, at least.
>
>Noel Suarez found an inexpensive way to add 10GB of high-speed storage to
>his Power Mac G3/233:
>
>   "I saw the ad from ProMax for an Ultra ATA/DMA PCI card for the Mac.
>When I asked the sales guy on the phone a couple of
>   weeks ago if I could boot off the Ultra ATA/DMA drives attached to the
>card, he said no. I ordered it anyway. It just shipped 2
>   days ago and I installed it yesterday when I got my 10.1 GB Ultra
>ATA/DMA drive from PC Warehouse. The drive was $199
>   and the card was $99. I reformatted the drive with Apple Drive Setup -
>and installed MacOS 8.5 on it and it booted just fine."
>
>Thanks,
>
>glen_stewart@associate.com

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
