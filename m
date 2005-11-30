Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EB25968834
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Nov 2005 16:49:49 +1100 (EST)
In-Reply-To: <20051129111442.GB27630@inaccessnetworks.com>
References: <20051129111442.GB27630@inaccessnetworks.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <EFC3108D-03D5-40B1-A66D-5F3307D33A68@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Date: Tue, 29 Nov 2005 23:49:45 -0600
To: Thomas Arvanitis <tharvan@inaccessnetworks.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: spi on mpc82xx
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Nov 29, 2005, at 5:14 AM, Thomas Arvanitis wrote:

> Hi,
>
> I was wondering what is the status for supporting spi devices with 2.6
> on an mpc82xx device (I use an mpc8275). I checked and the kernel from
> kernel.org does not include anything. Is there an spi bus
> infrastructure (like i2c) coming any time soon, where one can add
> support for specific chips, and then write a driver on top of that?
> Or a plan for these things?
>
> I found a patch for something like that, by Grant Likely, but I don't
> know whether I should go that way.
>
> I want to write a driver for controlling the micrel ks8995 ethernet
> switch through spi. Should I just go for a self contained driver?

There has be some patches on the lkml list for the creation of a SPI  
layer similar to I2C.  I'm not sure what the latest status is.  I'd  
google search for SPI on lkml.

Once something like that gets in I'm sure someone will get around to  
contributing a SPI driver for the 82xx line of processors.

- kumar
