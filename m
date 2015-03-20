Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 771141A1087
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2015 17:23:45 +1100 (AEDT)
Message-ID: <1426832625.2581.3.camel@ellerman.id.au>
Subject: Re: [PATCH 1/2] powerpc/powernv: Add OPAL interfaces for accessing
 and modifying system LED states
From: Michael Ellerman <mpe@ellerman.id.au>
To: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Date: Fri, 20 Mar 2015 17:23:45 +1100
In-Reply-To: <20150308111408.3759.70606.stgit@localhost.localdomain>
References: <20150308110558.3759.72635.stgit@localhost.localdomain>
 <20150308111408.3759.70606.stgit@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: cooloney@gmail.com, rpurdie@rpsys.net, linuxppc-dev@lists.ozlabs.org,
 linux-leds@vger.kernel.org, khandual@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2015-03-08 at 16:44 +0530, Vasant Hegde wrote:
> From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> 
> This patch registers the following two new OPAL interfaces calls
> for the platform LED subsystem. With the help of these new OPAL calls,
> the kernel will be able to get or set the state of various individual
> LEDs on the system at any given location code which is passed through
> the LED specific device tree nodes.
> 
> 	(1) OPAL_LEDS_GET_INDICATOR     opal_leds_get_ind
> 	(2) OPAL_LEDS_SET_INDICATOR     opal_leds_set_ind
> 
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> Signed-off-by: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/opal.h                |   19 +++++++++++++------

We've split opal.h in next.

Can you please rebase on top of it:

https://git.kernel.org/cgit/linux/kernel/git/mpe/linux.git/log/?h=next


cheers
