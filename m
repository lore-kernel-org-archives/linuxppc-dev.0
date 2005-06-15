Return-Path: <kumar.gala@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 9043B67B5D
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Jun 2005 01:01:24 +1000 (EST)
In-Reply-To: <1118846034.7564.113.camel@jmcmullan.timesys>
References: <42AFDEFE.2040508@ru.mvista.com>
	<2731d19a2e3b9413db32be59726a4c82@freescale.com>
	<1118846034.7564.113.camel@jmcmullan.timesys>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <d59e33ec0e627627e2e594075d139b35@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Wed, 15 Jun 2005 10:01:15 -0500
To: "Jason McMullan" <jason.mcmullan@gmail.com>
Cc: "Gala Kumar K.-galak" <galak@freescale.com>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: RFC: cpm2_devices.c
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Jun 15, 2005, at 9:33 AM, Jason McMullan wrote:

> On Wed, 2005-06-15 at 09:25 -0500, Kumar Gala wrote:
>> Yes, I removed the fcc_regs_c since its not always true.  Please don't
>> rename the file to cpm2_.  I think I'm going to end up renaming them 
>> to
>> pq2_ since that is the most appropriate name.  I'd say we are about 
>> 80%
>
>  PQ2_? But all these devices are on PQ3 also!

Sure and they are in the mpc85xx_* files.  Maybe I'm missing some 
concern people have here.  It dont see what the issue is.  This is just 
like how TSEC/gianfar show up in both mpc85xx_* and mpc83xx_*.  These 
files are intended to represent the devices found on a product family 
(PQ2, PQ3, PQ2 Pro, etc.).  There is going to be overlap.

Also, its not 100% true that all of the devices on a PQ2 exist in PQ3.  
For example (and this isn't a great one) the security block on 
8248/8272 is different than the security block on PQ3 devices.

- kumar
