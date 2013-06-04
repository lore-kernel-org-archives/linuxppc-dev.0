Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe003.messaging.microsoft.com [207.46.163.26])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CA5182C00A1
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Jun 2013 07:39:35 +1000 (EST)
Date: Tue, 4 Jun 2013 16:39:19 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [RFC PATCH 0/6] KVM: PPC: Book3E: AltiVec support
To: Mihai Caraman <mihai.caraman@freescale.com>
In-Reply-To: <1370292868-2697-1-git-send-email-mihai.caraman@freescale.com>
 (from mihai.caraman@freescale.com on Mon Jun  3 15:54:22 2013)
Message-ID: <1370381959.748.16@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 Alexander Graf <agraf@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/03/2013 03:54:22 PM, Mihai Caraman wrote:
> Mihai Caraman (6):
>   KVM: PPC: Book3E: Fix AltiVec interrupt numbers and build breakage
>   KVM: PPC: Book3E: Refactor SPE_FP exit handling
>   KVM: PPC: Book3E: Rename IRQPRIO names to accommodate ALTIVEC
>   KVM: PPC: Book3E: Add AltiVec support
>   KVM: PPC: Book3E: Add ONE_REG AltiVec support
>   KVM: PPC: Book3E: Enhance FPU laziness
>=20
>  arch/powerpc/include/asm/kvm_asm.h    |   16 ++-
>  arch/powerpc/kvm/booke.c              |  189 =20
> ++++++++++++++++++++++++++++----
>  arch/powerpc/kvm/booke.h              |    4 +-
>  arch/powerpc/kvm/bookehv_interrupts.S |    8 +-
>  arch/powerpc/kvm/e500.c               |   10 +-
>  arch/powerpc/kvm/e500_emulate.c       |    8 +-
>  arch/powerpc/kvm/e500mc.c             |   10 ++-
>  7 files changed, 199 insertions(+), 46 deletions(-)

This looks like a bit much for 3.10 (certainly, subject lines like =20
"refactor" and "enhance" and "add support" aren't going to make Linus =20
happy given that we're past rc4) so I think we should apply =20
http://patchwork.ozlabs.org/patch/242896/ for 3.10.  Then for 3.11, =20
revert it after applying this patchset.

-Scott=
