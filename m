Return-Path: <scottwood@freescale.com>
Message-ID: <48922707.5020107@freescale.com>
Date: Thu, 31 Jul 2008 15:56:39 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH] powerpc: i2c-mpc: make speed registers configurable via
	FDT
References: <20080731182810.GB29097@secretlab.ca>	
	<48921187.1090101@grandegger.com> <48921179.1080403@freescale.com>	
	<48921888.3020900@grandegger.com> <48921954.4020103@freescale.com>	
	<48921DED.6010403@grandegger.com>	
	<9e4733910807311332q611b43b3y26f64b5269ccb657@mail.gmail.com>	
	<fa686aa40807311335t1dd123d0mc385234ebe55248@mail.gmail.com>	
	<48922273.6070801@freescale.com>
	<20080731204838.GA29834@secretlab.ca>
	<9e4733910807311355q3394b4bfg66c37055384451f7@mail.gmail.com>
In-Reply-To: <9e4733910807311355q3394b4bfg66c37055384451f7@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>,
	Linux I2C <i2c@lm-sensors.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jon Smirl wrote:
> Isn't there a single global divider that generates all the i2c source
> clocks? You don't want to copy a global value into each i2c node.

Why not?  The "compatible" is pretty much always going to be the same 
for the i2c node, but we copy that, as well.

Likewise for the clock-frequency of serial nodes.

-Scott
