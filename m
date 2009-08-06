Return-Path: <sachinp@in.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 51841B7087
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  6 Aug 2009 14:40:54 +1000 (EST)
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp08.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C9D4EDDD0B
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Aug 2009 14:40:53 +1000 (EST)
Received: from d23relay02.au.ibm.com (d23relay02.au.ibm.com [202.81.31.244])
	by e23smtp08.au.ibm.com (8.14.3/8.13.1) with ESMTP id n764eNre011234
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Aug 2009 14:40:23 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay02.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n764enqr979110
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Aug 2009 14:40:49 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n764enQJ016572
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Aug 2009 14:40:49 +1000
Message-ID: <4A7A5ECE.10803@in.ibm.com>
Date: Thu, 06 Aug 2009 10:10:46 +0530
From: Sachin Sant <sachinp@in.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Next July 29 : Hugetlb test failure (OOPS free_hugepte_range)
References: <20090729173611.b82478cd.sfr@canb.auug.org.au>
	<4A706504.6040704@in.ibm.com> <4A719129.5030302@in.ibm.com>
	<1248957028.1509.85.camel@pasglop> <4A796237.6070302@in.ibm.com>
	<1249530754.18245.71.camel@pasglop>
In-Reply-To: <1249530754.18245.71.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> Does this patch fixes it ?
>
> [PATCH] powerpc/mm: Fix encoding of page table cache numbers
>
> The mask used to encode the page table cache number in the
> batch when freeing page tables was too small for the new
> possible values of MMU page sizes. This increases it along
> with a comment explaining the constraints.
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>   
Yes this patch fixed the issue for me. Thanks Ben.

Tested-by: Sachin Sant <sachinp@in.ibm.com>

Regards
-Sachin

-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------
