Message-Id: <4.2.2.20040519163955.04c3a390@bhawley.mailhost.luminex.com>
Date: Wed, 19 May 2004 16:40:48 -0700
To: linuxppc-embedded@lists.linuxppc.org
From: Brian Hawley <bhawley@luminex.com>
Subject: Re: Ebony Board, PPC440GP and NFS time out
In-Reply-To: <20040520001929.GG13351@gate.ebshome.net>
References: <20040519234228.GF13351@gate.ebshome.net>
 <4.2.2.20040519134735.04c20180@bhawley.mailhost.luminex.com>
 <4.2.2.20040519132218.050b0df0@bhawley.mailhost.luminex.com>
 <4.2.2.20040519123513.05074da0@bhawley.mailhost.luminex.com>
 <4.2.2.20040519101456.0509d340@bhawley.mailhost.luminex.com>
 <4.2.2.20040519123513.05074da0@bhawley.mailhost.luminex.com>
 <4.2.2.20040519132218.050b0df0@bhawley.mailhost.luminex.com>
 <4.2.2.20040519134735.04c20180@bhawley.mailhost.luminex.com>
 <4.2.2.20040519143346.04c41220@bhawley.mailhost.luminex.com>
 <4.2.2.20040519145943.04c28200@bhawley.mailhost.luminex.com>
 <20040519234228.GF13351@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thanks.  I checked out the linux-2.5-ocp using the site you recommended
before.  Perhaps
there have been some patches in the last couple months...

However, I will also download from kernel.org's kernel since the ocp stuff
has been merged in.

At 05:19 PM 5/19/04 -0700, Eugene Surovegin wrote:
>On Wed, May 19, 2004 at 04:42:28PM -0700, Eugene Surovegin wrote:
>
>[snip]
>
> > > mal0: Initialized, 4 tx channels, 2 rx channels
> > > emac: IBM EMAC Ethernet driver, version 2.0
> > > Maintained by Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > > zmii0: input 0 in SMII mode
>
>This is quite suspicious (SMII) ^^^^
>
> > > eth0: IBM emac, MAC 00:04:ac:e3:23:b2
> > > eth0: Found Generic MII PHY (0x08)
> > > zmii0: input 1 in RMII mode
>
>... and this (RMII)   ^^^^
>
>[snip]
>
>Please, make sure you are using the latest linux-2.5-ocp or just latest
>kernel.org's kernel (OCP stuff was just merged in).
>
>Eugene


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
