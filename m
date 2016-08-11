Return-Path: <arbab@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s9C865xKvzDr0r
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 01:47:34 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3s9C860ZxPz9sR9
 for <linuxppc-dev@ozlabs.org>; Fri, 12 Aug 2016 01:47:33 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7BFiDA2082599
 for <linuxppc-dev@ozlabs.org>; Thu, 11 Aug 2016 11:47:31 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24qm9t238y-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 11 Aug 2016 11:47:30 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <arbab@linux.vnet.ibm.com>;
 Thu, 11 Aug 2016 09:47:30 -0600
Date: Thu, 11 Aug 2016 10:47:22 -0500
From: Reza Arbab <arbab@linux.vnet.ibm.com>
To: Mel Gorman <mgorman@techsingularity.net>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Paul Mackerras <paulus@ozlabs.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: mm: Initialise per_cpu_nodestats for all online pgdats at boot
References: <20160804092404.GI2799@techsingularity.net>
 <20160810175940.GA12039@arbab-laptop.austin.ibm.com>
 <20160811092808.GD8119@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
In-Reply-To: <20160811092808.GD8119@techsingularity.net>
Message-Id: <20160811154722.GC12039@arbab-laptop.austin.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 11, 2016 at 10:28:08AM +0100, Mel Gorman wrote:
>Fix looks ok. Can you add a proper changelog to it including an example
>oops or do you need me to do it?

Sure, no problem. Patch to follow.

-- 
Reza Arbab
