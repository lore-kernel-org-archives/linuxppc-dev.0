Date: Thu, 3 Oct 2002 11:12:33 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: very minor 405GP and 405GPr PCI difference
Message-ID: <20021003011233.GC1102@zax>
References: <OF8DC4E66D.5C36B7D3-ON87256C41.00434ACB@boulder.ibm.com> <20020930040143.GF10265@zax> <20021001052121.GV10265@zax> <3D995EC0.2000500@elsoft.ch> <20021002014219.GF1848@zax> <3D9AA452.5070004@elsoft.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3D9AA452.5070004@elsoft.ch>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Oct 02, 2002 at 09:46:26AM +0200, "David M?ller (ELSOFT AG)" wrote:
>
> David Gibson wrote:
> >On Tue, Oct 01, 2002 at 10:37:20AM +0200, "David M?ller (ELSOFT AG)" wrote:
> >
> [stuff deleted]
> >>
> >>In your proposed patch, i'm missing a way to install a board specify
> >>mapping either by using special constants, callback functions to board
> >>specific code, .... AFAICS all boards are forced to use the same mapping.
> >
> >
> >That's right.  Is there a reason for boards to have different
> >mappings?  I can well believe that there is, but the current tree
> >doesn't show it - all the boards (in the tree) that have PCI appear to
> >do the same initialisation of the windows.  It doesn't seem worthwhile
> >to create board specific PCI initialisation hooks until we have a
> >board that needs it.
>
> Not all boards using LinuxPPC are in the offical tree (yet). I know at
> least two boards which are using a "non-standard" PCI mapping.

Fair enough.  I'm just trying to come up with the simplest approach
that still provides the flexibility we need.  Based on the evidence
immediately available, what I posted seemed like it.  How about you
tell me something about the non-standard PCI mappings, so I can come
up with something better.

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
