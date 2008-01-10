Return-Path: <timur@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 55CC6DE12D
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jan 2008 02:41:34 +1100 (EST)
Message-ID: <47863C31.50309@freescale.com>
Date: Thu, 10 Jan 2008 09:39:29 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>, david@gibson.dropbear.id.au,
	Grant Likely <grant.likely@secretlab.ca>, Olof Johansson <olof@lixom.net>
Subject: Re: [alsa-devel] [PATCH] ASoC drivers for the Freescale MPC8610 SoC
References: <9e4733910801010925j67192427o4e0e824b9d7e0ad0@mail.gmail.com>	
	<477BAB67.4080003@freescale.com>	
	<9e4733910801020734n115888cbt86351f67f2311629@mail.gmail.com>	
	<477D2150.4020506@freescale.com>	
	<20080103235156.GE12883@localhost.localdomain>	
	<477EEDFA.9010205@freescale.com>	
	<20080106004637.GJ4326@localhost.localdomain>	
	<47824AA3.5070808@freescale.com>
	<20080107182853.GA17312@sirena.org.uk>	
	<20080110034919.GI17816@localhost.localdomain>	
	<9e4733910801092141m5d4476d0l1c081307fd5c1969@mail.gmail.com>
	<1199961015.19903.270.camel@localhost.localdomain>
In-Reply-To: <1199961015.19903.270.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org,
	Liam Girdwood <lg@opensource.wolfsonmicro.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Liam Girdwood wrote:

> I think we are probably looking at submission in the next 8 - 10 weeks.
> Currently most of the core code is complete, however some platforms and
> codecs still need porting.

With that in mind, can I get some kind of consensus from the PPC side as to 
whether this ASoC V1 driver is okay?  I want to get it into 2.6.25.

Keep in mind:

1) ASoC V1 is not PowerPC-friendly, so it's impossible to make an ASoC V1 
PowerPC driver "100% correct".

2) The CS4270 driver does not support I2C nodes in the device tree, so there's 
not point in adding any to the 8610 DTS.

3) Liam and I are working on porting this driver to ASoC V2 and resolving all 
open PPC issue, but that won't be done in time for 2.6.25.

-- 
Timur Tabi
Linux kernel developer at Freescale
