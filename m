Return-Path: <timur@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 031C9DE0D4
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jan 2008 07:36:24 +1100 (EST)
Message-ID: <47868191.4000901@freescale.com>
Date: Thu, 10 Jan 2008 14:35:29 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [alsa-devel] [PATCH] ASoC drivers for the Freescale MPC8610 SoC
References: <9e4733910801010925j67192427o4e0e824b9d7e0ad0@mail.gmail.com>	
	<20080107182853.GA17312@sirena.org.uk>	
	<20080110034919.GI17816@localhost.localdomain>	
	<9e4733910801092141m5d4476d0l1c081307fd5c1969@mail.gmail.com>	
	<1199961015.19903.270.camel@localhost.localdomain>	
	<47863C31.50309@freescale.com>	
	<fa686aa40801100801p3da98eecn44401b17fe652da8@mail.gmail.com>	
	<478641E3.5070404@freescale.com>	
	<9e4733910801101210w5846bb4ds38a603a489ef0522@mail.gmail.com>	
	<47867C80.4050408@freescale.com>
	<fa686aa40801101224p298e60bcheb622324c80690ea@mail.gmail.com>
In-Reply-To: <fa686aa40801101224p298e60bcheb622324c80690ea@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lg@opensource.wolfsonmicro.com>,
	linuxppc-dev@ozlabs.org, Olof Johansson <olof@lixom.net>,
	david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:

> Nit: node name should be either i2s@16000 (the mode that it is in), or
> sound@16000 (if you feel that this node encapsulates the concept of a
> sound device enough).

Well, SSI stands for "Synchronous Serial  Interface" (although it's capable of 
asynchronous communication as well).  From the manual:

"The SSI is a full-duplex, serial port that allows the chip to communicate with 
a variety of serial devices.  These serial devices can be standard CODer-DECoder 
(CODECs), Digital Signal Processors (DSPs), microprocessors, peripherals, and 
popular industry audio CODECs that implement the inter-IC sound bus standard 
(I2S) and Intel AC97 standard."

It might an I2S device in this case, but it could be an AC97 device in some 
other case.  It all depends on how the board is wired.  Do we really want to 
change the name of an SOC device based on what it's connected to?

-- 
Timur Tabi
Linux kernel developer at Freescale
