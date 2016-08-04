Return-Path: <arbab@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s4vRT5mkXzDqWt
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Aug 2016 01:45:57 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3s4vRT1tMFz9sDG
 for <linuxppc-dev@ozlabs.org>; Fri,  5 Aug 2016 01:45:57 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u74FY66A044238
 for <linuxppc-dev@ozlabs.org>; Thu, 4 Aug 2016 11:45:55 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24kkakc7sg-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 04 Aug 2016 11:45:54 -0400
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <arbab@linux.vnet.ibm.com>;
 Thu, 4 Aug 2016 09:45:54 -0600
Date: Thu, 4 Aug 2016 10:45:48 -0500
From: Reza Arbab <arbab@linux.vnet.ibm.com>
To: Mel Gorman <mgorman@techsingularity.net>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Paul Mackerras <paulus@ozlabs.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: mm: Initialise per_cpu_nodestats for all online pgdats at boot
References: <20160804092404.GI2799@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
In-Reply-To: <20160804092404.GI2799@techsingularity.net>
Message-Id: <20160804154548.GD28305@arbab-laptop.austin.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 04, 2016 at 10:24:04AM +0100, Mel Gorman wrote:
>This has been compile-tested and boot-tested on a 32-bit KVM only. A
>memoryless system was not available to test the patch with. A confirmation
>from Paul and Reza that it resolves their problem is welcome.

Works for me. Thanks, Mel!

Tested-by: Reza Arbab <arbab@linux.vnet.ibm.com>

-- 
Reza Arbab
