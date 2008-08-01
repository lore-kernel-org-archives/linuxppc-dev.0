Return-Path: <xyzzy@speakeasy.org>
Date: Thu, 31 Jul 2008 17:57:24 -0700 (PDT)
From: Trent Piepho <xyzzy@speakeasy.org>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [i2c] [PATCH] powerpc: i2c-mpc: make speed registers	configurable
	via FDT
In-Reply-To: <fa686aa40807311335t1dd123d0mc385234ebe55248@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0807311752300.10341@shell4.speakeasy.net>
References: <4889EFFE.2070201@grandegger.com> <489200B6.9060906@freescale.com>
	<20080731182810.GB29097@secretlab.ca>
	<48920607.5040606@freescale.com>
	<48921187.1090101@grandegger.com> <48921179.1080403@freescale.com>
	<48921888.3020900@grandegger.com> <48921954.4020103@freescale.com>
	<48921DED.6010403@grandegger.com>
	<9e4733910807311332q611b43b3y26f64b5269ccb657@mail.gmail.com>
	<fa686aa40807311335t1dd123d0mc385234ebe55248@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linuxppc-dev@ozlabs.org, Linux I2C <i2c@lm-sensors.org>,
	Scott Wood <scottwood@freescale.com>, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 31 Jul 2008, Grant Likely wrote:
> >>  I'm a bit confused. The frequency of the I2C source clock and the real I2C
> >> clock frequency are two different things. The first one is common for all
> >> I2C devices, the second can be different. What properties would you like to
> >> use for defining both?
>
> How is the divider controlled?  Is it a fixed property of the SoC?

Usually.

> a shared register setting?

Sometimes.

> or a register setting within the i2c device?

Never.


Thinking of it as the CCB divided by 1, 2, 3 isn't really right.  It's just
some internal clock that I2C was connected to.  Sometimes it's the clock
for the ethernet block of the SoC.  Sometimes it comes from some other
block.
