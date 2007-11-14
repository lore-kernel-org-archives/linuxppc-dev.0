Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp04.au.ibm.com (E23SMTP04.au.ibm.com [202.81.18.173])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3C4F3DDD0D
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Nov 2007 11:59:35 +1100 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp04.au.ibm.com (8.13.1/8.13.1) with ESMTP id lAE0xSS4023691
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Nov 2007 11:59:28 +1100
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.6) with ESMTP id
	lAE139bs248856
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Nov 2007 12:03:09 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lADNxLZX030972
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Nov 2007 10:59:21 +1100
Date: Wed, 14 Nov 2007 11:57:34 +1100
From: David Gibson <dwg@au1.ibm.com>
To: Valentine Barshak <vbarshak@ru.mvista.com>
Subject: Re: [PATCH 1/2] PowerPC: 4xx uic: add mask_ack callback
Message-ID: <20071114005734.GA19378@localhost.localdomain>
References: <20071113201559.GA26172@ru.mvista.com>
	<20071113202521.GA26295@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071113202521.GA26295@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Nov 13, 2007 at 11:25:21PM +0300, Valentine Barshak wrote:
> This adds uic_mask_ack_irq() callback to PowerPC 4xx uic code 
> to avoid kernel crash. It is used for edge-triggered interrupts
> by handle_uic_irq().

Oops.  Obviously never caught this obvious bug, because I've never
used an edge-triggered interrupt on the Ebony yet.

> Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
