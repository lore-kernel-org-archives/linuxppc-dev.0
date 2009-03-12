Return-Path: <sachinp@in.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp06.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0E37CDE148
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Mar 2009 00:01:32 +1100 (EST)
Received: from d23relay02.au.ibm.com (d23relay02.au.ibm.com [202.81.31.244])
	by e23smtp06.au.ibm.com (8.13.1/8.13.1) with ESMTP id n2CD1Ifu014108
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Mar 2009 00:01:18 +1100
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay02.au.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n2CD1jp5970960
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Mar 2009 00:01:45 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n2CD1Rk1016371
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Mar 2009 00:01:27 +1100
Message-ID: <49B907A3.1030506@in.ibm.com>
Date: Thu, 12 Mar 2009 18:31:23 +0530
From: Sachin Sant <sachinp@in.ibm.com>
MIME-Version: 1.0
To: michael@ellerman.id.au
Subject: Re: Next 12 : arch/powerpc/sysdev/axonram build failure
References: <20090312171154.11c6ec31.sfr@canb.auug.org.au>
	<49B8C7FA.8090805@in.ibm.com> <1236860187.12893.5.camel@localhost>
In-Reply-To: <1236860187.12893.5.camel@localhost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael Ellerman wrote:
> So how about this:
>
> >From 7325aea8244ac83d98cde7a509ec8ab5994cdb0e Mon Sep 17 00:00:00 2001
> From: Michael Ellerman <michael@ellerman.id.au>
> Date: Thu, 12 Mar 2009 23:14:58 +1100
> Subject: [PATCH] powerpc/cell: axonram depends on BLOCK
>
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> ---
>  
Yup that works. Thanks.

Regards
-Sachin

-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------
