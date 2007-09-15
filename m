Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp01.au.ibm.com (E23SMTP01.au.ibm.com [202.81.18.162])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp01.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 474AEDDE07
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Sep 2007 12:29:07 +1000 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp01.au.ibm.com (8.13.1/8.13.1) with ESMTP id l8F2T8Jo007511
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Sep 2007 12:29:08 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l8F2WdY6282260
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Sep 2007 12:32:39 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l8F2T5xJ012137
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Sep 2007 12:29:05 +1000
Date: Sat, 15 Sep 2007 12:22:28 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [patch 3/4] 4xx: Convert Walnut flash mappings to new binding
Message-ID: <20070915022228.GF25414@localhost.localdomain>
References: <20070914185410.387074000@linux.vnet.ibm.com>>
	<20070914185649.272138000@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070914185649.272138000@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Sep 14, 2007 at 01:54:13PM -0500, Josh Boyer wrote:
> A new binding for flash devices was recently introduced.  This updates the
> Walnut DTS to use the new binding.
> 
> Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Acked-by: David Gibson <david@gibson.dropbear.id.au>

We should both really figure out the vendor/device ids of the JEDEC
flash chips in use here and on Ebony, and add the appropriate
properties as per the binding.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
