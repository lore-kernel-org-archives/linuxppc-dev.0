Return-Path: <brking@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6AE9FDDE23
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Dec 2008 10:07:17 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id mB4N5wIl006368
	for <linuxppc-dev@ozlabs.org>; Thu, 4 Dec 2008 16:05:58 -0700
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mB4N77CN094766
	for <linuxppc-dev@ozlabs.org>; Thu, 4 Dec 2008 16:07:08 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mB4N77BP030771
	for <linuxppc-dev@ozlabs.org>; Thu, 4 Dec 2008 16:07:07 -0700
Message-ID: <4938626A.5070801@linux.vnet.ibm.com>
Date: Thu, 04 Dec 2008 17:06:18 -0600
From: Brian King <brking@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 1/1] powerpc: Check for valid hugepage size in
	hugetlb_get_unmapped_area
References: <200812041408.mB4E8fRV002401@d01av03.pok.ibm.com>
	<18744.25000.311915.697199@cargo.ozlabs.ibm.com>
In-Reply-To: <18744.25000.311915.697199@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, kniht@linux.vnet.ibm.com, agl@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Mackerras wrote:
> Brian King writes:
> 
>> It looks like most of the hugetlb code is doing the correct thing if
>> hugepages are not supported, but the mmap code is not. If we get into
>> the mmap code when hugepages are not supported, such as in an LPAR
>> which is running Active Memory Sharing, we can oops the kernel. This
>> patch fixes the oops being seen in this path.
> 
> Sounds like this is a regression since 2.6.27 - is it?  In any case, I
> assume this needs to go to Linus for 2.6.28.  Do you agree?

This should go to Linus for 2.6.28

Thanks,

Brian

-- 
Brian King
Linux on Power Virtualization
IBM Linux Technology Center
