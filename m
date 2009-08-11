Return-Path: <sachinp@in.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 82BDAB6EDF
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 11 Aug 2009 15:25:09 +1000 (EST)
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [59.145.155.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp04.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9B706DDD04
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Aug 2009 15:25:06 +1000 (EST)
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by e28smtp04.in.ibm.com (8.14.3/8.13.1) with ESMTP id n7B5P1Em023845
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Aug 2009 10:55:01 +0530
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
	by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7B5P1W0630826
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Aug 2009 10:55:01 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
	by d28av04.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	n7B5P0sa030408
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Aug 2009 15:25:01 +1000
Message-ID: <4A8100AC.30404@in.ibm.com>
Date: Tue, 11 Aug 2009 10:55:00 +0530
From: Sachin Sant <sachinp@in.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: 2.6.31-rc5-git2 crash [net/core/flow.c:flow_cache_new_hashrnd]
References: <4A78292A.5000607@in.ibm.com> <4A783B1F.7000602@in.ibm.com>
	<1249395350.8016.5.camel@concordia>
	<1249597385.24311.10.camel@pasglop>
In-Reply-To: <1249597385.24311.10.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: netdev <netdev@vger.kernel.org>, David Miller <davem@davemloft.net>,
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
> BTW. Corruption looks like bi_recs... ie, broken yaboot. This was fixed
> recently, yaboot would eventually crap over the kernel for certain sizes
> of the kernel image.
>
> 0x1010 = BI_FIRST
> 0x1013 = BI_BOOTLOADER_ID followed by 0x7961626f6f74 which is
> "yaboot" :-)
> 0x1016 = BI_MACHTYPE
>   
Was away from office for few days.

Thanks for the help. The machine under test is running
F11. I will try out the latest yaboot.

Thanks
-Sachin



-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------
