Return-Path: <aik@ozlabs.ru>
Received: from mail-ob0-x235.google.com (mail-ob0-x235.google.com
 [IPv6:2607:f8b0:4003:c01::235])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7B00E2C0691
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 May 2013 13:35:00 +1000 (EST)
Received: by mail-ob0-f181.google.com with SMTP id dn14so186602obc.12
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 May 2013 20:34:57 -0700 (PDT)
Message-ID: <519AEB59.4040105@ozlabs.ru>
Date: Tue, 21 May 2013 13:34:49 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH 0/5 v2] VFIO PPC64: add VFIO support on POWERPC64
References: <1369107191-28547-1-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1369107191-28547-1-git-send-email-aik@ozlabs.ru>
Content-Type: text/plain; charset=KOI8-R
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
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

Oops, wrong subject (cut-n-paste) :)
There are 3 patches, not 5.


On 05/21/2013 01:33 PM, Alexey Kardashevskiy wrote:
> The series adds support for VFIO on POWERPC in user space (such as QEMU).
> The in-kernel real mode IOMMU support is added by another series posted
> separately.
> 
> As the first and main aim of this series is the POWERNV platform support,
> the "Enable on POWERNV platform" patch goes first and introduces an API
> to be used by the VFIO IOMMU driver. The "Enable on pSeries platform" patch
> simply registers PHBs in the IOMMU subsystem and expects the API to be present,
> it enables VFIO support in fully emulated QEMU guests.
> 
> The main change is that this series was changed and tested against v3.10-rc1.
> It also contains some bugfixes which are mentioned (if any) in the patch messages.
> 
> Alexey Kardashevskiy (3):
>   powerpc/vfio: Enable on POWERNV platform
>   powerpc/vfio: Implement IOMMU driver for VFIO
>   powerpc/vfio: Enable on pSeries platform


-- 
Alexey
