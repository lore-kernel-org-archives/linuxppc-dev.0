Message-Id: <4.2.2.20040519100820.0509a590@bhawley.mailhost.luminex.com>
Date: Wed, 19 May 2004 10:09:16 -0700
To: "Mark Chambers" <markc@mail.com>
From: Brian Hawley <bhawley@luminex.com>
Subject: Re: Ebony Board, PPC440GP and NFS panics
Cc: <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <016601c43dc8$030d66e0$0301a8c0@chuck2>
References: <4.2.2.20040518092928.05070d90@bhawley.mailhost.luminex.com>
 <4.2.2.20040518092928.05070d90@bhawley.mailhost.luminex.com>
 <4.2.2.20040519091201.05090ce0@bhawley.mailhost.luminex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thanks.

In a previous kernel, I had sync'd up the bd_t...but in the 2.5-ocp,
I did not add the "defined(CONFIG_440)" to the 405 around the
ethernet section.

Not out of the woods yet...but a little closer.

Thanks.

At 01:37 PM 5/19/04 -0400, Mark Chambers wrote:

>We think that is because linux is thinking the MAC address is
> > ff:ff:ff:ff:ff:ff instead of what
> > it really is.  u-boot doesn't seem to have a problem getting the MAC
> > address out of the ebony board, but
> > this linux kernel seems to.
> >
>
>A MAC address of  ff:ff:ff:ff:ff:ff  is the broadcast address, so that's a
>problem.  I'm not familiar with 440, but the thing is, you've got to find
>your ethernet specific code in the kernel and see where it's getting the MAC
>from.  u-boot passes a bd_t pointer to the kernel (a struct with a bunch of
>board data), but there's probably some kind of mis-match between u-boot and
>the platform config of the kernel.
>
>Mark Chambers
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
