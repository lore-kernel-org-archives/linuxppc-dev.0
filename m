Return-Path: <sachinp@in.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [59.145.155.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp08.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 00C2FDDD1C
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Mar 2009 03:53:36 +1100 (EST)
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
	by e28smtp08.in.ibm.com (8.13.1/8.13.1) with ESMTP id n25GR1ee024641
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Mar 2009 21:57:01 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n25GrcOr3301428
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Mar 2009 22:23:38 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.13.1/8.13.3) with ESMTP id n25GrUvD032443
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Mar 2009 22:23:31 +0530
Message-ID: <49B00389.7050407@in.ibm.com>
Date: Thu, 05 Mar 2009 22:23:29 +0530
From: "Sachin P. Sant" <sachinp@in.ibm.com>
MIME-Version: 1.0
To: michael@ellerman.id.au
Subject: Re: [Powerpc] Next March 5 build failure: platform/pseries/msi.o
References: <20090305195008.f4fd4ce0.sfr@canb.auug.org.au>
	<49AFB92B.8060606@in.ibm.com> <1236262014.8325.10.camel@localhost>
In-Reply-To: <1236262014.8325.10.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, linux-next@vger.kernel.org,
	Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael Ellerman wrote:
> Dang it, that's my fault. Thanks for catching it Sachin.
>
> I assumed pseries always enabled EEH, but I see now you can disable it
> if you have EMBEDDED set (which your config does).
>
> It's a bit yucky making the MSI code depend on EEH, but the only other
> option would be to pull half the EEH code out - so I guess that's what
> I'll do.
>
> Does this patch fix it?
Thanks for the patch Michael. It fixes the build break.

Regards
-Sachin

-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------
