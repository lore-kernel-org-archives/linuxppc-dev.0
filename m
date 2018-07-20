Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Ww1q1DV2zDqHw
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jul 2018 12:34:07 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>, "Linux Kernel
 Mailing List" <linux-kernel@vger.kernel.org>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>, Paul Mackerras <paulus@ozlabs.org>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: Re: linux-next: manual merge of the powerpc tree with the
 powerpc-fixes tree
In-Reply-To: <20180720095138.275cc9aa@canb.auug.org.au>
References: <20180720095138.275cc9aa@canb.auug.org.au>
Date: Fri, 20 Jul 2018 12:34:06 +1000
Message-ID: <87r2jybppd.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> Hi all,
>
> Today's linux-next merge of the powerpc tree got a conflict in:
>
>   drivers/vfio/vfio_iommu_spapr_tce.c
>
> between commit:
>
>   1463edca6734 ("vfio/spapr: Use IOMMU pageshift rather than pagesize")
>
> from the powerpc-fixes tree and commit:
>
>   00a5c58d9499 ("KVM: PPC: Make iommu_table::it_userspace big endian")
>
> from the powerpc tree.

Thanks.

That has turned into a real mess, with conflicting code in next, fixes
and topic/ppc-kvm.

I'll fix it all up before the merge window.

cheers
