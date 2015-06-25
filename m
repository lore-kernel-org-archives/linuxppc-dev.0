Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 69C481A1DD2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jun 2015 22:53:34 +1000 (AEST)
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C765B1402DE
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Jun 2015 22:53:33 +1000 (AEST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Thu, 25 Jun 2015 18:23:32 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 6A6971258044
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Jun 2015 18:26:09 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5PCrSvs53870638
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Jun 2015 18:23:28 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5PBoL9c027169
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Jun 2015 17:20:22 +0530
Message-ID: <558BF989.4010005@linux.vnet.ibm.com>
Date: Thu, 25 Jun 2015 18:22:25 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Daniel Axtens <dja@axtens.net>
CC: linuxppc-dev@ozlabs.org, mikey@neuling.org, sukadev@linux.vnet.ibm.com
Subject: Re: [PATCH V9 06/13] powerpc, perf: Re organize BHRB processing
References: <1434370268-19056-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1434370268-19056-7-git-send-email-khandual@linux.vnet.ibm.com>
 <1435211538.4286.42.camel@axtens.net>
In-Reply-To: <1435211538.4286.42.camel@axtens.net>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/25/2015 11:22 AM, Daniel Axtens wrote:
> 
>> +static void insert_branch(struct cpu_hw_events *cpuhw,
>> +			int index, u64 from, u64 to, int mispred)
> Given that your previous patch made mispred a bool, this could take a
> bool too. It could probably be an inline function as well.

Sure. will change it.
