Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 72150DE17B
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jan 2008 03:04:57 +1100 (EST)
Message-ID: <478641E3.5070404@freescale.com>
Date: Thu, 10 Jan 2008 10:03:47 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [alsa-devel] [PATCH] ASoC drivers for the Freescale MPC8610 SoC
References: <9e4733910801010925j67192427o4e0e824b9d7e0ad0@mail.gmail.com>	
	<20080103235156.GE12883@localhost.localdomain>	
	<477EEDFA.9010205@freescale.com>	
	<20080106004637.GJ4326@localhost.localdomain>	
	<47824AA3.5070808@freescale.com>	
	<20080107182853.GA17312@sirena.org.uk>	
	<20080110034919.GI17816@localhost.localdomain>	
	<9e4733910801092141m5d4476d0l1c081307fd5c1969@mail.gmail.com>	
	<1199961015.19903.270.camel@localhost.localdomain>	
	<47863C31.50309@freescale.com>
	<fa686aa40801100801p3da98eecn44401b17fe652da8@mail.gmail.com>
In-Reply-To: <fa686aa40801100801p3da98eecn44401b17fe652da8@mail.gmail.com>
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

> The driver doesn't need to be 100% correct.  Drivers are easy to
> change if they aren't quite right.  There are no long term
> consequences.
 >
> However, the device tree issues must be addressed before it is merged
> and deployed.  Otherwise we end up having to support poorly designed
> trees over the long term.

I agree.  Correct me if I'm wrong, but I think the only device tree "issue" is 
the definition of the 'codec' node under the SSI node.  If so, I'm not sure what 
other changes need to be mode.

-- 
Timur Tabi
Linux kernel developer at Freescale
