Message-ID: <005c01c2054a$e3fb2100$e1a8459b@ntu.edu.sg>
From: "shaowei dai" <dshaowei@rfnetech.com>
To: <linuxppc-embedded@lists.linuxppc.org>
References: <003801c20543$b90a4180$e1a8459b@ntu.edu.sg> <20020527063451.GL16537@zax>
Subject: Re: map iomem in linux_2_4_dev
Date: Mon, 27 May 2002 14:51:12 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello, David:

Thanks for your reply.  When use ioremap,  it seems you can only know the
virtual address of this mapped address
at runing time. Then for PCMICA package, how can you pass this virtual
address when you compile
that package?  Am i wrong in understanding pcmcia package io memory
requirement? If i'm wrong, could you give me
some reference site to learn more?

regards
shaowei

----- Original Message -----
From: "David Gibson" <david@gibson.dropbear.id.au>
To: <linuxppc-embedded@lists.linuxppc.org>
Sent: Monday, May 27, 2002 2:34 PM
Subject: Re: map iomem in linux_2_4_dev


>
> On Mon, May 27, 2002 at 01:59:54PM +0800, shaowei dai wrote:
> >
> > Hello, every one:
> >
> > I've searched through the achieve, but failed to find stuff about
mapping
> > io-memmory in this linux_2_4_dev version.
> > After check the source code, it seems from 2_4_dev onwards, no need to
use
> > ioremap to map io memory. We
> > should use io_block_mapping() instead.
>
> No, you should use ioremap() wherever possible.  Only use
> io_block_mapping() if for some strange reason you need to specify the
> virtual address.
>
> --
> David Gibson | For every complex problem there is a
> david@gibson.dropbear.id.au | solution which is simple, neat and
> | wrong.  -- H.L. Mencken
> http://www.ozlabs.org/people/dgibson
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
