Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp04.au.ibm.com (E23SMTP04.au.ibm.com [202.81.18.173])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C4C9FDE238
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 14:37:13 +1100 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.18.234])
	by e23smtp04.au.ibm.com (8.13.1/8.13.1) with ESMTP id m0A3auVU004061
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 14:36:56 +1100
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m0A3bB5Z3698720
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 14:37:11 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m0A3bBk6008364
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 14:37:11 +1100
Date: Thu, 10 Jan 2008 14:35:26 +1100
From: David Gibson <dwg@au1.ibm.com>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: [PATCH 2/5] Warp Base Platform - dts
Message-ID: <20080110033526.GH17816@localhost.localdomain>
References: <20080109211758.26c8e235@zod.rchland.ibm.com>
	<47859224.70109@pikatech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <47859224.70109@pikatech.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 09, 2008 at 10:33:56PM -0500, Sean MacLennan wrote:
> Ok, the FPGA is off the EBC, I found it in the documentation.
> 
> Under the ebc, I notice the walnut has @n,m. What are n,m? Are they tied 
> to chip selects?

n is the chipselect, m is the address offset within that chipselect.

> The FPGA is CS2 according to the documentation. Do I make it
> fpga@2,0?

Probably, yes.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
