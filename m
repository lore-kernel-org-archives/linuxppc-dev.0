From: Brian Waite <waite@skycomputers.com>
To: Gary Thomas <gary@mlbassoc.com>
Subject: Re: Disable cache on 74xx
Date: Thu, 20 Feb 2003 09:09:50 -0500
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
References: <200302191552.01911.waite@skycomputers.com> <200302200855.12224.waite@skycomputers.com> <1045749699.18487.7532.camel@hermes.chez-thomas.org>
In-Reply-To: <1045749699.18487.7532.camel@hermes.chez-thomas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200302200909.50420.waite@skycomputers.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Gary,
	Thanks for the clarification. I appreciate the real life experiences. This is
exactly why I said "in the User Manual". I was hoping you would come back
with the exact answer you provided. :) I'll keep my eyes open.

Thanks
Brian
On Thursday 20 February 2003 9:01 am, Gary Thomas wrote:
> On Thu, 2003-02-20 at 06:55, Brian Waite wrote:
> > According to The User's Manual, the data cache instructions become no-ops
> > if the data cache is disabled.
>
> There are "User Manuals" and then there is "Real Life".  My
> experience has been that trying to execute these instructions
> with the cache disabled was treated like an invalid instruction
> (hence causing a trap).  Maybe this isn't always true with all
> PowerPC processors, but I was just pointing out that you might
> run into trouble with it.
>
> > Thanks
> > Brian
> >
> > On Wednesday 19 February 2003 5:48 pm, Gary Thomas wrote:
> > > On Wed, 2003-02-19 at 14:07, Benjamin Herrenschmidt wrote:
> > > > On Wed, 2003-02-19 at 21:52, Brian Waite wrote:
> > > > > Hi all,
> > > > > 	I am trying to hunt down a memory controller configuration problem
> > > > > and I have been asked to disable all caching so as to remove it
> > > > > from the equation. I can easl disable L2 but when I start ucking
> > > > > with the WIMG bits to set cache inhibit, The kernel panics with
> > > > > stack overflows. Does anyone know where or what I have to set to
> > > > > disable caching?
> > > >
> > > > Hrm... set L2 and L3 off, then hack HID0 to disable L1 ?
> > >
> > > There are other problems with this.  With the caches disabled
> > > (via HID0) all data cache instructions (like DCBF) will fail.
> > > There are some of these in the kernel itself, but beware that
> > > GLIBC has it's own set.
> > >
> > > ... totally disabling the data CACHE with Linux is non-trivial.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
