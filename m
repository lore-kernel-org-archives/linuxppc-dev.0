Date: Fri, 20 Aug 1999 09:56:12 -0600 (MDT)
From: Brad Midgley <brad@pht.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: USB cards crash 2.2.10+
Message-ID: <Pine.LNX.3.95.990820094604.14381A-100000@pacific.pht.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


just a heads up: it appears that linus' new usb stack can't deal with the
pci usb cards that were working with the old stack. linux doesn't get past
displaying the bootx text; that's where it stops, presumably panic'd,
until it reboots itself several minutes later. maybe even 180 seconds :)

i will compile a kernel with the usb debug option on and see if that
reveals anything.

it is possible to boot a kernel that has no usb support, so developers
hopefully won't wear out the card pulling it in and out.

Brad
brad@pht.com | http://www.pht.com/~brad/


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
