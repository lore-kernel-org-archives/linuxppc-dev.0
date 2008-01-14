Return-Path: <dgibson@ozlabs.org>
Date: Tue, 15 Jan 2008 10:21:04 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: I2C and CAN bus on MPC5200B device tree
Message-ID: <20080114232104.GA20649@localhost.localdomain>
References: <478A967E.7080201@genesi-usa.com>
	<fa686aa40801131635o499c8c08i6a2667cd7df1a72e@mail.gmail.com>
	<478B18D9.6020201@grandegger.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <478B18D9.6020201@grandegger.com>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jan 14, 2008 at 09:10:01AM +0100, Wolfgang Grandegger wrote:
> Grant Likely wrote:
> > On 1/13/08, Matt Sealey <matt@genesi-usa.com> wrote:
> >> Hi guys,
> >>
> >> I know the I2C stuff is up in the air (I cannot pinpoint the documentation
> >> for it) and have not found any CAN bus documentation for device trees.
> >>
> >> I want to update the firmware tree to add these but, am basically looking
> >> for those docs, or someone to go over a few points.. is there some kind of
> >> tree standard I should be looking at, or some patch I missed which has
> >> a driver which implements something that looks at a compatible tree?
> > 
> > I think some consensus has been achieved for describing i2c busses and
> > their attached devices, but I don't think booting-without-of.txt has
> > been updated with the details yet.  I need to look into that more.
> > 
> > I don't think anyone has tackled CAN.  Best bet is to draft a tree in
> > the way you think it should be described and post it to the list.
> > That will give a starting point for us to discuss it and come to
> > consensus.
> 
> For MSCAN on the MPC5200 we currently have:
> 
> 		mscan@900 {
> 			device_type = "mscan";

These device_type entries should not be here.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
