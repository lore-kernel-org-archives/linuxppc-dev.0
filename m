Return-Path: <nikunj@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3F0E11A027E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jun 2015 16:46:42 +1000 (AEST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nikunj@linux.vnet.ibm.com>;
 Fri, 26 Jun 2015 16:46:41 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 2D4C82CE8040
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jun 2015 16:46:37 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5Q6kQZQ1049072
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jun 2015 16:46:34 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5Q6k4i4019940
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jun 2015 16:46:04 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
To: Anton Blanchard <anton@samba.org>, "Michael Ellerman" <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org,
 linux-kernel@vger.kernel.org, bharata@linux.vnet.ibm.com
Subject: Re: [RFC PATCH] powerpc/numa: initialize distance lookup table from
 drconf path
In-Reply-To: <87d20mewk2.fsf@linux.vnet.ibm.com>
References: <1433911816-854-1-git-send-email-nikunj@linux.vnet.ibm.com>
 <87lhfs5ewc.fsf@linux.vnet.ibm.com> <20150623111648.1e31a497@kryten>
 <87d20mewk2.fsf@linux.vnet.ibm.com>
Date: Fri, 26 Jun 2015 12:15:37 +0530
Message-ID: <87fv5fynla.fsf@linux.vnet.ibm.com>
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


Hi Anton/Michael,

Nikunj A Dadhania <nikunj@linux.vnet.ibm.com> writes:
> Hi Anton,
>
> Anton Blanchard <anton@samba.org> writes:
>> Hi Nikunj,
>>
>>> From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
>>> 
>>> powerpc/numa: initialize distance lookup table from drconf path
>>> 
>>> In some situations, a NUMA guest that supports
>>> ibm,dynamic-memory-reconfiguration node will end up having flat NUMA
>>> distances between nodes. This is because of two problems in the
>>> current code.
>>
>> Thanks for the patch. Have we tested that this doesn't regress the
>> non dynamic representation?
>
> Yes, that is tested. And works as expected.

If the patch looks fine, can this be pushed upstream ?

Regards,
Nikunj
