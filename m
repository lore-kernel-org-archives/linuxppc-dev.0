Return-Path: <timur@freescale.com>
Message-ID: <489219F7.4020406@freescale.com>
Date: Thu, 31 Jul 2008 15:00:55 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] powerpc: i2c-mpc: make speed registers configurable	via
	FDT
References: <4891F4D8.9090905@grandegger.com>
	<fa686aa40807311031r66f6451aw206faf54509c14d9@mail.gmail.com>
	<4891FC3A.7040609@freescale.com>
	<20080731180959.GA29057@secretlab.ca>
	<489200B6.9060906@freescale.com>
	<20080731182810.GB29097@secretlab.ca>
	<48920607.5040606@freescale.com> <48921187.1090101@grandegger.com>
	<48921179.1080403@freescale.com> <48921888.3020900@grandegger.com>
	<20080731195911.GA29610@secretlab.ca>
In-Reply-To: <20080731195911.GA29610@secretlab.ca>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Scott Wood <scottwood@freescale.com>, Linuxppc-dev@ozlabs.org,
	Linux I2C <i2c@lm-sensors.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:

> Ugh.  This is specifically related to the i2c device, so please place
> the property in the i2c device.  Remember, device tree design is not
> about what will make the implementation simplest, but rather about what
> describes the hardware in the best way.

His proposal would make the implementation less simple, not more simple.

> Now, if you can argue that i2c-clock-frequency is actually a separate
> clock domain defined at the SoC level, not the i2c device level, then I
> will change my opinion.

It isn't.  I don't have the Verilog for the I2C device, but I'm pretty sure the
divider is a very simple circuit that's located just outside the I2C circuitry,
but it still unique to the I2C device.  There is no "I2C clock" running through
the SOC.

-- 
Timur Tabi
Linux kernel developer at Freescale
