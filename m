Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D772F1A02DF
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Aug 2015 19:27:01 +1000 (AEST)
In-Reply-To: <20150804111855.9750.86630.stgit@mars>
To: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Jeremy Kerr <jeremy.kerr@au1.ibm.com>
Subject: Re: powernv: Invoke opal_cec_reboot2() on unrecoverable HMI.
Message-Id: <20150810092701.8C0761402BF@ozlabs.org>
Date: Mon, 10 Aug 2015 19:27:01 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-04-08 at 11:18:56 UTC, Mahesh Salgaonkar wrote:
> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> 
> Invoke new opal_cec_reboot2() call with reboot type
> OPAL_REBOOT_PLATFORM_ERROR (for unrecoverable HMI interrupts) to inform
> BMC/OCC about this error, so that BMC can collect relevant data for error
> analysis and decide what component to de-configure before rebooting.
> 
> This patch depends on:
> https://lists.ozlabs.org/pipermail/linuxppc-dev/2015-May/128341.html
> https://lists.ozlabs.org/pipermail/linuxppc-dev/2015-May/128342.html
> https://lists.ozlabs.org/pipermail/linuxppc-dev/2015-August/132045.html
> 
> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/62521ea6db1045a746d4

cheers
