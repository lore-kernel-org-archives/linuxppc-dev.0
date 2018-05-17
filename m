Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40mWlQ6kbZzF14v
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 May 2018 10:05:06 +1000 (AEST)
Date: Thu, 17 May 2018 10:04:37 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: wei.guo.simon@gmail.com
Cc: kvm-ppc@vger.kernel.org, kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 00/10] KVM: PPC: reimplement mmio emulation with
 analyse_instr()
Message-ID: <20180517000437.GD24778@fergus.ozlabs.ibm.com>
References: <1525674016-6703-1-git-send-email-wei.guo.simon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1525674016-6703-1-git-send-email-wei.guo.simon@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, May 07, 2018 at 02:20:06PM +0800, wei.guo.simon@gmail.com wrote:
> From: Simon Guo <wei.guo.simon@gmail.com>
> 
> We already have analyse_instr() which analyzes instructions for the instruction
> type, size, addtional flags, etc. What kvmppc_emulate_loadstore() did is somehow
> duplicated and it will be good to utilize analyse_instr() to reimplement the
> code. The advantage is that the code logic will be shared and more clean to be 
> maintained.
> 
> This patch series reimplement kvmppc_emulate_loadstore() for various load/store
> instructions. 
> 
> The testcase locates at:
> https://github.com/justdoitqd/publicFiles/blob/master/test_mmio.c
> 
> - Tested at both PR/HV KVM. 
> - Also tested with little endian host & big endian guest.

This series looks good.  I have just a couple of comments on two of
the patches.

Thanks,
Paul.
