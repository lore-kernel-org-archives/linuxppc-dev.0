Return-Path: <ajz@cambridgebroadband.com>
Received: from cambridgebroadband.com (mailhost.cambridgebroadband.com
	[217.204.121.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3839267D78
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Apr 2006 19:15:48 +1000 (EST)
Date: Thu, 13 Apr 2006 09:36:20 +0100
From: Alex Zeffertt <ajz@cambridgebroadband.com>
To: Carlos Munoz <carlos@kenati.com>
Subject: Re: Freescale 8272ADS configuration
Message-Id: <20060413093620.10a0dadb.ajz@cambridgebroadband.com>
In-Reply-To: <443DA7D9.8090606@kenati.com>
References: <443DA7D9.8090606@kenati.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Carlos,

You need to load u-boot using the following BDI2000 config file:

	ftp://ftp.denx.de/pub/BDI2000/MPC8260ADS.cfg

u-boot itself needs to be configured with 
	
	make  MPC8272ADS_config

before it is built.

The kernel needs to be configured with

	make ads8272_config && make oldconfig

before it is built.

And most importantly you should read the user manual on 

	http://www.denx.de/wiki/DULG/Manual

It's a bit 8xx centric but most of it applies to the 82xx as well.

Alex


On Wed, 12 Apr 2006 18:22:33 -0700
Carlos Munoz <carlos@kenati.com> wrote:

> Hi all,
> 
> I have a new Freescale 8272ADS board that I need to load uboot and
> linux on. I have read all the documentation that came with the board
> but unfortunately it doesn't explain how to bring up the board from
> scratch. Does anyone know what I need to do to load uboot and linux
> on this board ?
> 
> Thanks,
> 
> 
> Carlos
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
