Message-ID: <3BABA186.3ECCABC2@mvista.com>
Date: Fri, 21 Sep 2001 16:22:30 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Ralph Blach <rcblach@raleigh.ibm.com>
Cc: linuxppc-dev@lists.linuxppc.org,
	Holger Bettag <hobold@Informatik.Uni-Bremen.DE>,
	Mark Salisbury <mbs@mc.com>,
	"Timothy A. Seufert" <tas@mindspring.com>
Subject: Re: ppc LE questions (seeking help hand info pointers)
References: <20010920171002.37DCA2B54A@marcus.pants.nu>
					 <3BAA363B.5010400@mc.com> <8xlmj9psnw.fsf@s62.informatik.uni-bremen.de>
					 <3BAA4F46.1020002@mc.com> <p05100304b7d00bd21d35@[10.0.0.42]> <3BAAB9E7.16F9ED2D@mvista.com> <3BAB727D.C85E5CB@raleigh.ibm.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Ralph Blach wrote:

> I just wanted to clear up some inaccuracies in this previous note.

Ok, before this discussion gets further out of control, and I
get blamed for many things, I want you to know that Book E has
been discussed among many people on these mailing lists ever
since the specification was public.  I just happened be working
at 4 AM when these previous messages were posted, and (as I
indicated) I was posting a summary of lots of discussions that
have occurred in the past.  Unfortunetly, this gets represented
as _my_ view, when the purpose is to discuss what we are going to
do to accomodate these new architectures.

The 405GP is the first Book E type processor that has had a
significant impact in Linux.  Yes, there was some early 403
that Tivo used successfully, but those were some localized
modifications specific to the product and didn't lend themselves
to be merged and carried forward without breaking other things.

In the case of the 405, for the past six months about all I have
been doing is taking patches from many others, making the
necessary changes so they can be applied to the current trees,
and then testing to ensure we didn't break something else.  This
is a very time consuming process, some of it done on my own
free time (as I have other development obligations), and I can
hardly take credit for any new development.  All I have done is
tried to make the 4xx port better fit with the others.  This must
have been somewhat successful, because the software updates from
people around the world keep increasing, and we are able to
immediately use the latest software enhancements to Linux.

The first discussions about Book E among the PowerPC developers
was whether we treat it as a new architecture or try to integrate
it with the traditional PowerPC source code base.  Although from
a user application perspective it will likely execute 32-bit code
like past PowerPC cores, from the kernel perspective it is very
different.  No one was interested in starting up a new architecture,
especially for a new processor that wasn't even available to
those of us working on Linux.  The only way Book E was going to
be initially successful was to make it somehow fit into the
traditional PowerPC baseline.  That, too, seems like a pretty
good decision, as the interest in Linux and 405 is high and
continues to grow.

Now that we have established a base of software and a growing
group of users, after we get to look at another processor from
the Book E family perhaps it is time to start a new architecture
tree.  This isn't something to be taken lightly, as it requires
a dedication to the development like we have for the existing
PowerPC development.  I'm certain some of us will play in both
camps (at least I hope so :-), but we can't afford to spread our
existing PowerPC resources even thinner, as no one will benefit.

There are advantages to using Book E over other processors, but
keep in mind there are few architectural features that haven't
been used in the past or currently exist on other processors.
Processors support a wide range of features to address a wide
range of (sometimes disparate) requirements that just simply
don't allow reasonably using all of the features all of the time.
We need to venture into the other architecture spaces and
learn from them.  The recently highly contentious byte swap
page mapping is clearly one of these.  Other processors appear
to support it, but developers haven't chosen to use it in a
Linux environment.

I have had lots of fun and much success developing software for
the PowerPC processor family.  The Book E is now part of that
development and I intend to do the same for it.  From the
perspective of the Linux kernel, Book E is very different from
the traditional PowerPC, we have to admit that, adjust for it,
and continue to make it successful.  The current PowerPC is about
10 years old, and some of the best things just don't happen
overnight.

The Linux software development has to continue in the same democratic
way it has in the past that has made it so successful.  Simply
demanding something and getting pissed when _I_ don't immmediately
implement it is not the road to success and happiness.  Like
many others, I have invested years of personal time at the expense
of other life opportunities on PowerPC Linux development.  There
are things I would like to change, but consensus is necessary
among everyone to ensure features are properly implemented and
maintained.

So, let's keep some constructive technical discussions going and
please keep sending your source code updates.

Thanks.


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
