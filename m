Date: Mon, 14 Oct 2002 16:37:49 -0500 (CDT)
From: Bret Indrelee <Bret.Indrelee@qlogic.com>
Reply-To: Bret Indrelee <Bret.Indrelee@qlogic.com>
To: Linux PPC Embedded mailing list <linuxppc-embedded@lists.linuxppc.org>,
	Kumar Gala <kumar.gala@motorola.com>
Cc: Matt Porter <porter@cox.net>, Mark Hatle <fray@mvista.com>
Subject: Re: Binary Compatibility of various flavors of PPC
In-Reply-To: <816F7B3D-DFAF-11D6-A599-003065BFB10E@motorola.com>
Message-ID: <Pine.LNX.4.33.0210141629240.24959-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 13 Oct 2002, Kumar Gala wrote:
> On Monday, October 14, 2002, at 01:15  PM, Matt Porter wrote:
> > On Mon, Oct 14, 2002 at 12:13:52PM -0500, Mark Hatle wrote:
> >> Bret Indrelee wrote:
[ Looking to have compatible System and User binary image ]
> >>> We are currently looking at the 405GPX, 8250, 8245, and PowerQUIC
> >>> III.
[ snip ]
> >> If I was building a range of systems that required varying PowerPC
> >> CPUs with a
> >> common userspace I would stick to the 82xx/7xx/74xx families today.
> >
> > I'd have to agree with that.  Classic PPC core implementations
> > currently
> > offer the broadest selection of userspace binary compatible processors.
>
> I agree, but it depends on how important floating point is to ones
> userspace.  If they do not care about FP then all of the PPC processors
> 4xx/8xx/82xx/7xx/74xx/e500 all provide a compatible integer instruction
> set.

Float isn't important to us, we could have all float be emulated for as
little of it we do.

We need the bzImage.gz and RAM disk image have to be the same binary.

The reason is simple, we don't want the customer to have the mess of
'which of these N firmware images do I need' when trying to upgrade. We
want the whole line of products to use the same binary image.

We want a process that uses lower power and board space processor than
the Intel but still allows us to use the same binary across the line of
products. Our best guess of the performance levels needed are going to
be from about a 300MHz CPU to 800MHz or 1GHz. Having even higher
performance options in the future would be a definate plus.

-Bret

--
Bret Indrelee                 QLogic Corporation
Bret.Indrelee@qlogic.com      6321 Bury Driver, St 13, Eden Prairie, MN 55346


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
