Message-Id: <199907112114.QAA23812@www2.tuckeris.com>
Date: Sun, 11 Jul 1999 16:02:38 -0500
Subject: Re: Serial Ports on USB
From: "Charles A. Jolley" <charles.jolley@zeratec.com>
To: Nathan Hurst <njh@drongo.anu.edu.au>
CC: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>From: Nathan Hurst <njh@drongo.anu.edu.au>

> On Fri, 9 Jul 1999, Charles A. Jolley wrote:
>
>>     And while I'm on this topic, I would really like to get my kernel
>> booting on an iMac, but I'm not sure how to access my debugger, etc. without
>> having video, keyboard, or serial support.  How was this done when getting
>> LinuxPPC up on the iMac?
>
> network?
>

Network was my first thought as well...but then you have to support the
ethernet card and some protocol stack (most likely TCP/IP) to get much use
out of it...

But then I realized that in fact the answer is simple:  Why not use the
modem?  The iMac documentation says it appears as a serial port that
responds to AT commands and from the looks of the OF tree and the Linux
source, this is the case at the hardware level (unlike ADB compatibility,
which is done via software shims...)  A null modem cable and (maybe) a few
AT initialization commands at startup to put the modem into online mode
ought to do the trick...this will be easier than I thought.

-Charles

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
