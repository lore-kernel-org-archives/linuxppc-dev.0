Message-ID: <393DBB5F.DB509DA@charter.net>
Date: Tue, 06 Jun 2000 22:02:55 -0500
From: "Dan A. Dickey" <ddickey@charter.net>
MIME-Version: 1.0
To: Murray Jensen <Murray.Jensen@cmst.csiro.au>
CC: Dan Malek <dan@netx4.com>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: 8xx MMU Table Walk Base (was Re: kernel crashes at
 InstructionTLBMiss )
References: <23333.960273068@msa.cmst.csiro.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Murray Jensen wrote:
>
> On Mon, 05 Jun 2000 16:37:55 -0400, Dan Malek <dan@netx4.com> writes:
...
> >After reading your diatribe
>
> Diatribe? Hmm.. Sorry, I didn't mean to offend you - I thought I was being
> reasonably clear, and definitely polite.
...
> >Finally, lots of bugs associated with porting to new hardware manifest
> >themselves as "problems" in any VM related function.  Since many people
> >don't understand the subtle interactions of all of these functions (as
> >evidenced by your message) you become convinced the problem is associated
> >with this complexity and fail to unravel the clues to the real cause.
>
> I don't think I deserve this sort of belittling. Treating potential
> contributors in this way can only have a negative effect on open
> source development.

Murray,
please - hang in there.  We need more people like you.
Cut Dan some slack - he appears to be a genius at programming,
but maybe is a little short on people skills.  He means no harm,
but calls them as he sees them.  And as in baseball, not everyone
always agrees with the umpire.  :)
(At least; this is the impression
I've gathered in the relatively short time I've made his acquaintance
and have been reading this list).

>
> >some silicon
> >bug not understood,
>
> I included my chip revision above. It appears to be a C1 revision chip.
>
> >or prototype hardware not working correctly.
>
> Definitely.
>
> >There are lots of products and systems in development running this software,
> >so you have to approach this generic software from the assumption that
> >it is first likely to be working.
>
> I did. I said I was intrigued as to why this problem only affected me. And
> once I make the described change, the "generic software" works for me also
> (at least an older revision works - current revisions still crash, something
> to do with the memory allocation stuff, I believe).
>
> As I said in my previous message, I suspect something else I am doing is
> triggering this bug (that much is obvious), but there are two possibilities:
> either I am doing something wrong in my local changes, or the "generic
> software" has a bug which does not show up in anyone else's implementation. I
> was wondering whether the latter was the case (I wasn't blaming anyone, I was
> excited that maybe I had discovered a long existing hidden fault in the
> software, that may explain some mysterious failure modes, that someone else
> might be getting - other developers may then post, saying "yeah, that would
> explain my problem, blah blah", and so the discussion goes on. Upon searching
> the archives, I found that a similar problem had been discussed for the 2.2.x
> kernels, so maybe the fix or fixes didn't make their way into the 2.[34].x
> kernels. I don't know, anything is possible, that's why we have these
> discussion groups).

Murray,
as far as I know - you are maybe the only one running 2.3.x on
a powerpc.  Most of the kernels that one can find lying about
are 2.2.x (13/14? Can't remember at the moment).

I, as well as others, definitely want to see 2.3.x or 2.4.0 running
on an embedded powerpc.

...

> Again, apologies for not providing enough information in my message - I made
> assumptions I shouldn't have. Obviously, on my first post I should have been
> completely anal, because no-one knows me from a bar of soap. I can then start
> to be less exacting after I have been around for a while.

Everyone enjoys sarcasm... :)  (Don't they?)

> >Where did you get the sources? What
> >patches did you apply?  What are your hardware details?  What
> >modifications did you make?
>
> See above.
>
> >As for 2.4.xx, the 8xx still doesn't work correctly.  However, I
> >discovered it failed to work after the 403 additions, so I am now
> >learning about the 403 in an effort to make everything live happily
> >together again.
>
> It was my feeling that the problems were to do with the new memory allocation
> stuff introduced a couple of months ago.
>
> >Note, this has nothing to do with M_TWB......
>
> I know. Now that we have gotten past treating me like a dill, please can you
> re-read my original message and see if I am making any sense at all? I would
> very much appreciate some insights and even constructive criticism. Cheers!
>                                                                 Murray...
>
> PS: I haven't contributed the Cogent platform changes yet, because I wasn't
> happy that I had done everything properly. This was really my first foray
> into taking part in the Linux/PPC embedded development community - I can't
> say it has been particularly successful (despite my good feelings about
> contributing a small fix a couple of days ago). I will try not to be too
> discouraged.

That's the spirit!

	-Dan	(A different one).

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
