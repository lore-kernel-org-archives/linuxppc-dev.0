Return-Path: <jonsmirl@gmail.com>
Message-ID: <9e4733910710240823v2022661ftb1b754a86cab88f3@mail.gmail.com>
Date: Wed, 24 Oct 2007 11:23:40 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
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
> > The DTC experts need to tell us which way to make the pointers between
> > i2s and i2c for the codec.  Here's a another way it could be done that
> > looks more like the ac97 model.
>
> I *really* don't think this is a good idea.  Put the node on the bus
> that the device is addressed from.  I2S is the *data* path, not the
> *control* path, but you cannot control the codec from there.
>
> Your suggestion only looks more like the AC97 model if you're looking
> at the data path.  If you're looking at the control path it looks
> completely different.  The device tree convention is to orient around
> the control path.

It doesn't make any difference to me which one we pick. I'm just
listing all of the possible combinations. I just want to pick a model
so that we can write the code.

I see your point about putting the child node onto the control bus.
ac97 is both a control and data bus. For the i2s case the child should
go onto the i2c bus.

-- 
Jon Smirl
jonsmirl@gmail.com
