Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id A6DB567A67
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 28 Mar 2005 14:11:25 +1000 (EST)
Date: Sun, 27 Mar 2005 20:11:19 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Jason McMullan <jason.mcmullan@timesys.com>
Message-ID: <20050328041119.GA30818@gate.ebshome.net>
References: <1111525951.2987.76.camel@ad.doubleclick.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1111525951.2987.76.camel@ad.doubleclick.net>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] Updated: CPM2 I2C (SDMA and BitBang)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Mar 22, 2005 at 04:12:30PM -0500, Jason McMullan wrote:
> #### Auto-generated patch ####
> Date:        Tue, 22 Mar 2005 15:59:01 -0500
> Maintainer:  Jason McMullan <jmcmullan@timesys.com>
> Summary:     CPM/CPM2 I2C driver for Freescale SoC devices
> Description: CPM/CPM2 I2C driver for Freescale SoC devices
> Depends:
> 	
> ###############################
> 
> Index of changes:
> 
>  drivers/i2c/algos/Kconfig              |    4 
>  drivers/i2c/algos/Makefile             |    1 
>  drivers/i2c/busses/Kconfig             |   25 +
>  drivers/i2c/busses/Makefile            |    1 
>  include/linux/i2c-id.h                 |    4 
>  linux/drivers/i2c/algos/i2c-algo-cpm.c |  477 +++++++++++++++++++++++++++++++++
>  linux/drivers/i2c/busses/i2c-cpm.c     |  219 +++++++++++++++
>  linux/include/linux/i2c-algo-cpm.h     |   64 ++++

[snip]

Jason, another thought. Do we really need all this mess with separate 
algo and bus drivers?

Could you make just a bus driver like we have for 4xx, Keywest and 
85xx/52xx/MPC107? It's much cleaner and less confusing IMHO.

--
Eugene
