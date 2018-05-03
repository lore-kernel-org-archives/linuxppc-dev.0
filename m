Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40c4sp0gn3zF2Tm
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 May 2018 16:26:22 +1000 (AEST)
Date: Thu, 3 May 2018 15:59:02 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: wei.guo.simon@gmail.com
Cc: kvm-ppc@vger.kernel.org, kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 06/11] KVM: PPC: add KVMPPC_VSX_COPY_WORD_LOAD_DUMP type
 support for mmio emulation
Message-ID: <20180503055902.GG6795@fergus.ozlabs.ibm.com>
References: <1524657284-16706-1-git-send-email-wei.guo.simon@gmail.com>
 <1524657284-16706-7-git-send-email-wei.guo.simon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1524657284-16706-7-git-send-email-wei.guo.simon@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 25, 2018 at 07:54:39PM +0800, wei.guo.simon@gmail.com wrote:
> From: Simon Guo <wei.guo.simon@gmail.com>
> 
> Some VSX instruction like lxvwsx will splat word into VSR. This patch
> adds VSX copy type KVMPPC_VSX_COPY_WORD_LOAD_DUMP to support this.
> 
> Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>

Reviewed-by: Paul Mackerras <paulus@ozlabs.org>
