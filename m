Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 410b7l2zd8zF1lm
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jun 2018 01:19:31 +1000 (AEST)
In-Reply-To: <1525464111-1096-1-git-send-email-linuxram@us.ibm.com>
To: Ram Pai <linuxram@us.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: dave.hansen@intel.com, msuchanek@suse.com, Ulrich.Weigand@de.ibm.com,
 linuxram@us.ibm.com, mhocko@kernel.org, paulus@samba.org,
 aneesh.kumar@linux.vnet.ibm.com, bauerman@linux.vnet.ibm.com,
 Shakeel Butt <shakeelb@google.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc/pkeys: Detach execute_only key on !PROT_EXEC
Message-Id: <410b7l0wxRz9s0x@ozlabs.org>
Date: Wed,  6 Jun 2018 01:19:30 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2018-05-04 at 20:01:51 UTC, Ram Pai wrote:
> Disassociate the exec_key from a VMA if the VMA permission is not
> PROT_EXEC anymore.  Otherwise the exec_only key continues to be
> associated with the vma, causing unexpected behavior.
> 
> The problem was reported on x86 by Shakeel Butt,
> which is also applicable on powerpc.
> 
> cc: Shakeel Butt <shakeelb@google.com>
> Reported-by: Shakeel Butt <shakeelb@google.com>
> Fixes 5586cf6 ("powerpc: introduce execute-only pkey")
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/eabdb8ca8690eedd461e61ea778059

cheers
