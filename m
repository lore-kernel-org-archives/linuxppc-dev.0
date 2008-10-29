Return-Path: <dwg@au1.ibm.com>
Received: from ausmtp06.au.ibm.com (ausmtp06.au.ibm.com [202.81.18.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp06.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 89677DDDFD
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Oct 2008 10:42:52 +1100 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by ausmtp06.au.ibm.com (8.13.8/8.13.8) with ESMTP id m9TNfNpb4280438
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Oct 2008 10:41:23 +1100
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	m9TNZIB9239624
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Oct 2008 10:35:18 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m9TNZI0c015922
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Oct 2008 10:35:18 +1100
Date: Thu, 30 Oct 2008 10:35:15 +1100
From: David Gibson <dwg@au1.ibm.com>
To: akpm@linux-foundation.org
Subject: Re: [patch 1/1] powerpc: hugetlb pgtable cache access cleanup
Message-ID: <20081029233515.GA12101@yookeroo.seuss>
References: <200810292118.m9TLIU7J018621@imap1.linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200810292118.m9TLIU7J018621@imap1.linux-foundation.org>
Cc: linuxppc-dev@ozlabs.org, kniht@linux.vnet.ibm.com, paulus@samba.org,
	nickpiggin@yahoo.com.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Oct 29, 2008 at 02:18:30PM -0700, akpm@linux-foundation.org wrote:
> From: Jon Tollefson <kniht@linux.vnet.ibm.com>
> 
> Cleaned up use of macro.  We now reference the pgtable_cache array
> directly instead of using a macro.
> 
> Signed-off-by: Jon Tollefson <kniht@linux.vnet.ibm.com>
> Cc: Nick Piggin <nickpiggin@yahoo.com.au>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

Well, I'm not entirely sure I see the point.  But I don't see anything
broken about it.

Acked-by: David Gibson <david@gibson.dropbear.id.au>

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
