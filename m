Return-Path: <vbarshak@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 3DCC0DDEF0
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Sep 2007 23:31:14 +1000 (EST)
Message-ID: <46E000E0.4080203@ru.mvista.com>
Date: Thu, 06 Sep 2007 17:30:08 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: OF NDFC
References: <20070905181703.GA30904@ru.mvista.com>	<20070905160008.201a243a@vader.jdub.homelinux.org>	<b9fb2fad5d6b04a07996416842df7f72@kernel.crashing.org>
	<20070906081732.079bc45d@zod.rchland.ibm.com>
In-Reply-To: <20070906081732.079bc45d@zod.rchland.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Josh Boyer wrote:
> On Thu, 6 Sep 2007 15:06:03 +0200
> Segher Boessenkool <segher@kernel.crashing.org> wrote:
> 
>>>> Is anybody working on the device-tree-aware ppc 44x NAND flash 
>>>> controller (ndfc)  driver?
>>> Not to my knowledge.  We sort of need a decent binding for NAND flash
>>> in general first.
>> Not really.  You can put the NAND controller in the device
>> tree without describing the NAND flash itself -- and for that,
>> you only need a "name", "compatible", "reg", and maybe some
>> interrupt stuff.
> 
> He said driver.  To test a driver, you'd need the binding for both the
> controller, and the NAND flash it controls.  Otherwise, the driver
> isn't going to do much :).
> 
> josh
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
AFAIK, NAND flash is autodetected by reading it's ID at runtime, so 
there should be no need for flash bindings.
Thanks,
Valentine.
