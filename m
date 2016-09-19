Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3scskX3QC5zDshB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 14:05:56 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8J42tNc080815
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 00:05:54 -0400
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [125.16.236.8])
 by mx0b-001b2d01.pphosted.com with ESMTP id 25h21351mw-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 00:05:53 -0400
Received: from localhost
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 19 Sep 2016 09:35:50 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 2FEF6E0024
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 09:35:08 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8J45muB33161408
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 09:35:48 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8J45kgQ029345
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 09:35:47 +0530
Subject: Re: [PATCH 03/13] powerpc: move set_soft_enabled() and rename
To: Nicholas Piggin <npiggin@gmail.com>
References: <1473944523-624-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1473944523-624-4-git-send-email-maddy@linux.vnet.ibm.com>
 <20160916195049.3e976b2e@roar.ozlabs.ibm.com>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, anton@samba.org,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Mon, 19 Sep 2016 09:35:46 +0530
MIME-Version: 1.0
In-Reply-To: <20160916195049.3e976b2e@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <b25ea8ee-2c49-ad5e-6ba0-3f07f74b23be@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Friday 16 September 2016 03:20 PM, Nicholas Piggin wrote:
> On Thu, 15 Sep 2016 18:31:53 +0530
> Madhavan Srinivasan <maddy@linux.vnet.ibm.com> wrote:
>
>> Move set_soft_enabled() from powerpc/kernel/irq.c to
>> asm/hw_irq.c. and rename it soft_enabled_set().
>> THis way paca->soft_enabled updates can be forced.
> Could you just tidy up the changelog a little?
>
> You are renaming it I assume because you are going to introduce more
> soft_enabled_x() functions, and that the namespace works better as a
> prefix than a postfix.
>
> You are moving it so all paca->soft_enabled updates can be done via
> these access functions rather than open coded.
>
> Did I get that right?

Yes. That is right. My bad. Will fix the commit message and changelog.

>
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
>
