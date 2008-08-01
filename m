Return-Path: <wg@grandegger.com>
Message-ID: <4892BB70.2040106@grandegger.com>
Date: Fri, 01 Aug 2008 09:29:52 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Trent Piepho <xyzzy@speakeasy.org>
Subject: Re: [i2c] [PATCH] powerpc: i2c-mpc: make speed registers configurable
	via FDT
References: <4889EFFE.2070201@grandegger.com> <4891F4D8.9090905@grandegger.com>
	<fa686aa40807311031r66f6451aw206faf54509c14d9@mail.gmail.com>
	<4891FC3A.7040609@freescale.com>
	<20080731180959.GA29057@secretlab.ca>
	<489200B6.9060906@freescale.com>
	<20080731182810.GB29097@secretlab.ca>
	<48920607.5040606@freescale.com>
	<9e4733910807311157q358640ddyef1f14865c069b8@mail.gmail.com>
	<Pine.LNX.4.58.0807311656250.10341@shell4.speakeasy.net>
	<9e4733910807311819i60872285ga4829c841185fdc0@mail.gmail.com>
	<Pine.LNX.4.58.0807311828580.10341@shell4.speakeasy.net>
In-Reply-To: <Pine.LNX.4.58.0807311828580.10341@shell4.speakeasy.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Linuxppc-dev@ozlabs.org, Scott Wood <scottwood@freescale.com>,
	Timur Tabi <timur@freescale.com>, Linux I2C <i2c@lm-sensors.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Trent Piepho wrote:
> On Thu, 31 Jul 2008, Jon Smirl wrote:
[...snip...]
>> I don't see why we want to go through the trouble of having uboot tell
>> us things about a chip that are fixed in stone. Obviously something
>> like the frequency of the external crystal needs to be passed up, but
>> why pass up stuff that can be computed (or recovered by reading a
>> register)?
> 
> One could also say that if U-boot has to have the code and already
> calculated the value, why duplicate the code and the calculation in Linux?

Right, if the "bus-frequency" property for the I2C device is not 
defined, the Linux I2C bus driver should just overtake the pre-defined 
values. That's what I (we?) wanted to implement anyhow.

Wolfgang.
