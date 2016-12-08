Return-Path: <sachinp@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tZ5582MCRzDsgv
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Dec 2016 17:27:40 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uB86Oo87143241
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 8 Dec 2016 01:27:38 -0500
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [125.16.236.9])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2771ggtd49-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Dec 2016 01:27:37 -0500
Received: from localhost
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sachinp@linux.vnet.ibm.com>;
 Thu, 8 Dec 2016 11:57:32 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 138CC3940060
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Dec 2016 11:57:30 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uB86RTtS29556738
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 8 Dec 2016 11:57:29 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uB86RQkD006129
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 8 Dec 2016 11:57:28 +0530
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.1 \(3251\))
Subject: Re: -next build failure with gcc 5.2.1
From: Sachin Sant <sachinp@linux.vnet.ibm.com>
In-Reply-To: <798a8079-6d96-6a9c-b413-21e46f0fcbb0@gmail.com>
Date: Thu, 8 Dec 2016 11:57:25 +0530
Cc: linux-next@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
 linuxppc-dev@lists.ozlabs.org
References: <8BC02969-0A0D-4C59-8E5E-31F5FC2B1391@linux.vnet.ibm.com>
 <798a8079-6d96-6a9c-b413-21e46f0fcbb0@gmail.com>
To: Balbir Singh <bsingharora@gmail.com>
Message-Id: <5CF53903-E68A-42C5-93B9-767F417EE837@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> On 08-Dec-2016, at 7:39 AM, Balbir Singh <bsingharora@gmail.com> =
wrote:
>=20
> On 12/07/2016 07:26 PM, Sachin Sant wrote:
>> next tree fails to build on a ppc64le box with following message
>>=20
>>  LD      init/built-in.o
>>  LD      vmlinux.o
>>  MODPOST vmlinux.o
>> WARNING: modpost: Found 3 section mismatch(es).
>> To see full details build your kernel with:
>> 'make CONFIG_DEBUG_SECTION_MISMATCH=3Dy'
>>  KSYM    .tmp_kallsyms1.o
>> kallsyms failure: relative symbol value 0xc000000000000000 out of =
range in relative mode
>> Makefile:969: recipe for target 'vmlinux' failed
>> make: *** [vmlinux] Error 1
>>=20
>> GCC version is : gcc version 5.2.1 20151010 (Ubuntu 5.2.1-22ubuntu2)
>>=20
>> Have attached kernel config file.
>>=20
>=20
> Thanks, would you be in a position to bisect?

Yes. It seems Stephen has already found the commit causing this.=20

Thanks
-Sachin
