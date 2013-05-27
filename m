Return-Path: <aik@ozlabs.ru>
Received: from mail-pd0-f170.google.com (mail-pd0-f170.google.com
 [209.85.192.170])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A34042C02F7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 May 2013 00:33:34 +1000 (EST)
Received: by mail-pd0-f170.google.com with SMTP id x10so6530618pdj.29
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 May 2013 07:33:32 -0700 (PDT)
Message-ID: <51A36EB4.9010305@ozlabs.ru>
Date: Tue, 28 May 2013 00:33:24 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 1/4] KVM: PPC: Add support for multiple-TCE hcalls
References: <1369105607-20957-1-git-send-email-aik@ozlabs.ru>
 <1369105607-20957-2-git-send-email-aik@ozlabs.ru>
 <51A330AB.8060805@redhat.com>
In-Reply-To: <51A330AB.8060805@redhat.com>
Content-Type: text/plain; charset=KOI8-R
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
 Alexander Graf <agraf@suse.de>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/27/2013 08:08 PM, Paolo Bonzini wrote:
> Il 21/05/2013 05:06, Alexey Kardashevskiy ha scritto:
>> This adds real mode handlers for the H_PUT_TCE_INDIRECT and
>> H_STUFF_TCE hypercalls for QEMU emulated devices such as virtio
>> devices or emulated PCI.
> 
> Do you mean vio?  virtio (without getting into whether that's good or
> bad) will bypass the iommu.

yes, mistake, should be VIO. thanks!


-- 
Alexey
