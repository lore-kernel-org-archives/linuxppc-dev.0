Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id C4E2A2C00BF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2013 23:48:30 +1000 (EST)
Subject: Re: [PATCH 0/8 v3] KVM: PPC: e500: Enable FSL e6500 core
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1365674594-17410-1-git-send-email-mihai.caraman@freescale.com>
Date: Fri, 26 Apr 2013 15:48:27 +0200
Message-Id: <67BD6E3B-9671-428F-BFD4-C90D02D007F9@suse.de>
References: <1365674594-17410-1-git-send-email-mihai.caraman@freescale.com>
To: Mihai Caraman <mihai.caraman@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 11.04.2013, at 12:03, Mihai Caraman wrote:

> Enable basic support for Freescale e6500 core, adding MAV 2.0 support.
> Validated on T4240QDS platfrom. Altivec, Multithreading and HW =
Tablewalk
> are not addressed by this patchset.

Thanks, applied all to kvm-ppc-queue.


Alex

>=20
> Mihai Caraman (8):
>  KVM: PPC: Book3E: Refactor ONE_REG ioctl implementation
>  KVM: PPC: e500: Expose MMU registers via ONE_REG
>  KVM: PPC: e500: Move vcpu's MMU configuration to dedicated functions
>  KVM: PPC: e500: Add support for TLBnPS registers
>  KVM: PPC: e500: Add support for EPTCFG register
>  KVM: PPC: e500: Remove E.PT and E.HV.LRAT categories from VCPUs
>  KVM: PPC: e500mc: Enable e6500 cores
>  KVM: PPC: e500: Add e6500 core to Kconfig description
>=20
> Documentation/virtual/kvm/api.txt   |   16 +++
> arch/powerpc/include/asm/kvm_host.h |    2 +
> arch/powerpc/include/uapi/asm/kvm.h |   22 ++++
> arch/powerpc/kvm/44x.c              |   12 ++
> arch/powerpc/kvm/Kconfig            |    6 +-
> arch/powerpc/kvm/booke.c            |  102 ++++++++++---------
> arch/powerpc/kvm/e500.c             |   14 +++
> arch/powerpc/kvm/e500.h             |   22 ++++
> arch/powerpc/kvm/e500_emulate.c     |   19 ++++
> arch/powerpc/kvm/e500_mmu.c         |  192 =
+++++++++++++++++++++++++++++++----
> arch/powerpc/kvm/e500mc.c           |   16 +++
> 11 files changed, 351 insertions(+), 72 deletions(-)
>=20
> --=20
> 1.7.4.1
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe kvm-ppc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
