Date: Thu, 21 Mar 2002 14:36:33 -0600
From: Troy Benjegerdes <hozer@drgw.net>
To: Michael Sokolov <msokolov@ivan.Harhan.ORG>
Cc: trini@kernel.crashing.org, linux-galileo@source.mvista.com,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: EV-64260-BP & GT64260 bi_recs
Message-ID: <20020321143633.V6003@altus.drgw.net>
References: <0203201704.AA10152@ivan.Harhan.ORG>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0203201704.AA10152@ivan.Harhan.ORG>; from msokolov@ivan.Harhan.ORG on Wed, Mar 20, 2002 at 09:04:35AM -0800
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Mar 20, 2002 at 09:04:35AM -0800, Michael Sokolov wrote:
>
> Tom Rini <trini@kernel.crashing.org> wrote:
>
> > Sure there is, for it to be accepted.
>
> Wait a minute, why am I even talking to you? Mark said he is the responsible
> maintainer and promised to push my patch in a few days if there is no consensus
> by then, and I think I'll just wait a few days and then ask him to stick to his
> word. (I'm willing to bet $50 that in the next few days there will be no
> consensus nor will anyone else offer a counterpatch.)

Well, If I remember right, Mark doesn't even have a galileo board anymore
(someone else got it). So I could probably make an argument I'm the
maintainer now.

>
> > And would you please make it
> > versus the _galileo tree
>
> Sorry, no, that would be a step backward and we need to move forward.

I strongly suggest you submit me (or the -galileo) list patches, otherwise
when I start merging the _galileo tree code to _devel, I'm likely to blow
your changes away because I can't test them.

And PLEASE give me a different eth driver ;)

The one in the tree right now works for single cpus, but
a) is ugly
b) blows up very nicely with SMP.


The _galileo tree was created to keep us from thrashing in _devel with a
bunch of crappy (but working) code.

FYI, I am about ready to merge Zuma's gt64260_mpsc driver to 2_4_devel
since it seems to work reasonably well, and the code is mostly sane. If
you have another mpsc driver, speak now or forever hold your peace.

--
Troy Benjegerdes | master of mispeeling | 'da hozer' |  hozer@drgw.net
-----"If this message isn't misspelled, I didn't write it" -- Me -----
"Why do musicians compose symphonies and poets write poems? They do it
because life wouldn't have any meaning for them if they didn't. That's
why I draw cartoons. It's my life." -- Charles Schulz

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
