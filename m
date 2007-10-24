Return-Path: <glikely@secretlab.ca>
Message-ID: <fa686aa40710240820l62d5a50ewcd7707fed8f9176f@mail.gmail.com>
Date: Wed, 24 Oct 2007 09:20:44 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Audio codec device tree entries
In-Reply-To: <fa686aa40710240816l6187b559l31fb72656ec265c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910710221859q6ea54810nba58907d5ddd966d@mail.gmail.com>
	<471E12C7.8020509@freescale.com>
	<8416ea754e013a67441aec778c81ad73@kernel.crashing.org>
	<9e4733910710231529h1089eacdy888306f20af92555@mail.gmail.com>
	<471F52ED.10007@freescale.com>
	<9e4733910710240800y24952e70g8c318e35e2e45e2e@mail.gmail.com>
	<fa686aa40710240816l6187b559l31fb72656ec265c@mail.gmail.com>
Cc: PowerPC dev list <Linuxppc-dev@ozlabs.org>,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/24/07, Grant Likely <grant.likely@secretlab.ca> wrote:
> On 10/24/07, Jon Smirl <jonsmirl@gmail.com> wrote:
> > On 10/24/07, Timur Tabi <timur@freescale.com> wrote:
> > > Jon Smirl wrote:
> > > > Is this consensus on how the tree should look?
> > > >
> > > > There is no attempt to describe the codec connections inside the
> > > > device tree.
> > >
> > > I don't think I agree with that.  The device tree should indicate which codec is
> > > connected to which I2S/AC97 device.
> >
> > What I meant was that there is no attempt to describe how the codec is
> > connected to the external world. Those connections are described in
> > the fabric driver.
> >
> > I'm getting conflicting opinions on how the devices should be linked
> > into the tree. We should pick one and add it to the documentation.
>
> Two valid methods have been proposed
> 1. a codec-

oops

1. a codec-handle property in the i2s node
2. an i2s-handle property in the codec node

Either are reasonable.  I prefer putting the handle in the i2s node;
but I'm looking at it from the way that ethernet phys are being
described currently.  The other is also perfectly valid.

I suppose it depends on what point of view you see the system from; either:
a. the codec is supported by the i2s bus, in which case use the
i2s-handle property
b. the i2s bus is supported by the codec; in which case use the
codec-handle property.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
