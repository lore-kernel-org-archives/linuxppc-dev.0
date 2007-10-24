Return-Path: <jonsmirl@gmail.com>
Message-ID: <9e4733910710240828x412f598dy7fc4a75faa76358d@mail.gmail.com>
Date: Wed, 24 Oct 2007 11:28:27 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: Audio codec device tree entries
In-Reply-To: <fa686aa40710240820l62d5a50ewcd7707fed8f9176f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910710221859q6ea54810nba58907d5ddd966d@mail.gmail.com>
	<471E12C7.8020509@freescale.com>
	<8416ea754e013a67441aec778c81ad73@kernel.crashing.org>
	<9e4733910710231529h1089eacdy888306f20af92555@mail.gmail.com>
	<471F52ED.10007@freescale.com>
	<9e4733910710240800y24952e70g8c318e35e2e45e2e@mail.gmail.com>
	<fa686aa40710240816l6187b559l31fb72656ec265c@mail.gmail.com>
	<fa686aa40710240820l62d5a50ewcd7707fed8f9176f@mail.gmail.com>
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
> > Two valid methods have been proposed
> > 1. a codec-
>
> oops
>
> 1. a codec-handle property in the i2s node
> 2. an i2s-handle property in the codec node
>
> Either are reasonable.  I prefer putting the handle in the i2s node;
> but I'm looking at it from the way that ethernet phys are being
> described currently.  The other is also perfectly valid.
>
> I suppose it depends on what point of view you see the system from; either:
> a. the codec is supported by the i2s bus, in which case use the
> i2s-handle property
> b. the i2s bus is supported by the codec; in which case use the
> codec-handle property.

Do you want to pick one and add it to the device tree documentation
with an example for i2s and ac97? I'll use which ever one is picked.

-- 
Jon Smirl
jonsmirl@gmail.com
