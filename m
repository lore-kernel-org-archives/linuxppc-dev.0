Message-Id: <199909101014.AA08041@LONSF24318.MLE.CO.UK>
From: "Saulnier, Geoff (London)" <saulngeo@MLE.CO.UK>
To: "'LinuxPPC Dev'" <linuxppc-dev@lists.linuxppc.org>,
        "'LinuxPPC User'"
	 <linuxppc-user@lists.linuxppc.org>
Subject: UW SCSI PCI cards
Date: Fri, 10 Sep 1999 11:09:51 +0100
Mime-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi!

My apologies fro posting to both lists, but this is a question that I think
applies to both...

Finally managed to get linuxppc installed, from the CD, onto my Beige G3
minitower.  It has a PCI Ultra-Wide SCSI card and 2 4Gb UW SCSI disks of
that card.  I had to install it onto a 1Gig Jaz cart because of the
following problems:

No matter how well partitioned my drives were (with Mac pdisk), the intaller
would not see them, and pdisk in the linux X installer environment would not
see them.  In fact, it would see not partitions at all of any kind.

When I formated and partitioned a Jaz cart, with the drive on the external,
ordinary SCSI bus, it was seen by the installer and things went fine from
there.

So, my questions are:
  -  what PCI UW SCSI cards are supported in the final version
  -  are there any plans to support others (I am assuming that the one that
came in my box is not supported!)
or
  -  does this problem sound like it has nothing to do with the card?

Thanks for any help!!

Geoff Saulnier                    Merrill Lynch 
TEL: +44 (0)171 867 4305          London GFX Systems 
FAX: +44 (0)171 867 4478          6A Ropemaker Place
MOB: +44 (0)976 27 16 16          geoff_saulnier@ml.com


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
