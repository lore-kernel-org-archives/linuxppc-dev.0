Date: Wed, 28 Jul 1999 10:09:51 +1000
Message-Id: <199907280009.KAA01751@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: geiseri@msoe.edu
CC: linuxppc-dev@lists.linuxppc.org, linuxppc-user@lists.linuxppc.org
In-reply-to: <379E3513.738D0449@msoe.edu> (message from ian geiser on Tue, 27
	Jul 1999 17:39:15 -0500)
Subject: Re: G3 Upgrade Questions....
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <379E3513.738D0449@msoe.edu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


ian geiser <geiseri@msoe.edu> wrote:

>     I just installed a G3 upgrade card into my powercenter132
>     It is a 400Mhz with 1Meg at 200Mhz....
>     It registers under MacOS perfectly but i get the following under
>     proc/cpuinfo:
>     processor       : 0
>     cpu             : 750
>     temperature     : 0 C            <--Is this correct?!

Yeah, reading the temperature isn't actually implemented yet.

>     clock           : 195MHz        <-- Is this correct?!

That is probably the value from Open Firmware.  I would guess that OF
on your motherboard doesn't know how to work out the clock frequency
correctly for the G3.  It doesn't matter, though.

Paul.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
