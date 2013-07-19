Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-f52.google.com (mail-pa0-f52.google.com
 [209.85.220.52])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 459552C0090
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jul 2013 14:13:15 +1000 (EST)
Received: by mail-pa0-f52.google.com with SMTP id kq12so621756pab.25
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jul 2013 21:13:12 -0700 (PDT)
Message-ID: <51E8BCD0.8050101@ozlabs.ru>
Date: Fri, 19 Jul 2013 14:13:04 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 00/10 v6] KVM: PPC: IOMMU in-kernel handling
References: <1373936045-22653-1-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1373936045-22653-1-git-send-email-aik@ozlabs.ru>
Content-Type: text/plain; charset=KOI8-R
Cc: kvm@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/16/2013 10:53 AM, Alexey Kardashevskiy wrote:
> The changes are:
> 1. rebased on v3.11-rc1 so the capability numbers changed again
> 2. fixed multiple comments from maintainers
> 3. "KVM: PPC: Add support for IOMMU in-kernel handling" is split into
> 2 patches, the new one is "powerpc/iommu: rework to support realmode".
> 4. IOMMU_API is now always enabled for KVM_BOOK3S_64.
> 
> MOre details in the individual patch comments.
> 
> Depends on "hashtable: add hash_for_each_possible_rcu_notrace()",
> posted a while ago.
> 
> 
> Alexey Kardashevskiy (10):
>   KVM: PPC: reserve a capability number for multitce support
>   KVM: PPC: reserve a capability and ioctl numbers for realmode VFIO



Alex, could you please pull these 2 patches or tell what is wrong with
them? Having them sooner in the kernel would let me ask for a headers
update for QEMU and then I would try pushing miltiple TCE and VFIO support
in QEMU. Thanks.




-- 
Alexey
