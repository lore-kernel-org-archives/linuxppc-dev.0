To: Matt Porter <mmporter@home.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.2.8/2.3.0 SCSI problems?
References: <Pine.LNX.3.96.990513082543.20083B-100000@liberty.chnd1.az.home.com>
Reply-To: minyard@acm.org
From: Corey Minyard <minyard@acm.org>
Date: 14 May 1999 23:10:43 +0200
In-Reply-To: Matt Porter's message of "Thu, 13 May 1999 08:33:26 -0700 (MST)"
Message-ID: <m2lnerwe5o.fsf@wf-rch.cirr.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Matt Porter <mmporter@home.com> writes:

> I was running vger 2.2.5 with patches for Motorola support on a variety
> of systems here successfully.
> 
> These patches made it into 2.3.0 so I'm testing it and finding that SCSI
> support is broken.  On an MTX with a 53c875 chipset, the 2.3.0 kernel
> hangs scanning the SCSI bus.  The ncr8xx driver has been updated since
> 2.2.5, but I get the same results if I patch the driver from 2.2.5 into
> 2.3.0.
> 
> Seems like it's either a generic scsi support issue or something PPC
> specific.  It is reporting that PCI interrupts are set properly and all
> the driver resources are allocated the same as in my 2.2.5 kernel so I'm
> at a loss for answers. :-/
> 
> --
> Matt Porter
> mmporter@home.com

I'm having the same problem with my MVME2700 with an ncr53c8xx chip.
I did a little debugging and checking.  In my previous kernel version
that I had running (2.2p4), it chose to use interrupt 14 for the chip.
In 2.2.9, it chose to use interrupt 19.  But that is the only thing I
can find.

If anyone has a solution I'd like to know.

Thanks,

-- 
Corey Minyard                   Internet:  minyard@acm.org
  Work: minyard@nortelnetworks.com  UUCP:  minyard@wf-rch.cirr.com

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
