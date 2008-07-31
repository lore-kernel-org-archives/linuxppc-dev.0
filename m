Return-Path: <timur@freescale.com>
Message-ID: <48922A32.9080503@freescale.com>
Date: Thu, 31 Jul 2008 16:10:10 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH] powerpc: i2c-mpc: make speed registers configurable via
	FDT
References: <20080731182810.GB29097@secretlab.ca>	
	<48921888.3020900@grandegger.com> <48921954.4020103@freescale.com>	
	<48921DED.6010403@grandegger.com>	
	<9e4733910807311332q611b43b3y26f64b5269ccb657@mail.gmail.com>	
	<fa686aa40807311335t1dd123d0mc385234ebe55248@mail.gmail.com>	
	<48922273.6070801@freescale.com>
	<20080731204838.GA29834@secretlab.ca>	
	<9e4733910807311355q3394b4bfg66c37055384451f7@mail.gmail.com>	
	<48922715.2000304@freescale.com>
	<9e4733910807311403o63c37366ldae30e873f33a21e@mail.gmail.com>
In-Reply-To: <9e4733910807311403o63c37366ldae30e873f33a21e@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Scott Wood <scottwood@freescale.com>, Linux I2C <i2c@lm-sensors.org>,
	Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jon Smirl wrote:

> But that's the same as saying we should copy the system clock
> frequency into all of the PSC nodes because we might implement
> hardware where they aren't all clocked off from the same input clock
> source.

The I2C clock is only visible to the I2C devices.  The system clock is seen by
many devices.  There's the difference.

>>  > Aren't we talking about the /2 or /3 or /1 divider that appears to be
>>  > randomly implemented on various members of the mpc8xxx family?
> 
> I don't this these dividers or clocks need to be exposed at all if
> you'd just put that ugly code snippet into your platform driver.

That's why I don't think the divider belongs in the device tree.  Just put the
actual resulting clock frequency in the device tree.

Besides, putting that snippet in the platform driver *is* exposing it.

-- 
Timur Tabi
Linux kernel developer at Freescale
