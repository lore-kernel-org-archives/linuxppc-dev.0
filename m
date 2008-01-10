Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4F374DDF89
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jan 2008 07:15:17 +1100 (EST)
Message-ID: <47867C80.4050408@freescale.com>
Date: Thu, 10 Jan 2008 14:13:52 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC drivers for the Freescale MPC8610 SoC
References: <9e4733910801010925j67192427o4e0e824b9d7e0ad0@mail.gmail.com>	
	<20080106004637.GJ4326@localhost.localdomain>	
	<47824AA3.5070808@freescale.com>	
	<20080107182853.GA17312@sirena.org.uk>	
	<20080110034919.GI17816@localhost.localdomain>	
	<9e4733910801092141m5d4476d0l1c081307fd5c1969@mail.gmail.com>	
	<1199961015.19903.270.camel@localhost.localdomain>	
	<47863C31.50309@freescale.com>	
	<fa686aa40801100801p3da98eecn44401b17fe652da8@mail.gmail.com>	
	<478641E3.5070404@freescale.com>
	<9e4733910801101210w5846bb4ds38a603a489ef0522@mail.gmail.com>
In-Reply-To: <9e4733910801101210w5846bb4ds38a603a489ef0522@mail.gmail.com>
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

Jon Smirl wrote:

> Isn't your codec is i2c controlled? Where does the main node for the
> code live, i2c bus or ssi bus? What does the link between the buses
> look like for pointing to the codec entry?

The CS4270 driver is "old style", which means it probes all possible I2C 
addresses until it finds a hit, and then stops.  This has all the obvious 
drawbacks, but I'm stuck with that design for now.

> What about fsl,ssi being too generic for a compatible type?

Already fixed:

		ssi@16000 {
			compatible = "fsl,mpc8610-ssi";
-- 
Timur Tabi
Linux kernel developer at Freescale
