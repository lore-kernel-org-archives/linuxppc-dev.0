Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C6DFCDE1CC
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jun 2008 05:21:56 +1000 (EST)
Message-ID: <48483B99.3010300@freescale.com>
Date: Thu, 05 Jun 2008 14:16:41 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: "cell-index" vs. "index" vs. no index in I2C device nodes
References: <200806041706.21557.sr@denx.de>	
	<fa686aa40806050839h55d8e358m93248414507f10e2@mail.gmail.com>	
	<48480987.1070701@freescale.com>	
	<fa686aa40806050900i40f0aa62o4bab3b8c7409b15f@mail.gmail.com>	
	<484810A3.5070301@freescale.com>	
	<20080605112122.0381a338@zod.rchland.ibm.com>	
	<48481373.8010706@freescale.com>	
	<20080605132735.3433f2af@zod.rchland.ibm.com>	
	<fa686aa40806051146h10d9add6ude64d59cedf08f7d@mail.gmail.com>	
	<20080605135625.562d1dbe@zod.rchland.ibm.com>
	<fa686aa40806051214u6866cec0m66ea32275d8bd5cc@mail.gmail.com>
In-Reply-To: <fa686aa40806051214u6866cec0m66ea32275d8bd5cc@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:

> No; use an alias in the aliases node.  That is what aliases is designed
> for.  Something like 'index' is a reinvention of the wheel.

Do aliases work in reverse?  That is, if I have a pointer to a device node, can
I look up its alias directly?  Or do I have to scan the aliases node and do a
comparison of each phandle, one at a time, until I find a match?  And when I
find a match, will I need to do sscanf() in order to extract the actual index
value from the property?

-- 
Timur Tabi
Linux kernel developer at Freescale
