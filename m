Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zVGND4l1FzDqlb
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jan 2018 15:13:48 +1100 (AEDT)
In-Reply-To: <20171201213140.GA2776@us.ibm.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: felix@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org,
 clombard@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
 vaibhav@linux.vnet.ibm.com
Subject: Re: [1/1] : powerpc: block interrupts when updating TIDR
Message-Id: <3zVGNC5s53z9t34@ozlabs.org>
Date: Mon, 29 Jan 2018 15:13:47 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-12-01 at 21:31:40 UTC, Sukadev Bhattiprolu wrote:
> From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> Date: Tue, 28 Nov 2017 13:39:43 -0600
> Subject: [PATCH 1/1]: powerpc: block interrupts when updating TIDR
> 
> clear_thread_tidr() is called in interrupt context as a part of delayed
> put of the task structure (i.e as a part of timer interrupt). To prevent
> a deadlock, block interrupts when holding vas_thread_id_lock to set/
> clear TIDR for a task.
> 
> Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/384dfd627f1ee67d028e6f14c6e9bf

cheers
