Return-Path: <davem@davemloft.net>
Date: Thu, 21 Aug 2008 21:37:47 -0700 (PDT)
Message-Id: <20080821.213747.159824681.davem@davemloft.net>
To: grant.likely@secretlab.ca
Subject: Re: [PATCH 0/3]: Sparc OF I2C support.
From: David Miller <davem@davemloft.net>
In-Reply-To: <fa686aa40808212134l1e226845q41831ee567bb1a2@mail.gmail.com>
References: <48AE4093.8050504@firmworks.com>
	<fa686aa40808212130l365c6f5eu767b9969c8171e2@mail.gmail.com>
	<fa686aa40808212134l1e226845q41831ee567bb1a2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: wmb@firmworks.com, linuxppc-dev@ozlabs.org, sparclinux@vger.kernel.org,
	devicetree-discuss@ozlabs.org, scottwood@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: "Grant Likely" <grant.likely@secretlab.ca>
Date: Thu, 21 Aug 2008 22:34:31 -0600

> On Thu, Aug 21, 2008 at 10:30 PM, Grant Likely
> <grant.likely@secretlab.ca> wrote:
> > On Thu, Aug 21, 2008 at 10:29 PM, Mitch Bradley <wmb@firmworks.com> wrote:
> >> Hi, I wrote most of 1275.
> >>
> >> Mitch Bradley  (wmb@firmworks.com)
> >
> > Hi Mitch,
> >
> > What is your suggestion.  Where should we be discussing new device
> > tree bindings?  Whether it be real Open Firmware, or flattened device
> > tree, or something in between
> 
> ...and along those lines: is there a place for documenting new
> bindings?  Lacking anything better, those of us in PowerPC-Linux-land
> have been adding documentation to Documentation/powerpc/dts-bindings/*
> in the Linux kernel tree.

In a discussion I am having with Greg Onufer, David K. and Tayfun
at Sun, Greg said the some of the newer binding documents are
being published on the opensolaris site, and he is trying to
get some of the older cases (like this I2C one) published there
too.
