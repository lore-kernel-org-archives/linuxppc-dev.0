Date: Tue, 30 Mar 1999 10:13:29 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Dave Weis <djweis@plconline.com>
cc: David Edelsohn <dje@watson.ibm.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: modifying boot loader 
In-Reply-To: <Pine.LNX.3.95.990329222203.1767A-100000@catbert.desm.plconline.com>
Message-ID: <Pine.HPP.3.96.990330100809.1043E-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Mon, 29 Mar 1999, Dave Weis wrote:

> 
> 
> On Mon, 29 Mar 1999, David Edelsohn wrote:
> >       I doubt LinuxPPC will work on a 601-based machine.  The PPC601 was a
> > POWER architecture chip with PowerPC user instructions added. 

But with a PowerPC MMU, which is the important point.

> Based on what I read in the source, they are supported. I guess I'll find
> out in a bit.

Watch out for instructions that try to access HID0, like flushing the
caches, which is very different on 601. I remember seeing various places
(and suggesting some fixes) where accesses to HID0 were not protected with
a check of the processor type. But it was several months ago and I don't
know if all such problems have been fixed now. 

This was my $0.02 tip of the day.

	Gabriel.


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
