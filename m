Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40sV8V3VVqzF1D8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 12:10:34 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id p21-v6so1593152pgd.11
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 May 2018 19:10:34 -0700 (PDT)
Date: Thu, 24 May 2018 17:21:22 +0800
From: Simon Guo <wei.guo.simon@gmail.com>
To: kvm-ppc@vger.kernel.org
Cc: Paul Mackerras <paulus@ozlabs.org>, kvm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] KVM: PPC: remove mmio_vsx_tx_sx_enabled in PR KVM MMIO
 emulation
Message-ID: <20180524092122.GD2498@simonLocalRHEL7.x64>
References: <1527152486-13843-1-git-send-email-wei.guo.simon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1527152486-13843-1-git-send-email-wei.guo.simon@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 24, 2018 at 05:01:26PM +0800, wei.guo.simon@gmail.com wrote:
> From: Simon Guo <wei.guo.simon@gmail.com>
> 
> Originally PR KVM MMIO emulation uses only 0~31#(5 bits) for VSR
> reg number, and use mmio_vsx_tx_sx_enabled field together for
> 0~63# VSR regs.
> 
> Currently PR KVM MMIO emulation is reimplemented with analyse_instr()
> assistence. analyse_instr() returns 0~63 for VSR register number, so
> it is not necessary to use additional mmio_vsx_tx_sx_enabled field
> any more.
> 
> This patch extends related reg bits(expand io_gpr to u16 from u8
> and use 6 bits for VSR reg#), so that mmio_vsx_tx_sx_enabled can
> be removed.
> 
> Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>

It applies to HV KVM too. I will correct the commit message in next 
version.

Thanks,
- Simon
