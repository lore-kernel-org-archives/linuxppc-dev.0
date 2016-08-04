Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s4kQc3fGbzDqQ1
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Aug 2016 18:59:36 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3s4kQc0BkHz9sBr
 for <linuxppc-dev@ozlabs.org>; Thu,  4 Aug 2016 18:59:35 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u748xB6X091939
 for <linuxppc-dev@ozlabs.org>; Thu, 4 Aug 2016 04:59:34 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24kkags70v-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 04 Aug 2016 04:59:34 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Thu, 4 Aug 2016 18:59:31 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 4EAC12BB0057
 for <linuxppc-dev@ozlabs.org>; Thu,  4 Aug 2016 18:59:28 +1000 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u748xSWL25559128
 for <linuxppc-dev@ozlabs.org>; Thu, 4 Aug 2016 18:59:28 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u748xRfI007803
 for <linuxppc-dev@ozlabs.org>; Thu, 4 Aug 2016 18:59:28 +1000
Subject: Re: [PATCH] powerpc/book3s: Fix MCE console messages for
 unrecoverable MCE.
To: Greg KH <gregkh@linuxfoundation.org>
References: <147028600879.16761.7577655191376075114.stgit@jupiter.in.ibm.com>
 <20160804080521.GA19251@kroah.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Paul Mackerras <paulus@samba.org>, stable@vger.kernel.org
From: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Thu, 4 Aug 2016 14:29:25 +0530
MIME-Version: 1.0
In-Reply-To: <20160804080521.GA19251@kroah.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <4c34d692-7331-254e-5f25-d08b2037ff44@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/04/2016 01:35 PM, Greg KH wrote:
> On Thu, Aug 04, 2016 at 10:16:48AM +0530, Mahesh J Salgaonkar wrote:
>> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>>
>> When machine check occurs with MSR(RI=0), it means MC interrupt is
>> unrecoverable and kernel goes down to panic path. But the console
>> message still shows it as recovered. This patch fixes the MCE console
>> messages.
>>
>> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/kernel/mce.c             |    3 ++-
>>  arch/powerpc/platforms/powernv/opal.c |    2 ++
>>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> 
> <formletter>
> 
> This is not the correct way to submit patches for inclusion in the
> stable kernel tree.  Please read Documentation/stable_kernel_rules.txt
> for how to do this properly.
> 
> </formletter>
> 

Ouch. My mistake. Will follow Documentation/stable_kernel_rules.txt

Thanks,
-Mahesh.
