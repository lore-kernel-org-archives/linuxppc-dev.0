Return-Path: <dgibson@ozlabs.org>
Date: Thu, 6 Nov 2008 10:36:17 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jochen Friedrich <jochen@scram.de>
Subject: Re: [PATCH] i2c-cpm: Add flexibility for I2C clock frequency and
	filter.
Message-ID: <20081105233617.GC28465@yookeroo.seuss>
References: <490A84F8.20403@consentry.com> <490AEEBF.9000707@scram.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <490AEEBF.9000707@scram.de>
Cc: linuxppc-dev@ozlabs.org, i2c@lm-sensors.org,
	Mike Ditto <mditto@consentry.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Oct 31, 2008 at 12:40:47PM +0100, Jochen Friedrich wrote:
> Hi Mike,
> 
> > This patch adds the ability to enable the digital filter in the device
> > tree (with the "clock-filter" boolean property) and automates the
> > predivider selection according to the clock-frequency and clock-filter
> > properties.
> 
> looks good.
> 
> David, is "clock-filter" an appropriate dts property for this purpose or
> would you prefer a different name?

Hrm, well the name seems fine, but then, device-specific properties
are device-specific so it's pretty much up to the device binding to
pick a name.

What does worry me, however, is the description says it's about
whether the driver "should" enable the filter.  Generally the device
tree doesn't attempt to say what users "should" do with the hardware,
just what the characteristics of the hardware are.

What's the underlying difference here that affects the driver's choice
to enable the filter or not?

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
