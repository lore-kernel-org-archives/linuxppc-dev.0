Message-ID: <3795BF97.C20C7A54@generation.net>
Date: Wed, 21 Jul 1999 08:39:51 -0400
From: Simon Piette <spiette@generation.net>
MIME-Version: 1.0
To: Brian C Burke <bcburke@socrates.berkeley.edu>,
        LinuxPPC-Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: SANE
References: <199907200502.AAA26510@lists.linuxppc.org> <v04210100b3ba5a637b89@[128.32.182.85]>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Brian C Burke wrote:

> >For what its worth, I have SANE 1.0.1 working without problems with
> >R5 and kernel 2.2.10 which I compiled with the sg drivers. The
> >machine is a rev1 G3 233 with a UMAX 610s on the internal scsi bus.

Great! I got a few questions for you!

Where did you take your kernel sources (vger, pmac, kernel.org)?

Did you take the stock sg drivers, or you compiled them from
http://www.torque.net/sg/?

Which scsi bus your scanner is using ( 53C94, mesh, Adaptec XXXX)? By
'internal', you mean built-in?

How many devices do you have on your scsi bus?

Thanks,

Simon


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
