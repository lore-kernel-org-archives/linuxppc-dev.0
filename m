Date: Wed, 9 Jun 1999 09:54:18 +1000
Message-Id: <199906082354.JAA05316@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: drow@false.org
CC: linuxppc-dev@lists.linuxppc.org
In-reply-to: <19990608101236.A5738@drow.res.cmu.edu> (message from Daniel
	Jacobowitz on Tue, 8 Jun 1999 10:12:36 -0400)
Subject: Re: Q: control is a C&T 65550?
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <19990608095844.A5496@drow.res.cmu.edu> <Pine.LNX.4.10.9906081600260.20992-100000@mercator.cs.kuleuven.ac.be> <19990608101236.A5738@drow.res.cmu.edu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Daniel Jacobowitz <drow@false.org> wrote:

> That's one of those if-i-had-more-time things - and more specifically,
> if I knew how to dump video regs under macos.  Is it trivial?

This is where I use xmon.  There is a macos version at (I think)
ftp://ftp.linuxppc.org/users/paulus/misc/xmon.bin.  From memory, the
control registers are at 0x90010000 and the RADACAL (ramdac/cursor
chip) registers are at 0xf301b000.

The other thing to do is to browse through the darwin sources from
apple and see if they have a control driver somewhere.

IIRC, the hardware cursor uses some extra bytes on each scan line and
some registers in the RADACAL.

Paul.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
