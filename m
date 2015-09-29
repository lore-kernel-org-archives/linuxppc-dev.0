Return-Path: <raghavendra.kt@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 600CE1A0D01
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2015 04:34:20 +1000 (AEST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <raghavendra.kt@linux.vnet.ibm.com>;
 Wed, 30 Sep 2015 00:04:18 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id C6BAD125801F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2015 00:03:50 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8TIXV4259965618
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2015 00:03:34 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8TIXUpC021018
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2015 00:03:31 +0530
Message-ID: <560AD9D4.1080203@linux.vnet.ibm.com>
Date: Wed, 30 Sep 2015 00:05:00 +0530
From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
CC: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 anton@samba.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, cl@linux.com, gkurz@linux.vnet.ibm.com,
 grant.likely@linaro.org, nikunj@linux.vnet.ibm.com,
 khandual@linux.vnet.ibm.com
Subject: Re: [PATCH RFC 3/5] powerpc:numa create 1:1 mappaing between chipid
 and nid
References: <1443378553-2146-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
 <1443378553-2146-4-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
 <20150928172817.GC48470@linux.vnet.ibm.com>
In-Reply-To: <20150928172817.GC48470@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/28/2015 10:58 PM, Nishanth Aravamudan wrote:
> On 27.09.2015 [23:59:11 +0530], Raghavendra K T wrote:
>> Once we have made the distinction between nid and chipid
>> create a 1:1 mapping between them. This makes compacting the
>> nids easy later.
>
>
> Didn't the previous patch just do the opposite of...
>

As per my thoughts it was:
1. rename functions to say loud that it is chipid (and not nid)
2. and then assign nid = chipid so that we are clear that
we made nid:chipid 1:1 mapping and compact nids later..

But again may be I should combine patch 2 and 3.
