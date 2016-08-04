Return-Path: <gregkh@linuxfoundation.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s4jCr5w48zDqS9
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Aug 2016 18:05:12 +1000 (AEST)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3s4jCr3jYZz9sBR
 for <linuxppc-dev@ozlabs.org>; Thu,  4 Aug 2016 18:05:11 +1000 (AEST)
Date: Thu, 4 Aug 2016 10:05:21 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Paul Mackerras <paulus@samba.org>, stable@vger.kernel.org
Subject: Re: [PATCH] powerpc/book3s: Fix MCE console messages for
 unrecoverable MCE.
Message-ID: <20160804080521.GA19251@kroah.com>
References: <147028600879.16761.7577655191376075114.stgit@jupiter.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <147028600879.16761.7577655191376075114.stgit@jupiter.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 04, 2016 at 10:16:48AM +0530, Mahesh J Salgaonkar wrote:
> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> 
> When machine check occurs with MSR(RI=0), it means MC interrupt is
> unrecoverable and kernel goes down to panic path. But the console
> message still shows it as recovered. This patch fixes the MCE console
> messages.
> 
> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/mce.c             |    3 ++-
>  arch/powerpc/platforms/powernv/opal.c |    2 ++
>  2 files changed, 4 insertions(+), 1 deletion(-)


<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read Documentation/stable_kernel_rules.txt
for how to do this properly.

</formletter>
