Return-Path: <nikunj@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0535E1A1147
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2015 17:03:25 +1000 (AEST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nikunj@linux.vnet.ibm.com>;
 Tue, 23 Jun 2015 12:33:18 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id DD249394006D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2015 12:33:13 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5N739ZU49283138
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2015 12:33:12 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5N62NqR030180
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2015 11:32:24 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
To: Anton Blanchard <anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org,
 linux-kernel@vger.kernel.org, bharata@linux.vnet.ibm.com
Subject: Re: [RFC PATCH] powerpc/numa: initialize distance lookup table from
 drconf path
In-Reply-To: <20150623111648.1e31a497@kryten>
References: <1433911816-854-1-git-send-email-nikunj@linux.vnet.ibm.com>
 <87lhfs5ewc.fsf@linux.vnet.ibm.com> <20150623111648.1e31a497@kryten>
Date: Tue, 23 Jun 2015 12:33:09 +0530
Message-ID: <87d20mewk2.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi Anton,

Anton Blanchard <anton@samba.org> writes:
> Hi Nikunj,
>
>> From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
>> 
>> powerpc/numa: initialize distance lookup table from drconf path
>> 
>> In some situations, a NUMA guest that supports
>> ibm,dynamic-memory-reconfiguration node will end up having flat NUMA
>> distances between nodes. This is because of two problems in the
>> current code.
>
> Thanks for the patch. Have we tested that this doesn't regress the
> non dynamic representation?

Yes, that is tested. And works as expected.

Regards
Nikunj
