Date: Tue, 20 Jun 2000 10:00:59 -0400
Message-Id: <200006201400.KAA19361@rome.wavemark.com>
From: Kent Borg <kentborg@wavemark.com>
To: fray@gate.crashing.org
CC: linuxppc-embedded@lists.linuxppc.org
In-reply-to: <Pine.LNX.4.10.10006191845040.19948-100000@gate.crashing.org>
	(message from Mark Hatle on Mon, 19 Jun 2000 18:48:59 -0500 (CDT))
Subject: Re: RFC: Embedded Linux Page
References: <Pine.LNX.4.10.10006191845040.19948-100000@gate.crashing.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Mark Hatle <fray@gate.crashing.org> wrote:
>Now what I need from you folks are suggests on content

As a representative of one part of your audience, let me describe what
I have been missing: a non-Linux perspective.  Now before you dismiss
me as a weirdo who is posting to the wrong mailing list, please read a
bit further.

I have been a user of Linux for some time, I currently use it as a
platform for cross development work, and I used various versions of
Sun's Unix back when.  But my current work is writing embedded
software.  I start out knowing next to nothing about the Linux kernel,
I have never programmed Linux itself, I don't know (though am
learning) Linux internals.  I am an embedded person looking at Linux,
not a Linux person looking at embedding it.

Whether it be true or not, I get the impression that the embedded
community is largely Linux experts who have decided that Linux can
even be used for embedded purposes, ("Isn't Linux great!").  The
sequence seems to be that many of you folks know Linux first, and then
work to adapt it to embedded uses.

Well, I think Linux is great too, but I know less about it and so my
affection for Linux is based more on faith and politics than it is
based on deep knowledge.  My sequence is different, I have very
specific embedded needs and also somehow have this idea I need to
learn how to how to get Linux to fill them.

The difference might be subtle, but I think there is one.

As a smidge of evidence, one of the open questions we have is how to
execute embedded software directly from ROM (yes, flash ROM!) without
needing to page it through RAM first.  No one seems to do this because
it is very much at odds with how Linux traditionally works, but it is
very common (might I say standard?) in embedded systems to execute
code directly out of ROM, and when you add up the parts costs it can
frequently be economical.

I don't mention this to complain over Linux's defects for not already
having such an option (something tells me I will be the one to write
it once I learn enough about Linux to figure out how), rather I use it
to illustrate a difference in perspective that might be shared by the
next wave of adopters of embedded Linux.

What does this mean for setting up the embedded section of
linuxppc.org?  Only to remember that as Linux becomes more mainstream
(my biggest allies here in looking at embedded Linux are possibly
non-technical folks!) some of your audience will be now coming from
embedded environments and just beginning to look at Linux, not coming
from Linux and adapting it to embedded programming.

The difference in what folks like me don't know will be different, so
how we look at your parts of linuxppc.org will be different too.

OK, I'll shut up now.


Thanks,

-kb, the Kent who has been doing "old" work the last few days and so
not getting any time to play with Linux.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
