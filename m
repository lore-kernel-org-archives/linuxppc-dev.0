Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41VnMm65nqzF3Hf
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jul 2018 16:30:44 +1000 (AEST)
Date: Wed, 18 Jul 2018 16:30:40 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: wei.guo.simon@gmail.com
Cc: kvm-ppc@vger.kernel.org, kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] KVM: PPC: remove mmio_vsx_tx_sx_enabled in KVM MMIO
 emulation
Message-ID: <20180718063040.GE27453@fergus>
References: <1527472106-22682-1-git-send-email-wei.guo.simon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1527472106-22682-1-git-send-email-wei.guo.simon@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, May 28, 2018 at 09:48:26AM +0800, wei.guo.simon@gmail.com wrote:
> From: Simon Guo <wei.guo.simon@gmail.com>
> 
> Originally PPC KVM MMIO emulation uses only 0~31#(5 bits) for VSR
> reg number, and use mmio_vsx_tx_sx_enabled field together for
> 0~63# VSR regs.
> 
> Currently PPC KVM MMIO emulation is reimplemented with analyse_instr()
> assistence. analyse_instr() returns 0~63 for VSR register number, so
> it is not necessary to use additional mmio_vsx_tx_sx_enabled field
> any more.
> 
> This patch extends related reg bits(expand io_gpr to u16 from u8
> and use 6 bits for VSR reg#), so that mmio_vsx_tx_sx_enabled can
> be removed.
> 
> v1 -> v2 change:
> rework the commit message to remove "PR KVM" specific word.
> 
> Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>

Thanks, patch applied to my kvm-ppc-next branch.

Paul.
