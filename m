Message-ID: <20000503175115.20311.qmail@web1704.mail.yahoo.com>
Date: Wed, 3 May 2000 10:51:15 -0700 (PDT)
From: Gabriel Ricard <g_ricard@yahoo.com>
Subject: Re: Lombard hard freeze (still there)
To: Mario Scarpa <m.scarpa@mondonet.net>,
        Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
Cc: Gabriel Ricard <g_ricard@yahoo.com>, linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Well, I've got a 6GB HD,  192MB RAM, and I use a USB
IntelliEye Explorer or whatever those mice with the
red lights are called. Heh. I am using LinuxPPC 2k and
the -stable tree from the rsync server. My symptoms
include a wandering mouse pointer: i.e. when I am
typing rapidly, X will occasionally think I've clicked
the mouse button and the focus goes to where the
pointer was located. I also have strange problems with
my lombard locking up when I leave it in the screen
saver overnight or turn the brightness all the way
down. I haven't had any problems related to massive
network activity. If I don't boot into MacOS enough to
just get the initial grey screen and then reboot and
let yaboot load, I get some really funky effects in X.
Specifically, lines that should be vertical turn
diagonal and stuff like that.


As for the USB->serial adapter, I have one from
Keyspan which several people are working on developing
drivers for. Search the list archives for more detail
on that.


--- Mario Scarpa <m.scarpa@mondonet.net> wrote:
> Michael Schmitz wrote:
> >
> > > I am wondering if any of the developers who do
> kernel
> > > related work on LinuxPPC have any suggestions
> for us
> > > on how to deal with this. If I knew how to do
> the
> > > debugging work and trace the problem to its root
> I
> > > would.
> >
> > It's a bit tough to debug kernel stuff on a
> machine like the Lombard if it
> > has no serial port to attach a console terminal or
> even a kernel debugger
> > to. It's even harder to remote debug such a
> machine over a mailing list
> > :-)
>
> Indeed ;-)
>
> Here's my setup: Lombard with 6GB HD and 64MB RAM
> (just like yours
> I guess); my probs started with USB support compiled
> in the kernel:
> even if it does not lead to a total freeze so often
> (would say very
> seldom indeed), I still get mouse freeze under X
> when heavy network
> activity is being made (last time 5 mins ago getting
> a big attachment).
> Some other times I get a kernel panic during the
> boot when initializing
> the serial interfaces (no, I have NOT support for
> standard serial
> but only MAC serial compiled into the kernel).
> This is why I was thinking about some USB/serial
> code problem but I
> agree we need some debug output to work on.
>
> Using Debian 2.2 and XF86_FBDev with kernel
> 2.2.15pre20 from Paul's
> tree.
>
> Thinking about the debug way you suggest, it comes
> to my mind another
> question not so related to the prob: is there a
> USB->serial converter
> around ? Is there one of this devices supported by
> Linux ? On PPC ?
>
> Ciao,
>
> --
> Mario Scarpa
>
> Mondonet NOC
> Phone: +39 06 52.47.37.02
>

=====
Gabriel Ricard
g_ricard@yahoo.com


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
