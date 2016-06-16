Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rVkCQ05Q8zDqlQ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jun 2016 23:05:54 +1000 (AEST)
In-Reply-To: <1464007742-1941-1-git-send-email-felix@linux.vnet.ibm.com>
To: Philippe Bergheaud <felix@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: mikey@neuling.org, mrochs@linux.vnet.ibm.com, manoj@linux.vnet.ibm.com,
 imunsie@au1.ibm.com, Philippe Bergheaud <felix@linux.vnet.ibm.com>
Subject: Re: [v5,
 1/2] cxl: Add mechanism for delivering AFU driver specific events
Message-Id: <3rVkCP66Gbz9t0G@ozlabs.org>
Date: Thu, 16 Jun 2016 23:05:53 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-23-05 at 12:49:01 UTC, Philippe Bergheaud wrote:
> This adds an afu_driver_ops structure with deliver_event() and
> event_delivered() callbacks. An AFU driver such as cxlflash can fill
> this out and associate it with a context to enable passing custom
> AFU specific events to userspace.
> 
> This also adds a new kernel API function cxl_context_pending_events(),
> that the AFU driver can use to notify the cxl driver that new specific
> events are ready to be delivered, and wake up anyone waiting on the
> context wait queue.
...
> 
> Signed-off-by: Philippe Bergheaud <felix@linux.vnet.ibm.com>

It looks like the discussion has settled down on this one, and everyone was OK
with it, except maybe the naming?

So can we either get some ACKs, or a v6 with new naming?

cheers
