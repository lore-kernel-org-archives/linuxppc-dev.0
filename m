Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2F6651A02DE
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Mar 2016 22:25:35 +1100 (AEDT)
Received: from localhost
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Thu, 10 Mar 2016 16:15:37 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2AAjAlP3604752
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Mar 2016 16:15:10 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2AGE6nB030489
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Mar 2016 21:44:08 +0530
Message-ID: <56E15032.5060302@linux.vnet.ibm.com>
Date: Thu, 10 Mar 2016 16:15:06 +0530
From: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>
MIME-Version: 1.0
To: mpe@ellerman.id.au
CC: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 benh@kernel.crashing.org, paulus@samba.org, mahesh@linux.vnet.ibm.com,
 maddy@linux.vnet.ibm.com
Subject: Re: [PATCH 0/3] powerpc/powernv: Cpuidle related cleanup
References: <1456748580-10519-1-git-send-email-shreyas@linux.vnet.ibm.com>
In-Reply-To: <1456748580-10519-1-git-send-email-shreyas@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,
Any thoughts on this?


On 02/29/2016 05:52 PM, Shreyas B. Prabhu wrote:
> These patches are purely code movement and cleanup.
> There is no functionality change.
> 
> Note, there are multiple style error reported for patch 1 and 2.
> I think this is because checkpatch script mistakes the patches
> as C code because of the presence of semi-colon in each line. I
> for now have largely ignored these errors.
> 
> Shreyas B. Prabhu (3):
>   powerpc/powernv: Move CHECK_HMI_INTERRUPT to exception-64s header
>   powerpc/powernv: Encapsulate idle preparation steps in a macro
>   powerpc/powernv: make hypervisor state restore a function
> 
>  arch/powerpc/include/asm/cpuidle.h       |  68 ++++++++++++++
>  arch/powerpc/include/asm/exception-64s.h |  19 ++++
>  arch/powerpc/kernel/exceptions-64s.S     |  29 +-----
>  arch/powerpc/kernel/idle_power7.S        | 148 ++++++++-----------------------
>  4 files changed, 129 insertions(+), 135 deletions(-)
> 
