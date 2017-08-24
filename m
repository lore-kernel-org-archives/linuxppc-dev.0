Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xdCYR3tWgzDqY3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 15:30:19 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7O5TDjh079811
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 01:30:17 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2chrcva4en-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 01:30:16 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Thu, 24 Aug 2017 15:30:13 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v7O5U2So39518264
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 15:30:10 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v7O5TcCL029126
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 15:29:38 +1000
Subject: Re: [PATCH kernel 0/5] powerpc/eeh: Some cleanups
To: Alexey Kardashevskiy <aik@ozlabs.ru>, Russell Currey <ruscur@russell.cc>,
 linuxppc-dev@lists.ozlabs.org
Cc: Alistair Popple <alistair@popple.id.au>,
 David Gibson <david@gibson.dropbear.id.au>
References: <20170823101901.33961-1-aik@ozlabs.ru>
 <1503537218.14064.5.camel@russell.cc>
 <3fd12aab-9bbb-1f80-3750-f0e08a0a4d06@ozlabs.ru>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Thu, 24 Aug 2017 15:29:13 +1000
MIME-Version: 1.0
In-Reply-To: <3fd12aab-9bbb-1f80-3750-f0e08a0a4d06@ozlabs.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <2cce5375-66c0-0c10-8538-7c60f508bca1@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 24/08/17 12:19, Alexey Kardashevskiy wrote:
> On 24/08/17 11:13, Russell Currey wrote:
>> On Wed, 2017-08-23 at 20:18 +1000, Alexey Kardashevskiy wrote:
>>> Here are few patches to get rid of some cached pointers across EEH and
>>> powernv code as I was struggling to figure out about lifetime of
>>> structures and so on.
>>
>> Thanks for the patches.  For the whole series:
>>
>> Acked-by: Russell Currey <ruscur@russell.cc>
> 
> 
> The patches are labelled as "Needs Review / ACK" in the patchworks, and
> until you reply to each individual patch, the "A" part of the "A/R/T"
> column will remain "- - -".

https://github.com/getpatchwork/patchwork/issues/113

Too late for the just-released patchwork 2.0, but maybe 2.1 won't be 
that far off. :)

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
