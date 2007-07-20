Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C2BBDDDEEA
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2007 17:18:12 +1000 (EST)
In-Reply-To: <1184881198.25235.347.camel@localhost.localdomain>
References: <E1IAnwC-0003Xm-6U@jdl.com>
	<1184722754.25235.183.camel@localhost.localdomain>
	<5F6EB5F7-C5AE-437F-9DF1-22FE38D7A841@kernel.crashing.org>
	<1184795678.25235.269.camel@localhost.localdomain>
	<F2806DFF-A43B-4853-A6C0-3D69B0231B06@kernel.crashing.org>
	<1184881198.25235.347.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <2616BEAA-E5C1-4C01-9ADB-132ED00381B2@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Add StorCenter DTS first draft.
Date: Fri, 20 Jul 2007 09:14:20 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Jon Loeliger <jdl@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> So your plan is to prefer the device tree over the cputable, and
>> maybe even deprecate the cputable?
>
> Nah, you are fine not putting anything, but if it's in the DT it  
> should
> be correct, not "0". Else, just don't put it in the DT.

Ah okay.  So we should recommend to not put any of those
properties into DTS files at all?  If so, I'll create a
patch to remove them.

> We use the DT to override cputable but that's mostly useful for things
> like pSeries where you can get some processors in "compatibility" mode
> over another one, or some virtual PVRs, and other fancy things like  
> that
> where the cputable isn't very useful.

Yeah, and it's a good idea to have the device tree override
the cputable always, with real OF, anyway.  (Well there are
buggy device trees out there, of course ;-) )


Segher
