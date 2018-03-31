Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40D0bJ3qTjzF1pr
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Apr 2018 01:04:12 +1100 (AEDT)
In-Reply-To: <1522118214-7040-1-git-send-email-linuxram@us.ibm.com>
To: Ram Pai <linuxram@us.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: fweimer@redhat.com, msuchanek@suse.com, linuxram@us.ibm.com,
 mhocko@kernel.org, paulus@samba.org, aneesh.kumar@linux.vnet.ibm.com,
 bauerman@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc/mm: Fix thread_pkey_regs_init()
Message-Id: <40D0bG6pQ1z9s34@ozlabs.org>
Date: Sun,  1 Apr 2018 01:04:10 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-03-27 at 02:36:54 UTC, Ram Pai wrote:
> thread_pkey_regs_init() initializes the pkey related registers
> instead of initializing the fields in the task structures.  Fortunately
> those key related registers are re-set to zero when the task
> gets scheduled on the cpu. However its good to fix this glaringly
> visible error.
> 
> cc: Michael Ellermen <mpe@ellerman.id.au>
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
> Acked-by: Balbir Singh <bsingharora@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/f208638680e5cb4eb0d2871ce8c29a

cheers
