Return-Path: <thuth@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tgDss3cz6zDwCD
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Dec 2016 02:35:45 +1100 (AEDT)
Subject: Re: [PATCH 08/11] powerpc/kvm: KVM-HV HPT resizing stub implementation
To: David Gibson <david@gibson.dropbear.id.au>, paulus@samba.org
References: <20161215055404.29351-1-david@gibson.dropbear.id.au>
 <20161215055404.29351-9-david@gibson.dropbear.id.au>
Cc: michael@ellerman.id.au, benh@kernel.crashing.org, sjitindarsingh@gmail.com,
 lvivier@redhat.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b4128be7-2e3d-f483-7d33-ab23ed70c0cf@redhat.com>
Date: Fri, 16 Dec 2016 16:35:39 +0100
MIME-Version: 1.0
In-Reply-To: <20161215055404.29351-9-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 15.12.2016 06:54, David Gibson wrote:
> This patch adds a stub (always failing) implementation of the ioctl()s
> for the HPT resizing PAPR extension.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  arch/powerpc/include/asm/kvm_ppc.h  |  4 ++++
>  arch/powerpc/kvm/book3s_64_mmu_hv.c | 16 ++++++++++++++++
>  arch/powerpc/kvm/book3s_hv.c        | 22 ++++++++++++++++++++++
>  3 files changed, 42 insertions(+)

I think I'd just squash this with the patch where you do the real
implementation.

 Thomas
