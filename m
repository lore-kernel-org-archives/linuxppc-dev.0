Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4AC591A02BF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2015 18:38:13 +1000 (AEST)
In-Reply-To: <1440002994-25662-2-git-send-email-hegdevasant@linux.vnet.ibm.com>
To: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>, linux-leds@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: stewart@linux.vnet.ibm.com, j.anaszewski81@gmail.com, arnd@arndb.de,
 cooloney@gmail.com, Vasant Hegde <hegdevasant@linux.vnet.ibm.com>,
 rpurdie@rpsys.net, j.anaszewski@samsung.com, khandual@linux.vnet.ibm.com
Subject: Re: [v10,
 1/3] powerpc/powernv: Add OPAL interfaces for accessing and modifying
 system LED states
Message-Id: <20150820083813.24B711402A2@ozlabs.org>
Date: Thu, 20 Aug 2015 18:38:13 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-19-08 at 16:49:52 UTC, Vasant Hegde wrote:
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
> Acked-by: Stewart Smith <stewart@linux.vnet.ibm.com>
> Tested-by: Stewart Smith <stewart@linux.vnet.ibm.com>
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/8a8d91817aec6b9ca7a2

cheers
