Date: Tue, 5 Oct 1999 10:45:59 -0500
From: anthony tong <atong@uiuc.edu>
To: Charlie McLachlan <cim@uk.research.att.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Do you XF86? Was: ATIRage128
Message-ID: <19991005104558.A21274@mango.genunix.net>
References: <19991004120035.A2956@mango.genunix.net> <Pine.SO4.4.04.9910050925060.25985-100000@marrow>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.SO4.4.04.9910050925060.25985-100000@marrow>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Charlie McLachlan (Tue, Oct 05, 1999 at 09:36:07AM +0100):
> On Mon, 4 Oct 1999, anthony tong wrote:
> > I haven't seen any indications that suse.de has merged their sources with
> > the XFree86-3.x tree.
> 
> from http://www.suse.de/en/support/xsuse/
> 
> "XFree86 complient, in this context, means that the sources to these
> servers are already part of the XFree86 development sources and that
> these servers will be included (with full sources) in one of the next
> XFree86 releases"
> ...
> "Of course, all of them will be integrated into future versions of
> XFree86"

The 3.3.x branch is dead, which XFCom_Rage128 is based off of. The
devel branch is the 3.9x, which has some architectural differences.

> also, from http://www.xfree86.org/snapshots/3.9.16/ati3.html#3, regarding
> the latest develop tree snapshot (3.9.16):
> 
> "The newer Rage 128 chips are not yet supported"

Not yet supported means -exactly- that. XFree86 has no support for
Rage128 in the latest devel tree snapshot (3.9.16b) and in their
CVS tree.  Of course, I'd like to be wrong.. if XFree86 does have
the source, it isn't available to its memebers.

There also been no public response to whether suse's code would be integrated
into the current tree on the devel xfree list.

> The sources are in the development tree, which you can't get if you aren't
> a member of XFree86, and they don't like making people members just so
> they can try out new code.
> 
> So back to the question, Is anyone here a member, and have they tried
> compiling the SUSE code for PPC? 

Yes, there are several linux/ppc developers that are XFree86 developers.
But there is no suse code to port.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
