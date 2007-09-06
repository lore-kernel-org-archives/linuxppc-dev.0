Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B922DDDF1E
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Sep 2007 23:41:56 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l86DfX7j001420
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Sep 2007 09:41:33 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l86DfXce354100
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Sep 2007 07:41:33 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l86DfWLU017842
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Sep 2007 07:41:32 -0600
Date: Thu, 6 Sep 2007 08:41:09 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Valentine Barshak <vbarshak@ru.mvista.com>
Subject: Re: OF NDFC
Message-ID: <20070906084109.315544ea@zod.rchland.ibm.com>
In-Reply-To: <46E000E0.4080203@ru.mvista.com>
References: <20070905181703.GA30904@ru.mvista.com>
	<20070905160008.201a243a@vader.jdub.homelinux.org>
	<b9fb2fad5d6b04a07996416842df7f72@kernel.crashing.org>
	<20070906081732.079bc45d@zod.rchland.ibm.com>
	<46E000E0.4080203@ru.mvista.com>
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

On Thu, 06 Sep 2007 17:30:08 +0400
Valentine Barshak <vbarshak@ru.mvista.com> wrote:

> AFAIK, NAND flash is autodetected by reading it's ID at runtime, so 
> there should be no need for flash bindings.

Well, I'm not really sure.  CFI and JEDEC can both be probed as well,
and we're working on a binding there.  But if you think you can come up
with a driver for NDFC that doesn't require some kind of device tree
description of the devices it controls, then by all means go for it.

josh
