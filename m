Message-ID: <36D2C0FD.663F3446@phx.mcd.mot.com>
Date: Tue, 23 Feb 1999 07:53:49 -0700
From: Johnnie Peters <jpeters@phx.mcd.mot.com>
MIME-Version: 1.0
To: VALETTE Eric <valette@crf.canon.fr>
CC: cort@persephone.cs.nmt.edu, paubert@iram.es, jeremy@goop.org,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Interrupt routing in prep_pci.c
References: <Pine.LNX.3.96.990222122334.5504A-100000@persephone.cs.nmt.edu> <m10FDOf-0000WXC@tri-yann.crf.canon.fr>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've been trying to stay out of this discussion because I was pretty sure it
would
take on the tone of religous conviction but here is my two cents worth.

I have tried Gabriels patches.  I used his boot loader stuff with my own
Raven changes
and for some of our boards it worked great (namely the VME boards).  However
it did
not work for everything.  Since I work exclusively with Motorola machines and
have
several different ones here, I would very much prefer a kernel that boots
correctly
on all of them if possible.

Gabriels stuff breaks on several.  It does not take into account some of the
newer stuff
such as the Mesquite cPCI board.  As Cort stated in one message in this
thread of
discussion, LinuxPPC is already trying to account for dozens of sometimes
very different
board types and is currently doing it with only 3 or 4 different boot loader
setups.  It
has been identified as necessary to add at least a couple of more to account
for all the
MBX stuff and others.  If the number of boot loaders increases into the
dozens, the
corresponding kernel changes will follow suit and chaos will rule in the
LinuxPPC
world.

I too have sent patches to Cort that are not yet in the sources.  I too would
very
much like to see them in and solve the issues I have keeping my sources
updated
everytime there is changes to the vger tree. I have 13 years of doing UNIX
kernel experience and have seen too many engineers concerned with getting
their little bit of the picture working reguardless of what it does to
everybody
else.

When you send a patch to Cort and wish it too be included, he will test it on
the
machines he currently has.  They are not all inclusive and if It breaks one
of them
then that patch should be rejected.  If he does not reject it then he looses
credibility in his submissions to Linus and at some time no more PPC code
will make it into the main base because Linus will not trust Cort.  I cannot
and
will not beleive that this is what you want.

I am not sure but I think that I recently saw a post where Gabriel showed an
ftp
link where you could retrieve his stuff.  He also stated that it did not work
with
Open Firmware.  Some of the boxes I use to test various things I am trying to
do
with LinuxPPC are Motorola Utahs.  There are some bootleg versions of PPCBug
floating around for them but they are incomplete and the engineer that did
most of
the work to get it going (in his free time) told me that it is still unstable
on the
Utah.  I also tried for 2 days to get Gabriels patches and try them again
to see if some of the problems I was having had been fixed.  I never got in.
Here
again if you want credibility with Cort, me and the others subscribing to
this list
then dont make posts that are unrealistic like this one.

I have been using Linux since the 0.96 release.  For many years I did not
have
the chance to participate directly in the Linux community.  I did, however,
follow what was going on.  I have over the years read flames against every
coordinator there was includeing Linus.  Somebody has to control what gets
into the source base.  For LinuxPPC right now this is Cort.  He has taken
the responsibility for it.  I have rarely seen professionals that had a clue
about how to do this and Cort as a graduate student is doing a pretty damn
good job.

There was at one point something called the System V Interface
Definition for UNIX.  I spent years telling customers that what they wanted
would break the standards for UNIX and I rarely got more than "but thats what

I want back".  Cort is in the position where he has to tell people the same
kind of thing.  Good engineers do not break exsisting things to get new
things
working.  It is Corts job to enforce this with LinuxPPC.

I have stated to Cort that I can test pretty much anything he needs on
Motorola
boxes (Blackhawk, Utah, MTX, MVMEXXXX, Mequite, Sitka, etc.)  I will tell
him where it does and does not work.  You can do the same it you have
resources.
We will get pretty much everything working with time.  Give Cort a break
and work with him.

Johnnie


VALETTE Eric wrote:

> >>>>> "Cort" == Cort Dougan <cort@persephone.cs.nmt.edu> writes:
>
> Cort> It's not as simple as you suggest.
>
> You haven't even tried. Did you try Gabriel patches?
>
> Cort Code it up so that it works on all
> Cort> the boards around and I'll be quite happy to take it :)  The problem
> Cort> I'm having now is code that works on one set doesn't work on others.
>
> That's your choice. Provided you do not ask me to agree and do not
> ask for support of your way of handling patches...
>
> -- eric




[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
