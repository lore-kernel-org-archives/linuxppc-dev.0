Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D95931A119C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Dec 2015 21:19:12 +1100 (AEDT)
In-Reply-To: <1449796103-7700-1-git-send-email-stewart@linux.vnet.ibm.com>
To: Stewart Smith <stewart@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: =?UTF-8?q?=E8=92=B2=E6=96=87?= <wen.pu@powercore.com.cn>
Subject: Re: powerpc/powernv: pr_warn_once on unsupported OPAL_MSG type
Message-Id: <20151217101912.B369A1402EC@ozlabs.org>
Date: Thu, 17 Dec 2015 21:19:12 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-11-12 at 01:08:23 UTC, Stewart Smith wrote:
> When running on newer OPAL firmware that supports sending extra
> OPAL_MSG types, we would print a warning on *every* message received.
> 
> This could be a problem for kernels that don't support OPAL_MSG_OCC
> on machines that are running real close to thermal limits and the
> OCC is throttling the chip. For a kernel that is paying attention to
> the message queue, we could get these notifications quite often.
> 
> Conceivably, future message types could also come fairly often,
> and printing that we didn't understand them 10,000 times provides
> no further information than printing them once.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Stewart Smith <stewart@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/98da62b716a3b24ab8e77453

cheers
