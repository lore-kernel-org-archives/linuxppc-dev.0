Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yHZfy6blzzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 14:49:14 +1100 (AEDT)
Date: Thu, 19 Oct 2017 14:48:41 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH kernel] KVM: PPC: Enable in-kernel TCE handlers for PR KVM
Message-ID: <20171019034841.GE3492@fergus.ozlabs.ibm.com>
References: <20171011050108.37980-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171011050108.37980-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 11, 2017 at 04:01:08PM +1100, Alexey Kardashevskiy wrote:
> The handlers support PR KVM from the day one; however the PR KVM's
> enable/disable hcalls handler missed these ones.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Thanks, applied to my kvm-ppc-next branch.

Paul.
