Return-Path: <timur@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8B00BDDFC0
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jun 2008 23:10:00 +1000 (EST)
Message-ID: <48493713.2070806@freescale.com>
Date: Fri, 06 Jun 2008 08:09:39 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>, Grant Likely <grant.likely@secretlab.ca>,
	Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Stefan Roese <sr@denx.de>
Subject: Re: "cell-index" vs. "index" vs. no index in I2C device nodes
References: <48480987.1070701@freescale.com>
	<fa686aa40806050900i40f0aa62o4bab3b8c7409b15f@mail.gmail.com>
	<484810A3.5070301@freescale.com>
	<20080605112122.0381a338@zod.rchland.ibm.com>
	<48481373.8010706@freescale.com>
	<20080605132735.3433f2af@zod.rchland.ibm.com>
	<fa686aa40806051146h10d9add6ude64d59cedf08f7d@mail.gmail.com>
	<20080605135625.562d1dbe@zod.rchland.ibm.com>
	<fa686aa40806051214u6866cec0m66ea32275d8bd5cc@mail.gmail.com>
	<48483B99.3010300@freescale.com>
	<20080605225637.GG30980@yookeroo.seuss>
In-Reply-To: <20080605225637.GG30980@yookeroo.seuss>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:

> Aliases aren't trivially reversible, but it shouldn't be too hard to
> write a helper function which will do the scan and parse you describe.

How about I submit a patch adding a function called "of_get_aliased_index()"?

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
