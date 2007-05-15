Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1112ADDE45
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 11:56:52 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l4F1vmtn018728
	for <linuxppc-dev@ozlabs.org>; Mon, 14 May 2007 21:57:48 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4F1unOE516982
	for <linuxppc-dev@ozlabs.org>; Mon, 14 May 2007 21:56:49 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4F1un8p012507
	for <linuxppc-dev@ozlabs.org>; Mon, 14 May 2007 21:56:49 -0400
Subject: Re: treeImage.initrd rule is very broken
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: David Gibson <dwg@au1.ibm.com>
In-Reply-To: <20070515014044.GE565@localhost.localdomain>
References: <1179154033.3420.13.camel@zod.rchland.ibm.com>
	<20070515014044.GE565@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 14 May 2007 20:56:40 -0500
Message-Id: <1179194200.3420.98.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-05-15 at 11:40 +1000, David Gibson wrote:
> 
> Bother.  I think the problem is that make is selecting the treeImage.%
> rule (which does match), instead of the more specific
> treeImage.initrd.%.  I think the very simple patch below, which just
> reverses the order of the rules, might fix it.  Can you give it a
> whirl?

Of course it would have to be that simple.  Yep, switched the order of
the rules and the zImage.initrd creation worked wonderfully.

Thanks.

josh
