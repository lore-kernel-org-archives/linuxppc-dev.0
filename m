Return-Path: <dgibson@ozlabs.org>
Date: Thu, 10 Jan 2008 14:13:31 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: How complete should the DTS be?
Message-ID: <20080110031331.GF17816@localhost.localdomain>
References: <4782DAD8.1080104@pikatech.com>
	<86AA8535-E2CF-4891-900B-340049A5CA19@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <86AA8535-E2CF-4891-900B-340049A5CA19@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jan 08, 2008 at 12:04:36AM -0600, Kumar Gala wrote:
> 
> On Jan 7, 2008, at 8:07 PM, Sean MacLennan wrote:
> 
> > Just a general question about DTS "completeness". Like all 440EP
> > processors, the taco has two i2c buses. However, only one bus has
> > anything connected to it.
> >
> > Should I show both bus entries in the DTS, or only the one that is  
> > used?
> > I have generally only been showing the devices that are present. i.e.
> > Only one emac, only one serial port.
> >
> > Is there a convention for this?
> 
> The .dts should reflect the HW as its used.  On some reference boards  
> we might put out more info because of the various configs these types  
> of boards can be setup in.  However if something has a static config  
> just describe that.  So in your example of two i2c buses with only one  
> connected, just describe the one that is used.

Hrm... I'd say this is not something which has a firm convention yet.

It's going to become more of an issue once we get a macros system for
dtc, so the "440EP" macro would have all the devices, even if some are
not connected on a given board.

I'm contemplating suggesting that we adopt the "status" property from
IEEE1275 to cover this.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
