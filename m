Return-Path: <ruscur@russell.cc>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Kw5G49NzzF1QS
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Apr 2018 15:02:10 +1000 (AEST)
Message-ID: <1523336524.3046.3.camel@russell.cc>
Subject: Re: [PATCH 2/6] powerpc/powernv: Implement and use opal_flush_console
From: Russell Currey <ruscur@russell.cc>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Date: Tue, 10 Apr 2018 15:02:04 +1000
In-Reply-To: <20180409054056.27292-3-npiggin@gmail.com>
References: <20180409054056.27292-1-npiggin@gmail.com>
 <20180409054056.27292-3-npiggin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2018-04-09 at 15:40 +1000, Nicholas Piggin wrote:
> A new console flushing firmware API was introduced to replace event
> polling loops, and implemented in opal-kmsg with affddff69c55e
> ("powerpc/powernv: Add a kmsg_dumper that flushes console output on
> panic"), to flush the console in the panic path.
> 
> The OPAL console driver has other situations where interrupts are off
> and it needs to flush the console synchronously. These still use a
> polling loop.
> 
> So move the opal-kmsg flush code to opal_flush_console, and use the
> new function in opal-kmsg and opal_put_chars.
> 
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Russell Currey <ruscur@russell.cc>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Reviewed-by: Russell Currey <ruscur@russell.cc>
