Message-ID: <37AFCBA3.FBA0CC9D@stny.rr.com>
Date: Tue, 10 Aug 1999 02:50:11 -0400
From: Patrick Berge <pberge@stny.rr.com>
MIME-Version: 1.0
To: Paul.Mackerras@cs.anu.edu.au
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: mace:transmit timeout - resetting
References: <37AFA3A3.370B25CB@stny.rr.com> <199908100606.QAA23344@tango.anu.edu.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paul Mackerras wrote:

>
> The reason for the message is that there are some bugs in the mace
> chip which cause it to lock up very occasionally.  When the driver
> detects this condition, it prints this message and tries to reset the
> chip.  If your network keeps working, then it means that the driver
> successfully got the mace chip going again.
>
> > Any ideas about my problem and/or the meaning of the HZ would be
> > helpful.
>
> HZ is the number of timer interrupts per second.
>
> Paul.

Oh No... yea it still works but is very very slow so bad I can not even use
VNC !   Well this is miserable!  Thank you very much for the quick
response.  Looks like I will be buying a PCI ethernet card for my PowerMac
7200.  I just got it donated to me so guess I can't complain too much.
Does Apple know about the problem since mace is used with the built-in
ethernet?  I am sure this is asking too much but I will try ...will Apple
replace it?

I would still like to get a software fix for my problem? If possible?  Will
increasing the timeout value improve the problem?  It would if the software
detection of the timeout is bogus sometimes.  If the software detection of
this problem is always detecting the hardware hang then increasing the
timeout will just make it slower.  Any ideas ?

Also what company made the mace chip ... I am hardware designer myself and
I am very frustrated to see companies ship buggy hardware!  I work on
hardware for UNIX machines that must be 24x7 and  blazingly fast.  It is a
shame PC customers put up with buggy hardware/software!  (That is why
Windows/MacOS are still around.)  I guess rebooting your machine because of
lock ups or the blue screen death is acceptable... yea but the UNIX
customers do pay lots of bucks.  Sorry I had to vent my frustrations.

Patrick Berge


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
