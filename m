Message-ID: <390FFDD3.410A690C@mondonet.net>
Date: Wed, 03 May 2000 12:22:11 +0200
From: Mario Scarpa <m.scarpa@mondonet.net>
MIME-Version: 1.0
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
CC: Gabriel Ricard <g_ricard@yahoo.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Lombard hard freeze (still there)
References: <Pine.LNX.4.10.10005022156240.13541-100000@opal.biophys.uni-duesseldorf.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michael Schmitz wrote:
>
> > I am wondering if any of the developers who do kernel
> > related work on LinuxPPC have any suggestions for us
> > on how to deal with this. If I knew how to do the
> > debugging work and trace the problem to its root I
> > would.
>
> It's a bit tough to debug kernel stuff on a machine like the Lombard if it
> has no serial port to attach a console terminal or even a kernel debugger
> to. It's even harder to remote debug such a machine over a mailing list
> :-)

Indeed ;-)

Here's my setup: Lombard with 6GB HD and 64MB RAM (just like yours
I guess); my probs started with USB support compiled in the kernel:
even if it does not lead to a total freeze so often (would say very
seldom indeed), I still get mouse freeze under X when heavy network
activity is being made (last time 5 mins ago getting a big attachment).
Some other times I get a kernel panic during the boot when initializing
the serial interfaces (no, I have NOT support for standard serial
but only MAC serial compiled into the kernel).
This is why I was thinking about some USB/serial code problem but I
agree we need some debug output to work on.

Using Debian 2.2 and XF86_FBDev with kernel 2.2.15pre20 from Paul's
tree.

Thinking about the debug way you suggest, it comes to my mind another
question not so related to the prob: is there a USB->serial converter
around ? Is there one of this devices supported by Linux ? On PPC ?

Ciao,

--
Mario Scarpa

Mondonet NOC
Phone: +39 06 52.47.37.02

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
