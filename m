Date: Fri, 9 May 2003 01:17:17 +0300 (IDT)
From: Eitan Rabin <rabin@mellanox.co.il>
To: Joakim Tjernlund <Joakim.Tjernlund@lumentis.se>
Cc: Steven Blakeslee <BlakesleeS@embeddedplanet.com>,
	<linuxppc-embedded@lists.linuxppc.org>
Subject: Re: MPC860 and I2C
In-Reply-To: <003101c315a8$4766e300$020120b0@jockeXP>
Message-ID: <506C3D7B14CDD411A52C00025558DED60301A75A-100000@mtlex01.yok.mtl.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The message in var log messages is:

I2C uCode patch installed

I checked multiple times that the patch was applied correctly and it seems
it has. I verified that the CPM traps were set correctly as well.

The cpu version I'm using is 860PZP50D4, so I think that I should be able
to generate I2C cycles using the CPM in this version.

I tried the patch that is in the driver with the same results.

My impression is that when the SDMA channel is used for descriptors of
the I2C driver, there is a fatal error for certain address ranges. I was
looking for some general configuration that can cause such behavior by
couldn't find any.

Did someone succeeded to have this working on CLLF embeddedplanet cards
SBC860H ?

Did someone succeeded with other cards? I might need to consider using
other brands, I'll appreciate any recommendation.

Thanks

Eitan



On Thu, 8 May 2003, Joakim Tjernlund wrote:

> > The version of CPU I has requires the patch to solve the conflict  between
> > the ram parameters of I2C/SPI and those of Ethernet. I checked my version
> > against the errata at Motorola's website and it is required.
> >
> > If I don't use the relocation then the command has not effect. If I use the
> > patch then there are i2c transaction being generated but I can only use
> > certain addresses.
> >
> > Any advice will be appreciated.
>
> What CPU revison do you have? Older CPUs than D4 has a lot of I2C bugs.
> If you have an older CPU, try enabling the chip errata code in the i2c driver.
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
