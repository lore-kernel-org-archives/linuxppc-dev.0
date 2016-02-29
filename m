Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8C2E41A0035
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Feb 2016 22:01:44 +1100 (AEDT)
In-Reply-To: <1456334871-30397-1-git-send-email-fbarrat@linux.vnet.ibm.com>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>, imunsie@au1.ibm.com,
 michael.neuling@au1.ibm.com, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: cxl: Fix PSL timebase synchronization detection
Message-Id: <20160229110144.6415A140324@ozlabs.org>
Date: Mon, 29 Feb 2016 22:01:44 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-24-02 at 17:27:51 UTC, Frederic Barrat wrote:
> The PSL timebase synchronization is seemingly failing for
> configuration not including VIRT_CPU_ACCOUNTING_NATIVE. The driver
> shows the following trace in dmesg:
> PSL: Timebase sync: giving up!
> 
> The PSL timebase register is actually syncing correctly, but the cxl
> driver is not detecting it. Fix is to use the proper timebase-to-time
> conversion.
> 
> Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> Cc: <stable@vger.kernel.org> # 4.3+
> Acked-by: Michael Neuling <mikey@neuling.org>
> Reviewed-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
> Acked-by: Ian Munsie <imunsie@au1.ibm.com>
> Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> Reviewed-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/923adb1646d5ba739d2a1e63ee

cheers
