Return-Path: <agraf@suse.de>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1137E1A01E7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2015 17:51:28 +1000 (AEST)
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 96A80140187
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2015 17:51:27 +1000 (AEST)
Message-ID: <553F3BFB.1020002@suse.de>
Date: Tue, 28 Apr 2015 09:51:23 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc/kvm: Fix SMP=n build error in book3s_xics.c
References: <1430181767-2193-1-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1430181767-2193-1-git-send-email-mpe@ellerman.id.au>
Content-Type: text/plain; charset=windows-1252
Cc: warrier@linux.vnet.ibm.com, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 28.04.15 02:42, Michael Ellerman wrote:
> Commit 34cb7954c0aa "Convert ICS mutex lock to spin lock" added an
> include of asm/spinlock.h, which does not work in the SMP=n case.
> 
> It should instead include linux/spinlock.h
> 
> Fixes: 34cb7954c0aa ("KVM: PPC: Book3S HV: Convert ICS mutex lock to spin lock")
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Reviewed-by: Alexander Graf <agraf@suse.de>


Alex
