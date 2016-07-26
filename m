Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rz6zs163YzDrJ3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 16:05:28 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6Q63XhJ027040
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 02:05:26 -0400
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [125.16.236.6])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24dmhytads-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 02:05:26 -0400
Received: from localhost
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Tue, 26 Jul 2016 11:35:22 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 6F6A6E0060
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 11:39:33 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6Q65J2b63504572
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 11:35:19 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6Q65IFM023334
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 11:35:19 +0530
Subject: Re: [RFC PATCH 1/9] Add #defs for paca->soft_enabled flags
To: Nicholas Piggin <npiggin@gmail.com>
References: <1469458342-26233-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1469458342-26233-2-git-send-email-maddy@linux.vnet.ibm.com>
 <20160726152706.43bffd08@roar.ozlabs.ibm.com>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, anton@samba.org,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Tue, 26 Jul 2016 11:35:16 +0530
MIME-Version: 1.0
In-Reply-To: <20160726152706.43bffd08@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <1ee595c7-2c1e-82f4-4d1b-33fa9074c545@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Tuesday 26 July 2016 10:57 AM, Nicholas Piggin wrote:
> On Mon, 25 Jul 2016 20:22:14 +0530
> Madhavan Srinivasan <maddy@linux.vnet.ibm.com> wrote:
>
>> Two #defs LAZY_INTERRUPT_ENABLED and
>> LAZY_INTERRUPT_DISABLED are added to be used
>> when updating paca->soft_enabled.
> This is a very nice patchset, but can this not be a new name?

Thanks, but idea is from ben :)
Regarding the name, I looked at the initial patchset posted by
paul and took the name from it :).

But will work on that, any suggestion for the name?

Maddy

> We use "soft enabled/disabled" everywhere for it. I think lazy
> is an implementation detail anyway because some interrupts don't
> cause a hard disable at all.
>
> Thanks,
> Nick
>
