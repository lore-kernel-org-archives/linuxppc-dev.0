Message-ID: <394F8350.DF0FF572@snmc.com>
Date: Tue, 20 Jun 2000 09:44:32 -0500
From: Daris Nevil <dnevil@snmc.com>
MIME-Version: 1.0
To: Kent Borg <kentborg@wavemark.com>
CC: fray@gate.crashing.org, linuxppc-embedded@lists.linuxppc.org
Subject: Re: RFC: Embedded Linux Page
References: <Pine.LNX.4.10.10006191845040.19948-100000@gate.crashing.org> <200006201400.KAA19361@rome.wavemark.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Kent,

I appreciate your comments, and I think it is a helpful insight, and is a
viewpoint that we should remember when dealing with new-comers
to Linx.  It was only about 18 months ago that I made a decision to
use Linux on a company project.

Perhaps I am unusual in the group, but my background is not Linux.  I
am a real pSOS fanatic (or at least I was).  I worked with embedded
pSOS since 1990 for telecom systems for companies like Alcatel,
Fujitsu, etc.  My drive to go to embedded Linux is the sheer power
of the system because of the tools and applications available.

Another premise I assumed when I started into embedded Linux is
that the price per meg of memory (both in RAM and FLASH) is
dropping quickly.  When I start in embedded telecom systems in 1988
you were excited when you had 32K of EPROM and 2K of RAM.
But it is very affordable today to have 4M FLASH/16M SDRAM.  In fact,
I'm not sure your system would be much cheaper by having less memory,
by the time you take into account your engineering effort required and lost
revenues from the delay of having to make your code fit into tiny memory
footprints (been there, done that).

However, I understand your point.  From reading your postings before it
sounds as though you have a very cost senstive project.  The systems I
target are higher-end telecom systems, and ones where you might have
only one or two embedded Linux boards per system (~$15K/system).
So its easy to justify the cost of the SDRAM/FLASH.

In any case, I offer my *free* advice, and that is if you really need to fit
into small memory footprints, you may as well stick with a "real" embedded
OS, such as pSOS, or RTEMS, or eCOS.  These OS's were written with
the intent of going into systems like the one your talking about.  However,
you will probably find that you will not have the great number of tools and
applications for these as you do with Linux (which is what attracted me
to embedded Linux).

Technically, with the understanding I have gained from tromping around
in the Linux kernel source code, I think you would have a difficult time
accomplishing your goal of running from ROM.  I'm not saying its impossible,
but I think you will get snagged on the MMU issues (go back and read some
of the previous postings about trying to get the MMU to work on a "normal"
system).

If you do pursue this coarse, you might want to check out the site
www.uclinux.com.  They have a port of Linux that does not use the MMU.  You
might have an easier time getting that version to run straight from ROM.

Good luck with your endevors.  Who knows, you might start a whole new branch
of development for the Linux kernel that will "add your destinctiveness to our
own".
(Resistance is futile).

Daris Nevil
SiSIC Inc/SNMC
www.snmc.com


Kent Borg wrote:

> Mark Hatle <fray@gate.crashing.org> wrote:
> >Now what I need from you folks are suggests on content
>
> As a representative of one part of your audience, let me describe what
> I have been missing: a non-Linux perspective.  Now before you dismiss
> me as a weirdo who is posting to the wrong mailing list, please read a
> bit further.
>
> I have been a user of Linux for some time, I currently use it as a
> platform for cross development work, and I used various versions of
> Sun's Unix back when.  But my current work is writing embedded
> software.  I start out knowing next to nothing about the Linux kernel,
> I have never programmed Linux itself, I don't know (though am
> learning) Linux internals.  I am an embedded person looking at Linux,
> not a Linux person looking at embedding it.
>
> Whether it be true or not, I get the impression that the embedded
> community is largely Linux experts who have decided that Linux can
> even be used for embedded purposes, ("Isn't Linux great!").  The
> sequence seems to be that many of you folks know Linux first, and then
> work to adapt it to embedded uses.
>
> Well, I think Linux is great too, but I know less about it and so my
> affection for Linux is based more on faith and politics than it is
> based on deep knowledge.  My sequence is different, I have very
> specific embedded needs and also somehow have this idea I need to
> learn how to how to get Linux to fill them.
>
> The difference might be subtle, but I think there is one.
>
> As a smidge of evidence, one of the open questions we have is how to
> execute embedded software directly from ROM (yes, flash ROM!) without
> needing to page it through RAM first.  No one seems to do this because
> it is very much at odds with how Linux traditionally works, but it is
> very common (might I say standard?) in embedded systems to execute
> code directly out of ROM, and when you add up the parts costs it can
> frequently be economical.
>
> I don't mention this to complain over Linux's defects for not already
> having such an option (something tells me I will be the one to write
> it once I learn enough about Linux to figure out how), rather I use it
> to illustrate a difference in perspective that might be shared by the
> next wave of adopters of embedded Linux.
>
> What does this mean for setting up the embedded section of
> linuxppc.org?  Only to remember that as Linux becomes more mainstream
> (my biggest allies here in looking at embedded Linux are possibly
> non-technical folks!) some of your audience will be now coming from
> embedded environments and just beginning to look at Linux, not coming
> from Linux and adapting it to embedded programming.
>
> The difference in what folks like me don't know will be different, so
> how we look at your parts of linuxppc.org will be different too.
>
> OK, I'll shut up now.
>
> Thanks,
>
> -kb, the Kent who has been doing "old" work the last few days and so
> not getting any time to play with Linux.
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
