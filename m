Return-Path: <glikely@secretlab.ca>
Message-ID: <fa686aa40807311330u6858ae60haadf3c4d5996100e@mail.gmail.com>
Date: Thu, 31 Jul 2008 14:30:34 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Timur Tabi" <timur@freescale.com>
Subject: Re: [PATCH] powerpc: i2c-mpc: make speed registers configurable via
	FDT
In-Reply-To: <48921E44.7010502@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <4889EFFE.2070201@grandegger.com> <489200B6.9060906@freescale.com>
	<20080731182810.GB29097@secretlab.ca>
	<48920607.5040606@freescale.com>
	<48921187.1090101@grandegger.com> <48921179.1080403@freescale.com>
	<48921888.3020900@grandegger.com> <48921954.4020103@freescale.com>
	<48921DED.6010403@grandegger.com> <48921E44.7010502@freescale.com>
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

On Thu, Jul 31, 2008 at 2:19 PM, Timur Tabi <timur@freescale.com> wrote:
> Wolfgang Grandegger wrote:
>
>> I'm a bit confused. The frequency of the I2C source clock and the real
>> I2C clock frequency are two different things.
>
> There are two frequencies:
>
> 1) The frequency of the input clock to the I2C device, after it has gone through
> a divider.  This is what I call the "I2C clock frequency" and what I think
> belongs in the clock-frequency property.  This is usually the platform clock
> divided by 1, 2, or 3.
>
> 2) The speed of the I2C bus, as seen by devices on that bus.  This is usually
> 400KHz.

analogous example: serial nodes use two properties; "clock-frequency"
and "current-speed", one for clock frequency routed into the device
and one for the current baud rate.  It is completely relevant to put
the effective clock frequency into the i2c device node.

g.
