Message-ID: <37CBFD6B.DB0182B6@wanadoo.fr>
Date: Tue, 31 Aug 1999 18:06:03 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: "David D. Kilzer" <ddkilzer@computer.org>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: SMP support for Daystar 604e 200MHz dual-processor card
References: <v03130301b3f116a864e2@[192.168.1.1]> <v03130300b3f1774818a8@[192.168.1.1]>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


"David D. Kilzer" wrote:

> >>NIP: c00e8818 <autoconfig+ac/490>
> Trace: c00e87c0 <autoconfig+54/490>
> Trace: c018c9e8 <rs_init+3a8/494>

It really looks like it's breaking down in the autoconfig function of
drivers/char/serial.c. What happens if you eliminate CONFIG_SERIAL=y
from
your .config file?

(On the other hand, I see that Paul M. has CONFIG_SERIAL=m in his
standard config files. Does this mean that the serial.c stuff is
supposed to work on the PPC?)

--
Martin

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
