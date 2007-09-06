Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AA051DDE1A
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Sep 2007 23:06:17 +1000 (EST)
In-Reply-To: <20070905160008.201a243a@vader.jdub.homelinux.org>
References: <20070905181703.GA30904@ru.mvista.com>
	<20070905160008.201a243a@vader.jdub.homelinux.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <b9fb2fad5d6b04a07996416842df7f72@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: OF NDFC
Date: Thu, 6 Sep 2007 15:06:03 +0200
To: Josh Boyer <jwboyer@jdub.homelinux.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Is anybody working on the device-tree-aware ppc 44x NAND flash 
>> controller (ndfc)  driver?
>
> Not to my knowledge.  We sort of need a decent binding for NAND flash
> in general first.

Not really.  You can put the NAND controller in the device
tree without describing the NAND flash itself -- and for that,
you only need a "name", "compatible", "reg", and maybe some
interrupt stuff.


Segher
