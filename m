Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0796F1A0923
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jun 2015 17:48:50 +1000 (AEST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Thu, 4 Jun 2015 13:18:48 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id DC099125805D
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jun 2015 13:21:10 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t547mPFl1048972
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Jun 2015 13:18:26 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t547mOcd024978
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Jun 2015 13:18:25 +0530
Message-ID: <557002C3.5050303@linux.vnet.ibm.com>
Date: Thu, 04 Jun 2015 13:18:19 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Daniel Axtens <dja@axtens.net>
CC: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Stephane Eranian <eranian@google.com>, Paul Mackerras <paulus@samba.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [PATCH v1 1/9]powerpc/powernv: Data structure and macros
 definition
References: <1433260778-26497-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1433260778-26497-2-git-send-email-maddy@linux.vnet.ibm.com>
 <1433286663.438.10.camel@axtens.net>
In-Reply-To: <1433286663.438.10.camel@axtens.net>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Wednesday 03 June 2015 04:41 AM, Daniel Axtens wrote:
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License
>> + * as published by the Free Software Foundation; either version
>> + * 2 of the License, or (at your option) any later version.
>> + */
> I'm not certain about this, but I _think_ this is supposed to be version
> 2 only:
> http://git.kernel.org/cgit/linux/kernel/git/stable/linux-stable.git/tree/COPYING#n9
I referred other files for license information from the same folder. So 
I could wait
for the maintainers comment on this.
>
>> +/*
>> + * Device tree parser code detect nest pmu support
>> + * and create new nest pmus. This structure will
>> + * hold the pmu functions and attrs for each nest pmu and
>> + * will be referenced at the time of pmu registering.
>> + */
> The first sentence of that comment is unclear: I think your trying to
> say "Device tree parser code detects nest pmu support and registers new
> nest pmus"? Also s/registering/registration/.
Yes. I will rewrite the comment.

>> +struct nest_pmu {
>> +	struct pmu pmu;
>> +	const struct attribute_group *attr_groups[4];
>> +};
>> +
> Regards,
> Daniel Axtens
Thanks for the review
Maddy
