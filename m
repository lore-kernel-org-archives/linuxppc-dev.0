Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-11.arcor-online.net (mail-in-11.arcor-online.net
	[151.189.21.51])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2F4FDE063F
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Jun 2007 08:14:56 +1000 (EST)
In-Reply-To: <20070615212016.GB18055@mag.az.mvista.com>
References: <1181729973.25586.31.camel@dolphin.spb.rtsoft.ru>
	<db0d38e5b5e1a9a3a7fe35d25ebd357a@kernel.crashing.org>
	<467176EB.7060404@ru.mvista.com>
	<6c416bf9f79a648fc82f64619aca86de@kernel.crashing.org>
	<20070615212016.GB18055@mag.az.mvista.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <5dac96bc812ed03d3c23da65e7a609aa@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC/PATCH] powerpc: MPC7450 L2 HW cache flush feature utilization
Date: Sat, 16 Jun 2007 00:14:45 +0200
To: "Mark A. Greer" <mgreer@mvista.com>
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
>>> kernel
>>> are covered by MPC7450 RISC Microprocessor Family Reference Manual
>>> where hardware cache flushing procedure is described.
>>
>> Nice.  Now all that remains to be done is for the patch to
>> be tested on actual hardware for at least a few of those
>> other CPUs.  Any volunteers?
>
> I just booted & played around on a prpmc2800e (7447A, 512MB) with
> this patch and it seemed to work fine.

Good to hear, thank you!

> I *may* have some old sandpoint 745x modules that still work but
> I'll have to get the sandpoint working in arch/powerpc again.
> I'll try to get to that in a week or so.

Don't sweat it, I'm sure someone with a powermac 7450
or 7455 will show up soon enough.  Any takers?


Segher
