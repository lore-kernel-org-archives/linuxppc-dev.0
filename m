Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qq12v6STQzDqCn
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 20:09:43 +1000 (AEST)
In-Reply-To: <20160415120819.7144900c@kryten>
To: Unknown sender due to SPF <linuxppc-dev@lists.ozlabs.org>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, Paul Mackerras <paulus@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Neuling <mikey@neuling.org>,
 David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: qemu-ppc@nongnu.org, linuxppc-dev@lists.ozlabs.org, qemu-devel@nongnu.org
Subject: Re: [3/3] powerpc: Update TM user feature bits in scan_features()
Message-Id: <3qq12v5RT2z9t8p@ozlabs.org>
Date: Tue, 19 Apr 2016 20:09:43 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-15-04 at 02:08:19 UTC, Unknown sender due to SPF wrote:
> We need to update the user TM feature bits (PPC_FEATURE2_HTM and
> PPC_FEATURE2_HTM) to mirror what we do with the kernel TM feature
> bit.
> 
> At the moment, if firmware reports TM is not available we turn off
> the kernel TM feature bit but leave the userspace ones on. Userspace
> thinks it can execute TM instructions and it dies trying.
> 
> This (together with a QEMU patch) fixes PR KVM, which doesn't currently
> support TM.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>
> Cc: stable@vger.kernel.org

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/4705e02498d6d5a7ab98dfee95

cheers
