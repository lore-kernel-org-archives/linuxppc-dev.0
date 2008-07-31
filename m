Return-Path: <timur@freescale.com>
Message-ID: <489210F5.5090003@freescale.com>
Date: Thu, 31 Jul 2008 14:22:29 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
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
	<48920607.5040606@freescale.com> <48920C1A.7010605@freescale.com>
	<48920D9B.5060406@freescale.com> <48920F69.6020909@freescale.com>
	<48921057.8030807@freescale.com> <489210AF.7000909@freescale.com>
In-Reply-To: <489210AF.7000909@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linuxppc-dev@ozlabs.org, Linux I2C <i2c@lm-sensors.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott Wood wrote:
> Timur Tabi wrote:
>> True, but I'd rather we have a real clock-frequency property that contains the
>> calculated I2C input frequency, than a divider.  It's more consistent with other
>> properties,
> 
> Right, I wasn't saying i2c should be different from serial, pci, etc. 
> It was more of a side comment about the way we specify clocks in general.

I guess it's agreed then.  If no one else gets around to it, I'll submit the
U-Boot patch for updating the device tree.

-- 
Timur Tabi
Linux kernel developer at Freescale
