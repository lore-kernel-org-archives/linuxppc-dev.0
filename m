Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vTVMN6DmvzDqH1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2017 21:09:20 +1100 (AEDT)
Received: by mail-pf0-x244.google.com with SMTP id p185so1352056pfb.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2017 02:09:20 -0800 (PST)
Subject: Re: [PATCH v2] KVM: PPC: Book3S: Ratelimit copy data failure error
 messages
To: Vipin K Parashar <vipin@linux.vnet.ibm.com>, kvm-ppc@vger.kernel.org
References: <1487265026-25473-1-git-send-email-vipin@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <321b2be9-788d-3ace-9e24-4014596ae55a@gmail.com>
Date: Thu, 23 Feb 2017 21:08:49 +1100
MIME-Version: 1.0
In-Reply-To: <1487265026-25473-1-git-send-email-vipin@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 17/02/17 04:10, Vipin K Parashar wrote:
> kvm_ppc_mmu_book3s_32/64 xlat() logs "KVM can't copy data" error
> upon failing to copy user data to kernel space. This floods kernel
> log once such fails occur in short time period. Ratelimit this
> error to avoid flooding kernel logs upon copy data failures.
> 
> Signed-off-by: Vipin K Parashar <vipin@linux.vnet.ibm.com>
> ---

What causes the flooding, can it be triggered on demand from user
space? I presume you'll need to have permissions to /dev/kvm to
trigger it? Could you clarify the scope, is it just called
during emulation with KVM_PR?

Balbir Singh.
