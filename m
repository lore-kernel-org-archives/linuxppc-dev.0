Date: Wed, 30 Jun 1999 09:46:26 -0700 (PDT)
From: "David A. Gatwood" <dgatwood@mvista.com>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: "Charles A. Jolley" <charles.jolley@zeratec.com>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: LinuxPPC R5 on PowerBook Series 1999
In-Reply-To: <19990630181150.008408@mail.mipsys.com>
Message-ID: <Pine.LNX.3.96.990630094414.968F-100000@mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 30 Jun 1999, Benjamin Herrenschmidt wrote:

> >2.  I thought I might try to get things working, or at least figure out why
> >the kernel doesn't boot.  The only issue is I can't get any feedback from
> >the kernel on why it dies.  It prints a short message when it first starts
> >but then the screen goes dead before I can read it.  Is there another way to
> >get that information out?   In fact, since there are no serial ports on this
> >machine (just USB...like the iMac), how do I get any feedback from the
> >kernel without functioning video? (or an OF interface to help me along,
> >which is what I do in my other kernel development...)
> 
> Did you try with the "no video driver" option ?
> 
> This may also be a backlight problem, Apple love changing the way the
> backlight is controlled from one model to the other. You can try
> commenting out the backlight control functions in drivers/macintosh/via-pmu.c.

The new PowerBooks are strange....  Under MkLinux, they freeze whenever
you try to write to any location within IO space.  We're getting the data
from OF, so the addresses are right, and we're doing the whole memory
mapping thing.  It acts just like what happens when you try to access a
hardware address where no hardware is present.  I'm beginning to wonder if
the OF tree isn't broken.  If you guys have any luck, let me know what you
figure out.  :-)


David


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
