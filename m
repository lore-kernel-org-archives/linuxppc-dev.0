To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: linuxppc_2_5 source tree (and others) 
In-Reply-To: Message from Cort Dougan <cort@fsmlabs.com>
   of "Thu, 10 May 2001 17:11:14 CST." <20010510171114.C1595@ftsoj.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 11 May 2001 12:31:04 +1000
Message-ID: <18779.989548264@msa.cmst.csiro.au>
From: Murray Jensen <Murray.Jensen@cmst.csiro.au>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, 10 May 2001 17:11:14 -0600, Cort Dougan <cort@fsmlabs.com> writes:
>Believe me, I know what it looks like.  I'm trying to clean things up but
>it's a large problem.  I do appreciate your criticisms though, they are
>useful in finding the worst parts.

And we appreciate your efforts - thank you.

>Perhaps I can clear things up a bit.  I wanted _2_4 stable so that it
>didn't get brand-new (untested and buggy) code.  I created _2_5 as a
>work-area for us so people could push changes there, test them internally
>and work out any problems.  We could then move them over to _2_4 quickly
>when the changes were stable.  Unfortunately, people started giving out the
>_2_5 tree and telling people to use it.
>
>So, to solve that problem I created _2_4_devel so that we could get outside
>testing and let users chose which kernel they wanted (brand-new features or
>very stable and tested).

This is fair enough. I just didn't know what was going on. I have joined the
linuxppc-commit mailing list so I should be better informed in future.

Just as an aside, might this mean that it would be easier to get bk write
access to the _2_4_devel tree? (slight smiley :-).

>Unfortunately we need multiple trees since branches won't do the job for
>us.  Lines of development will, though.  The people at BitMover and working
>on that feature of BitKeeper for us already.

Except it looks like you only get LODs if you pay. The free version won't
have LODs - and a number of other nifty features (as far as I can tell).

>When the real 2.5.0 comes out (when Linus creates it) I'll create another
>tree, linuxppc_2_5.  I made a mistake in naming our experimental tree
>linuxppc_2_5, this tree will be the real linuxppc_2_5.  We'll probably have
>a linuxppc_2_5 and linuxppc_2_5_devel but that's still to be decided (it
>will probably be decided by need).

I actually guessed this was what had happened when I checked on kernel.org
and saw that there wasn't an official linux 2.5 yet (just some pre release
patches).

>If the linuxppc_2_4_devel tree doesn't work for you let me know what
>trouble you're having and I'll try to help.

Thanks for your response - you have cleared the matter up as far as I am
concerned. I feel much better about it all now - I will probably switch to
the _2_4_devel tree. Cheers!
								Murray...
--
Murray Jensen, CSIRO Manufacturing Sci & Tech,         Phone: +61 3 9662 7763
Locked Bag No. 9, Preston, Vic, 3072, Australia.         Fax: +61 3 9662 7853
Internet: Murray.Jensen@cmst.csiro.au  (old address was mjj@mlb.dmt.csiro.au)


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
