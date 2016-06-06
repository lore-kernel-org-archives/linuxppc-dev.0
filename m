Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rNFdY4gRBzDqG1
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Jun 2016 10:17:37 +1000 (AEST)
In-Reply-To: <1464673877-30659-1-git-send-email-thuth@redhat.com>
To: Thomas Huth <thuth@redhat.com>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: kvm-ppc@vger.kernel.org
Subject: Re: powerpc/pseries: Add POWER8NVL support to ibm,
 client-architecture-support call
Message-Id: <3rNFdY3lkKz9t4P@ozlabs.org>
Date: Mon,  6 Jun 2016 10:17:37 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-31-05 at 05:51:17 UTC, Thomas Huth wrote:
> If we do not provide the PVR for POWER8NVL, a guest on this
> system currently ends up in PowerISA 2.06 compatibility mode on
> KVM, since QEMU does not provide a generic PowerISA 2.07 mode yet.
> So some new instructions from POWER8 (like "mtvsrd") get disabled
> for the guest, resulting in crashes when using code compiled
> explicitly for POWER8 (e.g. with the "-mcpu=power8" option of GCC).
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/7cc851039d643a2ee7df4d1817

cheers
