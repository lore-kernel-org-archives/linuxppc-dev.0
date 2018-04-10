Return-Path: <ruscur@russell.cc>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Kw4X3wyyzF1R7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Apr 2018 15:01:32 +1000 (AEST)
Message-ID: <1523336485.3046.2.camel@russell.cc>
Subject: Re: [PATCH 1/6] powerpc/powernv: opal-kmsg use flush fallback from
 console code
From: Russell Currey <ruscur@russell.cc>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Date: Tue, 10 Apr 2018 15:01:25 +1000
In-Reply-To: <20180409054056.27292-2-npiggin@gmail.com>
References: <20180409054056.27292-1-npiggin@gmail.com>
 <20180409054056.27292-2-npiggin@gmail.com>
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
> Use the more refined and tested event polling loop from
> opal_put_chars
> as the fallback console flush in the opal-kmsg path. This loop is
> used
> by the console driver today, whereas the opal-kmsg fallback is not
> likely to have been used for years.
> 
> Use WARN_ONCE rather than a printk when the fallback is invoked to
> prepare for moving the console flush into a common function.
> 
> Cc: Russell Currey <ruscur@russell.cc>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Reviewed-by: Russell Currey <ruscur@russell.cc>
