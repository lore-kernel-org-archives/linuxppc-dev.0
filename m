Message-ID: <XFMail.990210203209.jeremy@goop.org>
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
Date: Wed, 10 Feb 1999 20:32:09 -0800 (PST)
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: Interrupt routing in prep_pci.c
Cc: cort@cs.nmt.edu
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Cort/all,

I'm trying to work out what kernel/prep_pci.c is doing with interrupt routing. 
I'm looking at the stuff in the standard 2.2 kernel, so perhaps there's a better
place for me to look.

Firstly, in route_pci_interrupts it does an inb(0x800) to get something to
determine the interrupt architecture of the board.  What is this value, and
where does it come from?

Rather than having hard-coded tables, can't the interrupt routing be determined
from either firmware or the interrupt controller itself?  The comment at the
top of the file is that this will go away soon.  What are you planning to
replace it?

Background: I'm porting LinuxPPC to a Yellowknife-like board running Open
Firmware.  It works well except that the drivers can't find their interrupts.

Thanks,
        J

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
