Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 58B1867BA1
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Dec 2006 11:23:28 +1100 (EST)
In-Reply-To: <457F2FE1.1080308@freescale.com>
References: <20061208190758.6cee088f.kim.phillips@freescale.com>	<1165648490.1103.117.camel@localhost.localdomain>	<91EF8E0D-06BC-47FD-89E6-6350430946F9@kernel.crashing.org>	<20061211155155.26868ca6.kim.phillips@freescale.com>	<A1A95A77-B86C-41CF-87DC-58CD63843CE3@kernel.crashing.org>	<20061211201055.21031c9b.kim.phillips@freescale.com>	<1165890570.11914.5.camel@localhost.localdomain>	<457F1F6E.4020502@freescale.com>	<1165960058.11914.72.camel@localhost.localdomain>	<7152860A-27A3-4C08-B6A5-DFA57A63ACED@kernel.crashing.org>	<20061212162416.06f0dd76.kim.phillips@freescale.com>
	<A2576248-6DF4-44BE-99D2-0D8477865B17@kernel.crashing.org>
	<457F2FE1.1080308@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <513E2628-5785-4100-9E83-986990E06DF5@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: consolidate mpc83xx platform files
Date: Tue, 12 Dec 2006 18:23:24 -0600
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 12, 2006, at 4:40 PM, Scott Wood wrote:

> Kumar Gala wrote:
>> What's the issue with a file per board if all it has is the  
>> ppc_md/ define_machine() in it.  Someone explain to me why this is  
>> a bad thing?
>
> It requires that the kernel be changed even when a new board  
> doesn't require that the kernel actually *do* anything  
> differently.  It's gratuitous duplication, even if the bit being  
> duplicated is small.

But at least someone had to think about the duplication and it  
provides remove for customization if its needed in the future.

> Why is a single ppc_md, which no board is forced to use, but can be  
> used by any board without special requirements, a bad thing?

It adds code to all those people that don't need it just so we don't  
duplicate a few lines of source code.

- k
