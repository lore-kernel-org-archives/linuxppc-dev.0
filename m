Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rrTv610WwzDqyY
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jul 2016 20:53:22 +1000 (AEST)
In-Reply-To: <1468284892-27765-1-git-send-email-dja@axtens.net>
To: Daniel Axtens <dja@axtens.net>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: arnd@arndb.de, Daniel Axtens <dja@axtens.net>
Subject: Re: [v2,1/5] powerpc/kvm: Clarify __user annotations
Message-Id: <3rrTv55KRdz9srY@ozlabs.org>
Date: Fri, 15 Jul 2016 20:53:20 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-12-07 at 00:54:48 UTC, Daniel Axtens wrote:
> kvmppc_h_put_tce_indirect labels a u64 pointer as __user. It also
> labelled the u64 where get_user puts the result as __user. This isn't
> a pointer and so doesn't need to be labelled __user.
> 
> Split the u64 value definition onto a new line to make it clear that
> it doesn't get the annotation.
> 
> Signed-off-by: Daniel Axtens <dja@axtens.net>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/f8750513b7001d5ae96313d4e1

cheers
