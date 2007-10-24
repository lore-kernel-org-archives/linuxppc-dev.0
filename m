Return-Path: <balbir@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (E23SMTP03.au.ibm.com [202.81.18.172])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp03.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 25D51DDF5F
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Oct 2007 19:54:11 +1000 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp03.au.ibm.com (8.13.1/8.13.1) with ESMTP id l9O9qxlL008787
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Oct 2007 19:52:59 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9O9uX6Y037400
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Oct 2007 19:56:33 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9O9qeuj003287
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Oct 2007 19:52:41 +1000
Message-ID: <471F15D5.3050100@linux.vnet.ibm.com>
Date: Wed, 24 Oct 2007 15:22:21 +0530
From: Balbir Singh <balbir@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] taskstats scaled time cleanup
References: <8789.1193208897@neuling.org>
In-Reply-To: <8789.1193208897@neuling.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, paulus@samba.org, linux390@de.ibm.com,
	akpm@linux-foundation.org
Reply-To: balbir@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael Neuling wrote:
> This moves the ability to scale cputime into generic code.  This
> allows us to fix the issue in kernel/timer.c (noticed by Balbir) where
> we could only add an unscaled value to the scaled utime/stime.
> 
> This adds a cputime_to_scaled function.  As before, the POWERPC
> version does the scaling based on the last SPURR/PURR ratio
> calculated.  The generic and s390 (only other arch to implement
> asm/cputime.h) versions are both NOPs.
> 
> Also moves the SPURR and PURR snapshots closer.
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>

Looks good to me

Acked-by: Balbir Singh <balbir@linux.vnet.ibm.com>

-- 
	Warm Regards,
	Balbir Singh
	Linux Technology Center
	IBM, ISTL
