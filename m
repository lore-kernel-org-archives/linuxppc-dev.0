Return-Path: <timur@freescale.com>
Message-ID: <48932579.3040705@freescale.com>
Date: Fri, 01 Aug 2008 10:02:17 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [i2c] [PATCH] powerpc: i2c-mpc: make speed registers configurable
	via FDT
References: <4889EFFE.2070201@grandegger.com> <4891FC3A.7040609@freescale.com>	
	<20080731180959.GA29057@secretlab.ca>
	<489200B6.9060906@freescale.com>	
	<20080731182810.GB29097@secretlab.ca>
	<48920607.5040606@freescale.com>	
	<9e4733910807311157q358640ddyef1f14865c069b8@mail.gmail.com>	
	<Pine.LNX.4.58.0807311656250.10341@shell4.speakeasy.net>	
	<9e4733910807311819i60872285ga4829c841185fdc0@mail.gmail.com>	
	<Pine.LNX.4.58.0807311828580.10341@shell4.speakeasy.net>
	<9e4733910807311844p142b26ffyb4105df3e136f65@mail.gmail.com>
In-Reply-To: <9e4733910807311844p142b26ffyb4105df3e136f65@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Trent Piepho <xyzzy@speakeasy.org>, Linuxppc-dev@ozlabs.org,
	Linux I2C <i2c@lm-sensors.org>, Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jon Smirl wrote:

> What about the Efika which is mpc5200 based and doesn't use uboot?

How does the Efika handle the dozen other properties that U-Boot normally 
initializes in the device tree?

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
