Date: Sun, 23 Apr 2000 21:56:49 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Dan Malek <dan@netx4.com>
cc: Brad Parker <brad@parker.boston.ma.us>,
        linuxppc-embedded@lists.linuxppc.org
Subject: Re: CONFIG_ALL_PPC
In-Reply-To: <39034610.7556461F@embeddededge.com>
Message-ID: <Pine.HPX.4.10.10004232152510.19933-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Sun, 23 Apr 2000, Dan Malek wrote:

>
> Brad Parker wrote:
>
> > Is CONFIG_ALL_PPC really "all ppc" or is it really "all macintosh platforms"?
>
> It is really used to build a kernel that you want to boot on "all
> PPC platforms."  I don't build any of the embedded systems with this,
> althought I suppose (if you _really_ wanted this :-) you could get
> the same binary to boot on the 8xx as the G4....It's not on my list
> of things to do.

There is no way to make CONFIG_ALL_PPC working as claimed, it actually
means all desktop PPC (my VME PreP boards use it). Embedded PPC are so
different, especially wrt MMU (page tables versus hash tables, some
umay use bats, while the other ahve variable size TLB entries...)
that is would be very complex to implement and probably not worth
the effort.

	Gabriel.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
