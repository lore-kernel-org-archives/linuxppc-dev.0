Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D1B821A095A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jul 2014 23:08:13 +1000 (EST)
Message-ID: <53D10537.8030906@suse.de>
Date: Thu, 24 Jul 2014 15:08:07 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Mihai Caraman <mihai.caraman@freescale.com>, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH v6 0/5] Read guest last instruction from
 kvmppc_get_last_inst()
References: <1406131582-6052-1-git-send-email-mihai.caraman@freescale.com>
In-Reply-To: <1406131582-6052-1-git-send-email-mihai.caraman@freescale.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 23.07.14 18:06, Mihai Caraman wrote:
> Read guest last instruction from kvmppc_get_last_inst() allowing the function
> to fail in order to emulate again. On bookehv architecture search for
> the physical address and kmap it, instead of using Load External PID (lwepx)
> instruction. This fixes an infinite loop caused by lwepx's data TLB miss
> exception handled in the host and the TODO for execute-but-not-read entries
> and TLB eviction.
>
> Mihai Caraman (5):
>    KVM: PPC: e500mc: Revert "add load inst fixup"
>    KVM: PPC: Book3e: Add TLBSEL/TSIZE defines for MAS0/1
>    KVM: PPC: Book3s: Remove kvmppc_read_inst() function
>    KVM: PPC: Alow kvmppc_get_last_inst() to fail
>    KVM: PPC: Bookehv: Get vcpu's last instruction for emulation

Thanks, applied to kvm-ppc-queue.


Alex
