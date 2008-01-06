Return-Path: <dgibson@ozlabs.org>
Date: Sun, 6 Jan 2008 11:46:37 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [alsa-devel] [PATCH] ASoC drivers for the Freescale MPC8610 SoC
Message-ID: <20080106004637.GJ4326@localhost.localdomain>
References: <11981089894052-git-send-email-timur@freescale.com>
	<9e4733910801010925j67192427o4e0e824b9d7e0ad0@mail.gmail.com>
	<9e4733910801010942y47e4cdbfge5e0d3e44ab96760@mail.gmail.com>
	<477BAB67.4080003@freescale.com>
	<9e4733910801020734n115888cbt86351f67f2311629@mail.gmail.com>
	<477D2150.4020506@freescale.com>
	<20080103235156.GE12883@localhost.localdomain>
	<477EEDFA.9010205@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <477EEDFA.9010205@freescale.com>
Cc: Liam Girdwood <liam.girdwood@wolfsonmicro.com>, alsa-devel@alsa-project.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jan 04, 2008 at 08:39:54PM -0600, Timur Tabi wrote:
> David Gibson wrote:
> 
> > And what distinction are you drawing between "first" and "second"
> > here? 
> 
> Oh, that's an easy one:  The CS4270 can work without an I2C or SPI connection, 
> but it will never work without an I2S connection.
> 
> > Why would the I2S need to scan for codecs?  Wouldn't it be up to the
> > codec driver to register with I2S?
> 
> Not in ASoC V1.  The codec driver registers with ASoC, but the actual 
> connection to other devices (e.g. the I2S driver) is done either in the I2S 
> driver or in the fabric driver, depending on your mood.  And that connection 
> is done via a pointer to a structure in the codec driver.

Ok, but couldn't you strucutre your I2S or fabric driver so that it
only becomes fully operational once the codec driver has registered
with it?

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
