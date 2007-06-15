Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-03.arcor-online.net (mail-in-03.arcor-online.net
	[151.189.21.43])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8016EDDE49
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Jun 2007 18:57:45 +1000 (EST)
In-Reply-To: <467250E1.8040507@ru.mvista.com>
References: <1181729973.25586.31.camel@dolphin.spb.rtsoft.ru>
	<db0d38e5b5e1a9a3a7fe35d25ebd357a@kernel.crashing.org>
	<467176EB.7060404@ru.mvista.com>
	<6c416bf9f79a648fc82f64619aca86de@kernel.crashing.org>
	<467250E1.8040507@ru.mvista.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <8f28fb00e529d18dfcf6ea1b025f9c90@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC/PATCH] powerpc: MPC7450 L2 HW cache flush feature utilization
Date: Fri, 15 Jun 2007 10:56:41 +0200
To: "Vladislav D. Buzov" <vbuzov@ru.mvista.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> I've double checked this. All processors considered 7450 in the 
>>> kernel are covered by MPC7450 RISC Microprocessor Family Reference 
>>> Manual where hardware cache flushing procedure is described.
>>
>> Nice.  Now all that remains to be done is for the patch to
>> be tested on actual hardware for at least a few of those
>> other CPUs.  Any volunteers?

> Unfortunately I have only 7448 on hand :(

I was calling out for other list members to test your
patch :-)


Segher
