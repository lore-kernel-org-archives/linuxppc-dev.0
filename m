Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp03.au.ibm.com (E23SMTP03.au.ibm.com [202.81.18.172])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp03.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D62F1DDE38
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Sep 2007 12:29:38 +1000 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp03.au.ibm.com (8.13.1/8.13.1) with ESMTP id l8F2TcU8027766
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Sep 2007 12:29:38 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l8F2XBpl282276
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Sep 2007 12:33:11 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l8F2TLhC021699
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Sep 2007 12:29:21 +1000
Date: Sat, 15 Sep 2007 12:21:23 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [patch 2/4] Make partitions optional in physmap_of
Message-ID: <20070915022123.GE25414@localhost.localdomain>
References: <20070914185410.387074000@linux.vnet.ibm.com>>
	<20070914185648.970788000@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070914185648.970788000@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Sep 14, 2007 at 01:54:12PM -0500, Josh Boyer wrote:
> The latest physmap_of driver has a small error where it will fail the probe
> with:
> 
> physmap-flash: probe of fff00000.small-flas failed with error -2
> 
> if there are no partition subnodes in the device tree and the old style binding
> is not used.  Since partition definitions are optional, the probe should still
> succeed.
> 
> Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Acked-by: David Gibson <david@gibson.dropbear.id.au>

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
