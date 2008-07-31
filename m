Return-Path: <wg@grandegger.com>
Message-ID: <48922087.4050903@grandegger.com>
Date: Thu, 31 Jul 2008 22:28:55 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] powerpc: i2c-mpc: make speed registers configurable via
	FDT
References: <4889EFFE.2070201@grandegger.com> <4889FD1D.4010804@freescale.com>
	<20080727012722.GH12191@secretlab.ca>
	<4891A744.6060005@grandegger.com>
	<9e4733910807310849g7e5612dbk9536733e061af8ad@mail.gmail.com>
	<4891F4D8.9090905@grandegger.com>
	<fa686aa40807311031r66f6451aw206faf54509c14d9@mail.gmail.com>
	<4891FC3A.7040609@freescale.com>
	<20080731180959.GA29057@secretlab.ca>
	<489200B6.9060906@freescale.com>
	<20080731182810.GB29097@secretlab.ca>
	<48920607.5040606@freescale.com> <48921187.1090101@grandegger.com>
	<48921179.1080403@freescale.com> <48921888.3020900@grandegger.com>
	<48921954.4020103@freescale.com> <48921DED.6010403@grandegger.com>
	<48921E44.7010502@freescale.com>
In-Reply-To: <48921E44.7010502@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Timur Tabi wrote:
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

OK.

> 2) The speed of the I2C bus, as seen by devices on that bus.  This is usually
> 400KHz.

Which should be defined with the property "current-speed", right?

Wolfgang.
