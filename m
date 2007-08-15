Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CF82BDDEC0
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Aug 2007 05:14:23 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l7FJEKVh029490
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Aug 2007 15:14:20 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l7FJEJrY210848
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Aug 2007 13:14:19 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l7FJEJww018957
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Aug 2007 13:14:19 -0600
Date: Wed, 15 Aug 2007 14:13:01 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 1/3] Fix setting of irq trigger type in UIC driver
Message-ID: <20070815141301.5bb9c7bd@zod.rchland.ibm.com>
In-Reply-To: <20070814035242.8EED6DDEF4@ozlabs.org>
References: <20070814034811.GA8791@localhost.localdomain>
	<20070814035242.8EED6DDEF4@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 14 Aug 2007 13:52:42 +1000 (EST)
David Gibson <david@gibson.dropbear.id.au> wrote:

> The UIC (interrupt controller in 4xx embedded CPUs) driver currently
> missets the IRQ_lEVEL flag in desc->status, due to a thinko.  This
> patch fixes the bug.
> 
> Currently this is only a cosmetic problem (affects the output in
> /proc/interrupts), however subsequent patches will use the IRQ_LEVEL
> flag to affect flow handling.
> 
> Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Acked-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

josh
