Cc: Murray Jensen <Murray.Jensen@cmst.csiro.au>, Dan Malek <dan@netx4.com>,
        linuxppc-embedded@lists.linuxppc.org
Message-ID: <393D6F1C.27C9A48E@lucent.com>
Date: Tue, 06 Jun 2000 15:37:32 -0600
From: Steve Tarr <tarr@lucent.com>
MIME-Version: 1.0
To: "Dan A. Dickey" <ddickey@charter.net>
Subject: Re: 8xx MMU Table Walk Base (was Re: kernel crashes at
 InstructionTLBMiss )
References: <23333.960273068@msa.cmst.csiro.au> <393DBB5F.DB509DA@charter.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


"Dan A. Dickey" wrote:
Clip, clip, clip....
> > discussion groups).
>
> Murray,
> as far as I know - you are maybe the only one running 2.3.x on
> a powerpc.  Most of the kernels that one can find lying about
> are 2.2.x (13/14? Can't remember at the moment).
>
> I, as well as others, definitely want to see 2.3.x or 2.4.0 running
> on an embedded powerpc.
>

Hey, it does. I have 2.3.99-pre7 hacked and running on a MPC8260.
Actually,
a pretty clean port with the exception of handling the SCC as the
console.

> ...
>
> > Again, apologies for not providing enough information in my message - I made
> > assumptions I shouldn't have. Obviously, on my first post I should have been
> > completely anal, because no-one knows me from a bar of soap. I can then start
> > to be less exacting after I have been around for a while.
>
> Everyone enjoys sarcasm... :)  (Don't they?)
>
> > >Where did you get the sources? What
> > >patches did you apply?  What are your hardware details?  What
> > >modifications did you make?
> >
> > See above.
> >
> > >As for 2.4.xx, the 8xx still doesn't work correctly.  However, I
> > >discovered it failed to work after the 403 additions, so I am now
> > >learning about the 403 in an effort to make everything live happily
> > >together again.
> >
> > It was my feeling that the problems were to do with the new memory allocation
> > stuff introduced a couple of months ago.
> >
> > >Note, this has nothing to do with M_TWB......
> >
> > I know. Now that we have gotten past treating me like a dill, please can you
> > re-read my original message and see if I am making any sense at all? I would
> > very much appreciate some insights and even constructive criticism. Cheers!
> >                                                                 Murray...
> >
> > PS: I haven't contributed the Cogent platform changes yet, because I wasn't
> > happy that I had done everything properly. This was really my first foray
> > into taking part in the Linux/PPC embedded development community - I can't
> > say it has been particularly successful (despite my good feelings about
> > contributing a small fix a couple of days ago). I will try not to be too
> > discouraged.
>
> That's the spirit!
>

I get more done asking stupid questions than I do pondering the
elusive answer. Elephant hide and a resonable reputation of getting
things
done helps. Hang tough and have fun.......

Cheers --
tarr

>         -Dan    (A different one).
>

--
Steven Tarr
Lucent Technologies - Bell Labs
303-538-4056
tarr@lucent.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
