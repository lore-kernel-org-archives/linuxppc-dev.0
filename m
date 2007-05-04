Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [208.123.74.7])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E6EB5DDE20
	for <linuxppc-dev@ozlabs.org>; Sat,  5 May 2007 01:16:33 +1000 (EST)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] Remove CPU_FTR_NEED_COHERENT for 7448. 
In-Reply-To: Your message of "Fri, 04 May 2007 07:36:48 +1000."
	<1178228208.6353.55.camel@localhost.localdomain>
References: <1178141683.32136.46.camel@ld0161-tx32>
	<1178187440.20944.12.camel@localhost.localdomain>
	<1178208838.17201.52.camel@ld0161-tx32>
	<1178228208.6353.55.camel@localhost.localdomain>
Date: Fri, 04 May 2007 10:16:29 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1HjzWH-0001Wg-Ps@jdl.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day Benjamin Herrenschmidt mumbled:
> 
> I still maintain it should be a runtime thing tho :-)
> 
> Ben.

So, could you comment on my proposed solution doing
things exactly this way?  Speifically, would folks
prefer the dynamic 

    number_of_cpus() == 1 

and possibly checking the device tree or SMP map, or the 

    #ifndef SMP

test guarding the removal of the CPU_FTR_NEED_COHERENT bit?

Thanks,
jdl
