Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B445A2C0040
 for <linuxppc-dev@ozlabs.org>; Wed,  5 Feb 2014 19:52:28 +1100 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 5 Feb 2014 14:22:23 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id B3B50E0057
 for <linuxppc-dev@ozlabs.org>; Wed,  5 Feb 2014 14:25:32 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s158qHCS16253034
 for <linuxppc-dev@ozlabs.org>; Wed, 5 Feb 2014 14:22:17 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s158qFEM005125
 for <linuxppc-dev@ozlabs.org>; Wed, 5 Feb 2014 14:22:16 +0530
Message-ID: <52F1FB75.9090007@linux.vnet.ibm.com>
Date: Wed, 05 Feb 2014 14:21:01 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Linux PPC dev <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH V2] power7, perf: Make some new raw event codes available
 in sysfs
References: <52C4F303.80007@linux.vnet.ibm.com>
In-Reply-To: <52C4F303.80007@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Michael Ellerman <michael@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/02/2014 10:32 AM, Anshuman Khandual wrote:
> This patchset adds some missing event list for POWER7 PMU raw
> events which are exported through sysfs interface. Also updates
> the ABI documentation to add all the sysfs exported raw events.
> 
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> ---
>  .../testing/sysfs-bus-event_source-devices-events  | 517 +++++++++++++++++++++
>  arch/powerpc/perf/power7-events-list.h             |  10 +
>  2 files changed, 527 insertions(+)

Hey Michael,

Any updates on this patch ? This does not seem to be merged yet.


Regards
Anshuman
