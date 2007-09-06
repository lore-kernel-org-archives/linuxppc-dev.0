Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1173EDDE1A
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Sep 2007 23:18:06 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l86DI243010857
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Sep 2007 09:18:02 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l86DI18U685578
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Sep 2007 09:18:01 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l86DI1lo010051
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Sep 2007 09:18:01 -0400
Date: Thu, 6 Sep 2007 08:17:32 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: OF NDFC
Message-ID: <20070906081732.079bc45d@zod.rchland.ibm.com>
In-Reply-To: <b9fb2fad5d6b04a07996416842df7f72@kernel.crashing.org>
References: <20070905181703.GA30904@ru.mvista.com>
	<20070905160008.201a243a@vader.jdub.homelinux.org>
	<b9fb2fad5d6b04a07996416842df7f72@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 6 Sep 2007 15:06:03 +0200
Segher Boessenkool <segher@kernel.crashing.org> wrote:

> >> Is anybody working on the device-tree-aware ppc 44x NAND flash 
> >> controller (ndfc)  driver?
> >
> > Not to my knowledge.  We sort of need a decent binding for NAND flash
> > in general first.
> 
> Not really.  You can put the NAND controller in the device
> tree without describing the NAND flash itself -- and for that,
> you only need a "name", "compatible", "reg", and maybe some
> interrupt stuff.

He said driver.  To test a driver, you'd need the binding for both the
controller, and the NAND flash it controls.  Otherwise, the driver
isn't going to do much :).

josh
