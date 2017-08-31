Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xjSsj53NZzDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 13:44:09 +1000 (AEST)
Date: Thu, 31 Aug 2017 13:41:39 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH v2 1/9] KVM: PPC: Book3S HV: Fix H_REGISTER_VPA VPA size
 validation
Message-ID: <20170831034139.GC22549@fergus.ozlabs.ibm.com>
References: <20170812113416.15978-1-npiggin@gmail.com>
 <20170813013346.14002-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170813013346.14002-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Aug 13, 2017 at 11:33:38AM +1000, Nicholas Piggin wrote:
> KVM currently validates the size of the VPA registered by the client
> against sizeof(struct lppaca), however we align (and therefore size)
> that struct to 1kB to avoid crossing a 4kB boundary in the client.
> 
> PAPR calls for sizes >= 640 bytes to be accepted. Hard code this with
> a comment.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Thanks, patch applied to my kvm-ppc-next branch.

Paul.
