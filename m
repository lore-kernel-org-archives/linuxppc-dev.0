Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sXTvS6C0WzDsF3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Sep 2016 10:58:28 +1000 (AEST)
Date: Mon, 12 Sep 2016 10:54:37 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Alexander Graf <agraf@suse.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paolo Bonzini <pbonzini@redhat.com>,
 Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
 LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH 0/6] KVM: PPC: e500: Fine-tuning for two function
 implementations
Message-ID: <20160912005437.GC9873@fergus.ozlabs.ibm.com>
References: <566ABCD9.1060404@users.sourceforge.net>
 <c3fd4483-38d2-af0f-0e19-a7e57e120c5b@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c3fd4483-38d2-af0f-0e19-a7e57e120c5b@users.sourceforge.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Aug 28, 2016 at 07:09:57PM +0200, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 28 Aug 2016 19:01:02 +0200
> 
> Several update suggestions were taken into account
> from static source code analysis.
> 
> Markus Elfring (6):
>   Use kmalloc_array() in kvm_vcpu_ioctl_config_tlb()
>   Less function calls in kvm_vcpu_ioctl_config_tlb() after error detection
>   Delete an unnecessary initialisation in kvm_vcpu_ioctl_config_tlb()
>   Replace kzalloc() calls by kcalloc() in two functions
>   Use kmalloc_array() in kvmppc_e500_tlb_init()
>   Rename jump labels in kvmppc_e500_tlb_init()

Thanks, patches 1-5 applied to my kvm-ppc-next branch.

Paul.
