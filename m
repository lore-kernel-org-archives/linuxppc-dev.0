Date: Fri, 4 Jun 1999 14:19:25 -0500 (CDT)
From: Mark Lin <mlin@MPI-Softtech.Com>
To: Michael Meissner <meissner@cygnus.com>
cc: Adrian Cox <apc@agelectronics.co.uk>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Support for Motorola Platforms
In-Reply-To: <19990604115920.A3331@tiktok.cygnus.com>
Message-ID: <Pine.SOL.4.05.9906041418520.24129-100000@mpi.mpi-softtech.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



Where did you get these patches?  Are they available to the public?

--
Mark Lin
MPI Software Technology, Inc.

On Fri, 4 Jun 1999, Michael Meissner wrote:

> 
> On Fri, Jun 04, 1999 at 03:37:13PM +0100, Adrian Cox wrote:
> > 
> > Johnnie Peters wrote:
> > > Motorola has a new version of the MVME2400 with the MAX processor and
> > > as soon as I can get my hands on one I will do the work to get Linux
> > > to run on it.  Plans are also underway for new versions of the MTX
> > > series
> > > supporting the MAX processor.
> > 
> > Has anybody started work on GNU tools and kernel porting for Altivec
> > processors? The issues I see are:
> > (1) Altivec intructions in gas, so I don't have to enter the codes by
> > hand.
> > (2) Linux Kernel patches to load/save Altivec registers. These are large
> > enough that a lazy load/save might be useful.
> > (3) (Questionable) Patches to EGCS to support the C extensions that
> > Motorola specify in the Altivec PIM. I detest C extensions that add the
> > keyword "vector", but all Motorola's example code uses them.
> 
> I have patches from Motorola to add Altivec support to egcs 1.0.3.  I haven't
> been in PowerPC mode recently and haven't looked at them.
> 
> > All of these can be done based on documentation from Motorola's website.
> > I suspect that (1) has already happened inside some RTOS vendors, but
> > will take a long time to filter into the standard releases.
> > 
> > - Adrian Cox
> 
> 
> -- 
> Michael Meissner, Cygnus Solutions
> PMB 198, 174 Littleton Road #3, Westford, Massachusetts 01886
> email: meissner@cygnus.com	phone: 978-486-9304	fax: 978-692-4482


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
