Date: Wed, 13 Oct 1999 16:54:46 -0500
From: Grant Erickson <grant@lcse.umn.edu>
To: Wolfgang Denk <wd@denx.de>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Support for IBM CPU's ? 
In-Reply-To: <199910132113.XAA31067@denx.local.net>
Message-ID: <Pine.SGI.4.10.9910131642180.69115-100000@brule.lcse.umn.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, 13 Oct 1999, Wolfgang Denk wrote:
> In message <Pine.SGI.4.10.9910130949280.12784-100000@brule.lcse.umn.edu> you write:
> > > I have a question regarding the IBM 403GCX, is this CPU supported by
> ...
> > At present, no. However, with ever so halting and slow progress (not due
> > to difficulty, just general lack of time and resources), I'm trying to add
> > in support for the 403GCX.
> ...
> > 3) The virtual memory and cache interface is entirely different, meaning
> >    that NONE of the 6xx, 7xx, or 8xx work can be leveraged here.
> 
> But Linux has already been ported to the 403; it's  even  running  in
> commercial  products  like  TiVo  on  a  403.  How much difference is
> between the 403xx models?

I knew that TiVo ran Linux, but I was under the impression that Tivo was
an x86 platform. If it is indeed a 403xx, I stand corrected. Where does
the kernel support lie for it? It's not in the 2.3.21 tree or the vger
tree.

The difference between the 403A, B, C, GC, and GCX variants are the
quantity of I- and D-cache, the presence or lack of an MMU, the presence
or lack of an on-chip serial port, and the number of DMA channels.

Regards,

Grant


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
