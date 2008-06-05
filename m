Return-Path: <dgibson@ozlabs.org>
Date: Fri, 6 Jun 2008 08:46:24 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Timur Tabi <timur@freescale.com>
Subject: Re: "cell-index" vs. "index" vs. no index in I2C device nodes
Message-ID: <20080605224624.GD30980@yookeroo.seuss>
References: <20080604231641.786bb2dd@lappy.seanm.ca>
	<200806050822.00797.sr@denx.de>
	<4848036D.5060004@freescale.com> <484809D1.2070300@scram.de>
	<48480B3C.9080101@freescale.com>
	<fa686aa40806050910m2057966csc33b2a671c6265af@mail.gmail.com>
	<484811DE.9@freescale.com> <484812B9.3040300@scram.de>
	<fa686aa40806050930r12827baod5d742959c982d0c@mail.gmail.com>
	<48481705.9080107@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <48481705.9080107@freescale.com>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Sean MacLennan <smaclennan@pikatech.com>,
	Jean Delvare <khali@linux-fr.org>, Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jun 05, 2008 at 11:40:37AM -0500, Timur Tabi wrote:
> Grant Likely wrote:
> 
> > 2) for i2c purposes, explicit enumeration is not needed or desired.
> > All the necessary data is already present in the device tree in that
> > i2c device nodes are children of i2c bus nodes.  The i2c bus numbers
> > should be dynamically assigned.
> 
> NACK.  For ASoC driver, they cannot be dynamically assigned.  I2C1 must be
> labeled as such.

So use aliases, this is exactly what they're for.  How many times do
Grant and I have to say it?

A fallback to cell-index and/or index is acceptable, for easier
compatibility with existing trees, but aliases must be the primary
method for assigning system-wide numbers.


-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
