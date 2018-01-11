Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zHLy95Q5czF0XF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jan 2018 21:01:53 +1100 (AEDT)
Date: Thu, 11 Jan 2018 20:57:07 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, LKML <linux-kernel@vger.kernel.org>,
 kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] KVM: PPC: Use seq_puts() in kvmppc_exit_timing_show()
Message-ID: <20180111095707.GI24294@fergus.ozlabs.ibm.com>
References: <6f07cc84-cd86-8e48-5da2-edb86f466243@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6f07cc84-cd86-8e48-5da2-edb86f466243@users.sourceforge.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Jan 07, 2018 at 10:18:08AM +0100, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 7 Jan 2018 10:07:36 +0100
> 
> A headline should be quickly put into a sequence. Thus use the
> function "seq_puts" instead of "seq_printf" for this purpose.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Thanks, applied to my kvm-ppc-next branch.

Paul.
