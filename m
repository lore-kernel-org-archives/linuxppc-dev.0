Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3scsjJ0mf8zDscr
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 14:04:51 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8J438WA055440
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 00:04:49 -0400
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [125.16.236.5])
 by mx0b-001b2d01.pphosted.com with ESMTP id 25gyyur8u2-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 00:04:48 -0400
Received: from localhost
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 19 Sep 2016 09:34:45 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id ABB1AE0024
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 09:34:02 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8J44gSY34078820
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 09:34:42 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8J44dhx027134
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 09:34:42 +0530
Subject: Re: [PATCH 02/13] powerpc: Cleanup to use IRQ_DISABLE_MASK_* macros
 for paca->soft_enabled update
To: Nicholas Piggin <npiggin@gmail.com>
References: <1473944523-624-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1473944523-624-3-git-send-email-maddy@linux.vnet.ibm.com>
 <20160916194729.3c0bfa9b@roar.ozlabs.ibm.com>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, anton@samba.org,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Mon, 19 Sep 2016 09:34:37 +0530
MIME-Version: 1.0
In-Reply-To: <20160916194729.3c0bfa9b@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <ee4cf795-2678-2d39-95ec-3ddcdfad653c@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Friday 16 September 2016 03:17 PM, Nicholas Piggin wrote:
> On Thu, 15 Sep 2016 18:31:52 +0530
> Madhavan Srinivasan <maddy@linux.vnet.ibm.com> wrote:
>
>> Replace the hardcoded values used when updating
>> paca->soft_enabled with IRQ_DISABLE_MASK_* #def.
>> No logic change.
> This could be folded with patch 1.

Sure. Will do it.
>
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
>
