Return-Path: <srs0=yflj=iz=gmail.com=npiggin@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 411hzK5QtnzF33m
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jun 2018 20:46:05 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 411hzK4lGtz8tKk
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jun 2018 20:46:05 +1000 (AEST)
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 411hzK19NXz9s1b
 for <linuxppc-dev@ozlabs.org>; Thu,  7 Jun 2018 20:46:04 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id e11-v6so4578940pgq.0
 for <linuxppc-dev@ozlabs.org>; Thu, 07 Jun 2018 03:46:04 -0700 (PDT)
Date: Thu, 7 Jun 2018 20:45:54 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Laurent Dufour
 <ldufour@linux.vnet.ibm.com>, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [v2 PATCH 0/5] powerpc/pseries: Machien check handler
 improvements.
Message-ID: <20180607204554.05565a56@roar.ozlabs.ibm.com>
In-Reply-To: <152836568375.29173.3046879842311381046.stgit@jupiter.in.ibm.com>
References: <152836568375.29173.3046879842311381046.stgit@jupiter.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 07 Jun 2018 15:36:25 +0530
Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:

> This patch series includes some improvement to Machine check handler
> for pseries. Patch 1 fixes an issue where machine check handler crashes
> kernel while accessing vmalloc-ed buffer while in nmi context.
> Patch 3 dumps the SLB contents on SLB MCE errors to improve the debugability.
> Patch 4 display's the MCE error details on console.
> 
> Change in V2:
> - patch 4: Display additional info (NIP and task info) in MCE error details.
> - patch 5: Fix endain bug while restoring of r3 in MCE handler.
> 
> ---
> 
> Mahesh Salgaonkar (5):
>       powerpc/pseries: convert rtas_log_buf to linear allocation.
>       powerpc/pseries: Define MCE error event section.
>       powerpc/pseries: Dump and flush SLB contents on SLB MCE errors.
>       powerpc/pseries: Display machine check error details.
>       powerpc/pseries: Fix endainness while restoring of r3 in MCE handler.

These look good, should patch 5 be moved to patch 2 and the first 2
patches marked for stable?

Do you also plan to dump SLB contents for bare metal MCEs?

Thanks,
Nick
