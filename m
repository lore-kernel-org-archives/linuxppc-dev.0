Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 80D4A1A01E7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2015 17:57:12 +1000 (AEST)
Date: Tue, 28 Apr 2015 14:36:12 +1000
From: Paul Mackerras <paulus@samba.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc/kvm: Fix SMP=n build error in book3s_xics.c
Message-ID: <20150428043612.GA28239@iris.ozlabs.ibm.com>
References: <1430181767-2193-1-git-send-email-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1430181767-2193-1-git-send-email-mpe@ellerman.id.au>
Cc: warrier@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org, agraf@suse.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Apr 28, 2015 at 10:42:47AM +1000, Michael Ellerman wrote:
> Commit 34cb7954c0aa "Convert ICS mutex lock to spin lock" added an
> include of asm/spinlock.h, which does not work in the SMP=n case.
> 
> It should instead include linux/spinlock.h
> 
> Fixes: 34cb7954c0aa ("KVM: PPC: Book3S HV: Convert ICS mutex lock to spin lock")
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Acked-by: Paul Mackerras <paulus@samba.org>
