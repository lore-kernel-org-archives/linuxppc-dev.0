Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3F48F1A0601
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2015 19:00:06 +1000 (AEST)
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 934841402B4
 for <linuxppc-dev@ozlabs.org>; Fri, 12 Jun 2015 19:00:05 +1000 (AEST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Fri, 12 Jun 2015 14:30:03 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 899DB3940068
 for <linuxppc-dev@ozlabs.org>; Fri, 12 Jun 2015 14:30:00 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5C8xxMt57671860
 for <linuxppc-dev@ozlabs.org>; Fri, 12 Jun 2015 14:29:59 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5C8xwAs019731
 for <linuxppc-dev@ozlabs.org>; Fri, 12 Jun 2015 14:29:59 +0530
Message-ID: <557A9F8D.3020200@linux.vnet.ibm.com>
Date: Fri, 12 Jun 2015 14:29:57 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Daniel Axtens <dja@axtens.net>
CC: linuxppc-dev@ozlabs.org, mikey@neuling.org, sukadev@linux.vnet.ibm.com
Subject: Re: [PATCH V8 10/10] selftests, powerpc: Add test for BHRB branch
 filters (HW & SW)
References: <1433763511-5270-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1433763511-5270-10-git-send-email-khandual@linux.vnet.ibm.com>
 <1433988561.31423.27.camel@axtens.net> <557A8414.8010500@linux.vnet.ibm.com>
 <557A89B3.8020005@linux.vnet.ibm.com>
In-Reply-To: <557A89B3.8020005@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/12/2015 12:56 PM, Madhavan Srinivasan wrote:
> 
> On Friday 12 June 2015 12:32 PM, Anshuman Khandual wrote:
>> > On 06/11/2015 07:39 AM, Daniel Axtens wrote:
>>> >> Hi,
>>> >>
>>> >> On Mon, 2015-06-08 at 17:08 +0530, Anshuman Khandual wrote:
>>>> >>> diff --git a/tools/testing/selftests/powerpc/pmu/bhrb/bhrb_filters.c b/tools/testing/selftests/powerpc/pmu/bhrb/bhrb_filters.c
>>>> >>> new file mode 100644
>>>> >>> index 0000000..13e6b72
>>>> >>> --- /dev/null
>>>> >>> +++ b/tools/testing/selftests/powerpc/pmu/bhrb/bhrb_filters.c
>>>> >>> @@ -0,0 +1,513 @@
>>>> >>> +/*
>>>> >>> + * BHRB filter test (HW & SW)
>>>> >>> + *
>>>> >>> + * Copyright 2015 Anshuman Khandual, IBM Corporation.
>>>> >>> + *
>>>> >>> + * This program is free software; you can redistribute it and/or
>>>> >>> + * modify it under the terms of the GNU General Public License
>>>> >>> + * as published by the Free Software Foundation; either version
>>>> >>> + * 2 of the License, or (at your option) any later version.
>>>> >>> + */
>>> >> This should also be gpl2 only.
>> > Why ? Any special reason ? I can see similar existing statements here
>> > in this file as well "powerpcC/primitives/load_unaligned_zeropad.c"
> For the new files, mpe suggested to use gpl2 only version of the license.
> 
>  This program is free software; you can redistribute it and/or modify it
>  under the terms of the GNU General Public License version 2 as published
>  by the Free Software Foundation.
> 
> Also, preferred format for Copyright line is to have "(C)" next to word
> Copyright

Sure, will accommodate both the proposed changes next time around.
