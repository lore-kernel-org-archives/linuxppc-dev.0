Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id ED76D1A170D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Aug 2014 22:16:44 +1000 (EST)
Message-ID: <53FDCC2A.4050708@suse.de>
Date: Wed, 27 Aug 2014 14:16:42 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Mihai Caraman <mihai.caraman@freescale.com>, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH v4 0/6] KVM: PPC: Book3e: AltiVec support
References: <1408541787-24625-1-git-send-email-mihai.caraman@freescale.com>
In-Reply-To: <1408541787-24625-1-git-send-email-mihai.caraman@freescale.com>
Content-Type: text/plain; charset=windows-1252
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 20.08.14 15:36, Mihai Caraman wrote:
> Add KVM Book3e AltiVec support.
> 
> Changes:
> 
> v4:
>  - use CONFIG_SPE_POSSIBLE and a new ifdef for CONFIG_ALTIVEC
>  - remove SPE handlers from bookehv
>  - split ONE_REG powerpc generic and ONE_REG AltiVec
>  - add setters for IVPR, IVOR2 and IVOR8
>  - add api documentation for ONE_REG IVPR and IVORs
>  - don't enable e6500 core since hardware threads are not yet supported
> 
> v3:
>  - use distinct SPE/AltiVec exception handlers
>  - make ONE_REG AltiVec support powerpc generic
>  - add ONE_REG IVORs support
> 
>  v2:
>  - integrate Paul's FP/VMX/VSX changes that landed in kvm-ppc-queue
>    in January and take into account feedback
> 
> Mihai Caraman (6):
>   KVM: PPC: Book3E: Increase FPU laziness
>   KVM: PPC: Book3e: Add AltiVec support
>   KVM: PPC: Make ONE_REG powerpc generic
>   KVM: PPC: Move ONE_REG AltiVec support to powerpc
>   KVM: PPC: Booke: Add setter functions for IVPR, IVOR2 and IVOR8
>     emulation
>   KVM: PPC: Booke: Add ONE_REG support for IVPR and IVORs

Thanks, applied 1-4 to kvm-ppc-queue.


Alex
