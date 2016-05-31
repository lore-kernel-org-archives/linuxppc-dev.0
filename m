Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rJqDB4v7ZzDqfY
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 May 2016 20:17:14 +1000 (AEST)
In-Reply-To: <1463052551-18206-1-git-send-email-thuth@redhat.com>
To: Thomas Huth <thuth@redhat.com>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Alexander Graf <agraf@suse.de>, kvm-ppc@vger.kernel.org
Subject: Re: powerpc: Use privileged SPR number for MMCR2
Message-Id: <3rJqDB3nmxz9t5Q@ozlabs.org>
Date: Tue, 31 May 2016 20:17:14 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-12-05 at 11:29:11 UTC, Thomas Huth wrote:
> We are already using the privileged versions of MMCR0, MMCR1
> and MMCRA in the kernel, so for MMCR2, we should better use
> the privileged versions, too, to be consistent.
> 
> Suggested-by: Paul Mackerras <paulus@ozlabs.org>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> Acked-by: Paul Mackerras <paulus@ozlabs.org>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/8dd75ccb571f3c92c48014b3da

cheers
