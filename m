Date: Fri, 28 Apr 2000 00:32:07 -0400
From: Clint Hepner <chepner@cs.dartmouth.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: VRAM detection in controlfb.c
Message-ID: <20000428003147.A688@cs.dartmouth.edu>
References: <20000427233956.A604@cs.dartmouth.edu> <20000428000745.A853@drow.res.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20000428000745.A853@drow.res.cmu.edu>; from drow@false.org on Fri, Apr 28, 2000 at 12:07:45AM -0400
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Apr 28, 2000 at 12:07:45AM -0400, Daniel Jacobowitz wrote:
>
> On Thu, Apr 27, 2000 at 11:39:59PM -0400, Clint Hepner wrote:
> >
> > I recently added another 2MB of VRAM to my PM8500
> > with control video, and was dismayed when linux wouldn't
> > recognize it.  I remembered some discussion on this
> > issue about a month ago, but I haven't seen anything
> > since then.
> >
> > I got the most recent version of the stable kernel,
> > 2.2.15_pre20, and poked around a bit to try to understand
> > what was going on.  In the end, I just hardcoded the value
> > of bank2 after line 725 in controlfb.c to 1, to
> > override the kernel's failure to detect the memory
> > in bank 2. It worked; I can now drive my 17" monitor at
> > 1280x1024 @16bpp.
> >
> > My question is, is the problem only with detecting the
> > VRAM, or could there be problems addressing the VRAM as
> > well if the kernel isn't able to detect it on its own.
>
> No, there shouldn't be any problems.
>
> Two things:  pre20 from Linus or from Cort's tree or from one of the
> others?  Also, could I persuade you to see if 2.3 detects the memory
> properly?

I got pre20 from Paul's tree, at linuxcare.com.au. I can try a 2.3
kernel, but probably not until Monday.

Clint Hepner
Dartmouth College

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
