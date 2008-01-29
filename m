Return-Path: <balbir@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [59.145.155.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp01.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D303FDDE0A
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jan 2008 16:21:22 +1100 (EST)
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
	by e28smtp01.in.ibm.com (8.13.1/8.13.1) with ESMTP id m0U5LDxQ010917
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jan 2008 10:51:13 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m0U5LDe7762008
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jan 2008 10:51:13 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.13.1/8.13.3) with ESMTP id m0U5LHBO023252
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jan 2008 05:21:17 GMT
Date: Tue, 29 Jan 2008 19:20:19 +0530
From: Balbir Singh <balbir@linux.vnet.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH powerpc] Fake NUMA emulation for PowerPC (Take 3)
Message-ID: <20080129135019.GC16034@balbir.in.ibm.com>
References: <20071207223714.11448.91386.sendpatchset@balbir-laptop>
	<1200634493.7806.0.camel@concordia.ozlabs.ibm.com>
	<1200635099.7806.3.camel@concordia.ozlabs.ibm.com>
	<20080126071339.GA25328@balbir.in.ibm.com>
	<18332.28991.658933.763115@cargo.ozlabs.ibm.com>
	<20080128125206.GC4330@balbir.in.ibm.com>
	<1201611898.26410.7.camel@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1201611898.26410.7.camel@concordia>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	LKML <linux-kernel@vger.kernel.org>
Reply-To: balbir@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

* Michael Ellerman <michael@ellerman.id.au> [2008-01-30 00:04:58]:

> Why do you check !p after assigning to nid? I assume it's because we
> might have reached the end of the command line, ie. p == NULL, but we're
> still adding memory to the last node? If so it's a it's a little subtle
> and deserves a comment I think.
>

The reason that we check for !p after assigning node id is that, in
case we create fake NUMA nodes, we want nid to be the fake numa node
id and not the real node id or in the non NUMA case, node id 0.

The if (!p) checks to see if we do have more arguments to parse.
 
> Otherwise this looks pretty good.
> 

Thanks!

> cheers
> 
> -- 
> Michael Ellerman
> OzLabs, IBM Australia Development Lab
> 
> wwweb: http://michael.ellerman.id.au
> phone: +61 2 6212 1183 (tie line 70 21183)
> 
> We do not inherit the earth from our ancestors,
> we borrow it from our children. - S.M.A.R.T Person



-- 
	Warm Regards,
	Balbir Singh
	Linux Technology Center
	IBM, ISTL
